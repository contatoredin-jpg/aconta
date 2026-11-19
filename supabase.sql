-- Aconta · banco na nuvem (Supabase)
-- Cole tudo isto em SQL Editor › New query › Run. Pode rodar mais de uma vez sem problema.

create table if not exists public.aconta_records (
  user_id    uuid        not null default auth.uid() references auth.users(id) on delete cascade,
  id         text        not null,
  data       jsonb       not null,
  deleted    boolean     not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, id)
);

create index if not exists aconta_records_sync on public.aconta_records (user_id, updated_at);

-- a hora da alteração vem do servidor, para celular e PC concordarem
create or replace function public.aconta_touch() returns trigger
language plpgsql as $$
begin
  new.updated_at := clock_timestamp();
  return new;
end $$;

drop trigger if exists aconta_touch on public.aconta_records;
create trigger aconta_touch before insert or update on public.aconta_records
for each row execute function public.aconta_touch();

-- cada pessoa só enxerga e altera os próprios dados
alter table public.aconta_records enable row level security;

drop policy if exists "aconta ler"     on public.aconta_records;
drop policy if exists "aconta inserir" on public.aconta_records;
drop policy if exists "aconta alterar" on public.aconta_records;

create policy "aconta ler"     on public.aconta_records for select using (auth.uid() = user_id);
create policy "aconta inserir" on public.aconta_records for insert with check (auth.uid() = user_id);
create policy "aconta alterar" on public.aconta_records for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
