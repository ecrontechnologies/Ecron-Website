/*
  # Create application tables for Ecron Technologies

  1. New Tables
    - `contact_messages`
      - `id` (uuid, primary key)
      - `first_name` (text)
      - `last_name` (text)
      - `email` (text)
      - `phone` (text)
      - `course_interest` (text, nullable)
      - `message` (text)
      - `created_at` (timestamp)
    
    - `course_applications`
      - `id` (uuid, primary key)
      - `full_name` (text)
      - `email` (text)
      - `phone` (text)
      - `course_name` (text)
      - `experience_level` (text)
      - `interest_message` (text)
      - `created_at` (timestamp)
    
    - `demo_applications`
      - `id` (uuid, primary key)
      - `name` (text)
      - `phone` (text)
      - `email` (text)
      - `course_for_demo` (text)
      - `available_time` (text)
      - `preferred_date` (text, nullable)
      - `created_at` (timestamp)
    
    - `newsletter_subscriptions`
      - `email` (text, primary key)
      - `created_at` (timestamp)
    
    - `event_registrations`
      - `id` (uuid, primary key)
      - `name` (text)
      - `degree` (text)
      - `year` (text)
      - `college_name` (text)
      - `university_name` (text)
      - `contact_number` (text)
      - `alternate_number` (text, nullable)
      - `email_id` (text)
      - `certificate_code` (text)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for public insert access (forms don't require authentication)
    - Add policies for authenticated read access (for admin dashboard)
*/

-- Contact Messages Table
CREATE TABLE IF NOT EXISTS contact_messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  first_name text NOT NULL,
  last_name text NOT NULL,
  email text NOT NULL,
  phone text NOT NULL,
  course_interest text,
  message text NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE contact_messages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can insert contact messages"
  ON contact_messages
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can read contact messages"
  ON contact_messages
  FOR SELECT
  TO authenticated
  USING (true);

-- Course Applications Table
CREATE TABLE IF NOT EXISTS course_applications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name text NOT NULL,
  email text NOT NULL,
  phone text NOT NULL,
  course_name text NOT NULL,
  experience_level text NOT NULL,
  interest_message text NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE course_applications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can insert course applications"
  ON course_applications
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can read course applications"
  ON course_applications
  FOR SELECT
  TO authenticated
  USING (true);

-- Demo Applications Table
CREATE TABLE IF NOT EXISTS demo_applications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  phone text NOT NULL,
  email text NOT NULL,
  course_for_demo text NOT NULL,
  available_time text NOT NULL,
  preferred_date text,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE demo_applications ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can insert demo applications"
  ON demo_applications
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can read demo applications"
  ON demo_applications
  FOR SELECT
  TO authenticated
  USING (true);

-- Newsletter Subscriptions Table
CREATE TABLE IF NOT EXISTS newsletter_subscriptions (
  email text PRIMARY KEY,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE newsletter_subscriptions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can insert newsletter subscriptions"
  ON newsletter_subscriptions
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can read newsletter subscriptions"
  ON newsletter_subscriptions
  FOR SELECT
  TO authenticated
  USING (true);

-- Event Registrations Table
CREATE TABLE IF NOT EXISTS event_registrations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  degree text NOT NULL,
  year text NOT NULL,
  college_name text NOT NULL,
  university_name text NOT NULL,
  contact_number text NOT NULL,
  alternate_number text,
  email_id text NOT NULL,
  certificate_code text NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE event_registrations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can insert event registrations"
  ON event_registrations
  FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE POLICY "Authenticated users can read event registrations"
  ON event_registrations
  FOR SELECT
  TO authenticated
  USING (true);