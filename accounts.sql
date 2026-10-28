-- ============================================================
-- TWC Timer: accounts met unieke namen (Supabase)
-- Plak dit hele bestand in Supabase -> SQL Editor -> New query -> Run
-- ============================================================

-- 1) Tabel met de namen. Elke naam kan maar één keer voorkomen (hoofdletters tellen niet mee).
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  username text not null,
  created_at timestamptz not null default now(),
  constraint username_format check (username ~ '^[A-Za-z0-9_-]{3,20}$')
);

create unique index if not exists profiles_username_unique
  on public.profiles (lower(username));

-- 2) Beveiliging: iedereen mag alleen zijn eigen regel lezen. Aanpassen kan alleen via het account zelf.
alter table public.profiles enable row level security;

drop policy if exists "eigen profiel lezen" on public.profiles;
create policy "eigen profiel lezen" on public.profiles
  for select using (auth.uid() = id);

-- 3) Bij elk nieuw account wordt automatisch een regel met de naam gemaakt.
--    Is de naam al bezet, dan mislukt het maken van het account (zo kunnen twee mensen nooit dezelfde naam krijgen).
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, username)
  values (new.id, new.raw_user_meta_data ->> 'username');
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- 4) Controle of een naam nog vrij is (voor de melding terwijl je typt).
create or replace function public.username_available(name text)
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select not exists (
    select 1 from public.profiles where lower(username) = lower(name)
  );
$$;

grant execute on function public.username_available(text) to anon, authenticated;
