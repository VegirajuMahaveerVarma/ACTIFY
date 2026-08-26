-- ACTIFY MVP database schema for Supabase/PostgreSQL

create table if not exists profiles (
  id uuid primary key,
  name text,
  email text,
  created_at timestamptz default now()
);

create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  title text not null,
  description text,
  deadline timestamptz,
  priority text not null default 'medium',
  priority_score integer,
  status text not null default 'pending',
  estimated_minutes integer not null default 30,
  category text,
  source text not null default 'manual',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create table if not exists schedule_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  task_id uuid not null references tasks(id) on delete cascade,
  start_time timestamptz not null,
  end_time timestamptz not null,
  created_at timestamptz default now()
);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  source text not null,
  content text,
  created_at timestamptz default now()
);
