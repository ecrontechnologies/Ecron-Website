import { supabase, type Database } from './supabase'

// Contact Messages
export const createContactMessage = async (data: Database['public']['Tables']['contact_messages']['Insert']) => {
  const { data: result, error } = await supabase
    .from('contact_messages')
    .insert(data)
    .select()
    .single()

  if (error) {
    console.error('Error creating contact message:', error)
    throw new Error(error.message)
  }

  return result
}

// Course Applications
export const createCourseApplication = async (data: Database['public']['Tables']['course_applications']['Insert']) => {
  const { data: result, error } = await supabase
    .from('course_applications')
    .insert(data)
    .select()
    .single()

  if (error) {
    console.error('Error creating course application:', error)
    throw new Error(error.message)
  }

  return result
}

// Demo Applications
export const createDemoApplication = async (data: Database['public']['Tables']['demo_applications']['Insert']) => {
  const { data: result, error } = await supabase
    .from('demo_applications')
    .insert(data)
    .select()
    .single()

  if (error) {
    console.error('Error creating demo application:', error)
    throw new Error(error.message)
  }

  return result
}

// Newsletter Subscriptions
export const createNewsletterSubscription = async (data: Database['public']['Tables']['newsletter_subscriptions']['Insert']) => {
  const { data: result, error } = await supabase
    .from('newsletter_subscriptions')
    .insert(data)
    .select()
    .single()

  if (error) {
    console.error('Error creating newsletter subscription:', error)
    throw new Error(error.message)
  }

  return result
}

// Event Registrations
export const createEventRegistration = async (data: Database['public']['Tables']['event_registrations']['Insert']) => {
  const { data: result, error } = await supabase
    .from('event_registrations')
    .insert(data)
    .select()
    .single()

  if (error) {
    console.error('Error creating event registration:', error)
    throw new Error(error.message)
  }

  return result
}

// Check if email already exists in newsletter
export const checkNewsletterSubscription = async (email: string) => {
  const { data, error } = await supabase
    .from('newsletter_subscriptions')
    .select('email')
    .eq('email', email)
    .single()

  if (error && error.code !== 'PGRST116') { // PGRST116 is "not found" error
    console.error('Error checking newsletter subscription:', error)
    throw new Error(error.message)
  }

  return !!data
}

// Authentication helpers
export const getCurrentUser = async () => {
  const { data: { user }, error } = await supabase.auth.getUser()
  
  if (error) {
    console.error('Error getting current user:', error)
    return null
  }
  
  return user
}

export const signUp = async (email: string, password: string) => {
  const { data, error } = await supabase.auth.signUp({
    email,
    password,
  })

  if (error) {
    console.error('Error signing up:', error)
    throw new Error(error.message)
  }

  return data
}

export const signIn = async (email: string, password: string) => {
  const { data, error } = await supabase.auth.signInWithPassword({
    email,
    password,
  })

  if (error) {
    console.error('Error signing in:', error)
    throw new Error(error.message)
  }

  return data
}

export const signOut = async () => {
  const { error } = await supabase.auth.signOut()

  if (error) {
    console.error('Error signing out:', error)
    throw new Error(error.message)
  }
}