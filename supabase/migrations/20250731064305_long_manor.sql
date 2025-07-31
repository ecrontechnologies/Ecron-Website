/*
  # Fix RLS policy for demo_applications table

  1. Security Changes
    - Drop existing restrictive policy if it exists
    - Create new policy allowing anonymous users to insert demo applications
    - Ensure authenticated users can still read the data

  This migration fixes the RLS policy violation that prevents anonymous users
  from submitting demo application forms.
*/

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Anyone can insert demo applications" ON demo_applications;
DROP POLICY IF EXISTS "Authenticated users can read demo applications" ON demo_applications;

-- Create policy to allow anonymous users to insert demo applications
CREATE POLICY "Enable insert for anonymous users" ON demo_applications
  FOR INSERT 
  TO anon, authenticated
  WITH CHECK (true);

-- Create policy to allow authenticated users to read demo applications
CREATE POLICY "Enable read for authenticated users" ON demo_applications
  FOR SELECT 
  TO authenticated
  USING (true);