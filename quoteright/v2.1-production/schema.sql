-- QuoteRight production schema
-- Run in a Supabase SQL Editor after creating the project.

create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  business_name text,
  full_name text,
  phone text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.customers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  email text,
  phone text,
  address text,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.quotes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  customer_id uuid references public.customers(id) on delete set null,
  quote_number bigint generated always as identity,
  project_name text not null,
  status text not null default 'draft' check (status in ('draft','sent','accepted','declined','expired')),
  materials numeric(12,2) not null default 0,
  labour numeric(12,2) not null default 0,
  markup_percent numeric(6,2) not null default 25,
  tax_percent numeric(6,2) not null default 13,
  subtotal numeric(12,2) not null default 0,
  tax numeric(12,2) not null default 0,
  total numeric(12,2) not null default 0,
  notes text,
  valid_until date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.profiles enable row level security;
alter table public.customers enable row level security;
alter table public.quotes enable row level security;

create policy "profiles own row" on public.profiles for all using (auth.uid() = id) with check (auth.uid() = id);
create policy "customers own rows" on public.customers for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "quotes own rows" on public.quotes for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

create index if not exists customers_user_id_idx on public.customers(user_id);
create index if not exists quotes_user_id_idx on public.quotes(user_id);
create index if not exists quotes_customer_id_idx on public.quotes(customer_id);
create index if not exists quotes_status_idx on public.quotes(user_id,status);

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public
as $$ begin
  insert into public.profiles (id, full_name) values (new.id, coalesce(new.raw_user_meta_data->>'full_name',''));
  return new;
end; $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute procedure public.handle_new_user();
