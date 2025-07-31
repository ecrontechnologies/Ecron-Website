import { createNewsletterSubscription, checkNewsletterSubscription } from './supabaseClient';

// Newsletter subscription interface
export interface NewsletterSubscription {
  email: string;
  createdAt?: string;
}

// Subscribe to newsletter
export const subscribeToNewsletter = async (email: string): Promise<{ success: boolean; error?: string }> => {
  try {
    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      return { success: false, error: 'Please enter a valid email address' };
    }

    const emailToSubscribe = email.toLowerCase().trim();
    
    // Check if already subscribed
    const alreadySubscribed = await checkNewsletterSubscription(emailToSubscribe);
    if (alreadySubscribed) {
      return { success: false, error: 'This email is already subscribed to our newsletter' };
    }

    await createNewsletterSubscription({ email: emailToSubscribe });

    return { success: true };
  } catch (error: any) {
    console.error('Newsletter subscription error:', error);
    
    // Handle duplicate email error from API
    if (error.message?.includes('already subscribed')) {
      return { success: false, error: 'This email is already subscribed to our newsletter' };
    }
    
    return { success: false, error: error.message || 'Failed to subscribe. Please try again.' };
  }
};
