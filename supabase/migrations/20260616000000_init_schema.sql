-- Create profiles table
create table public.profiles (
  id uuid references auth.users on delete cascade primary key,
  updated_at timestamp with time zone default now() not null,
  age integer check (age >= 0),
  height_cm numeric check (height_cm > 0),
  weight_kg numeric check (weight_kg > 0),
  goals_metadata jsonb default '{}'::jsonb not null
);

-- Create text_logs table for nutrition logging
create table public.text_logs (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users on delete cascade not null,
  created_at timestamp with time zone default now() not null,
  raw_text text not null check (octet_length(raw_text) > 0)
);

-- Create nutrition_targets table for goal tracking
create table public.nutrition_targets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique references auth.users on delete cascade not null,
  calories numeric check (calories >= 0),
  protein_g numeric check (protein_g >= 0),
  carbs_g numeric check (carbs_g >= 0),
  fat_g numeric check (fat_g >= 0),
  fiber_g numeric check (fiber_g >= 0),
  water_target_ml numeric check (water_target_ml >= 0),
  steps_target integer check (steps_target >= 0),
  micronutrients_target jsonb default '{}'::jsonb not null,
  created_at timestamp with time zone default now() not null,
  updated_at timestamp with time zone default now() not null
);

-- Enable Row Level Security (RLS) on all tables
alter table public.profiles enable row level security;
alter table public.text_logs enable row level security;
alter table public.nutrition_targets enable row level security;

-- RLS policies for profiles
create policy "Users can view their own profile."
  on public.profiles for select
  using ( (select auth.uid()) = id );

create policy "Users can update their own profile."
  on public.profiles for update
  using ( (select auth.uid()) = id );

create policy "Users can insert their own profile."
  on public.profiles for insert
  with check ( (select auth.uid()) = id );

-- RLS policies for text_logs
create policy "Users can view their own text logs."
  on public.text_logs for select
  using ( (select auth.uid()) = user_id );

create policy "Users can insert their own text logs."
  on public.text_logs for insert
  with check ( (select auth.uid()) = user_id );

create policy "Users can update their own text logs."
  on public.text_logs for update
  using ( (select auth.uid()) = user_id );

create policy "Users can delete their own text logs."
  on public.text_logs for delete
  using ( (select auth.uid()) = user_id );

-- RLS policies for nutrition_targets
create policy "Users can view their own nutrition targets."
  on public.nutrition_targets for select
  using ( (select auth.uid()) = user_id );

create policy "Users can insert their own nutrition targets."
  on public.nutrition_targets for insert
  with check ( (select auth.uid()) = user_id );

create policy "Users can update their own nutrition targets."
  on public.nutrition_targets for update
  using ( (select auth.uid()) = user_id );

create policy "Users can delete their own nutrition targets."
  on public.nutrition_targets for delete
  using ( (select auth.uid()) = user_id );

-- Automate profile and default targets creation on user signup
create or replace function public.handle_new_user()
returns trigger
security definer set search_path = public
language plpgsql
as $$
begin
  -- Insert into profiles
  insert into public.profiles (id, updated_at)
  values (new.id, now());

  -- Insert default nutrition targets (approx. 30+ default parameters/targets fallback)
  insert into public.nutrition_targets (
    user_id, 
    calories, 
    protein_g, 
    carbs_g, 
    fat_g, 
    fiber_g, 
    water_target_ml, 
    steps_target,
    created_at, 
    updated_at
  )
  values (
    new.id, 
    2000, 
    130, 
    220, 
    65, 
    30, 
    2500, 
    10000, 
    now(), 
    now()
  );

  return new;
end;
$$;

create or replace trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
