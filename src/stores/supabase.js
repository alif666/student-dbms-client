import { createClient } from '@supabase/supabase-js'
// import { StorageClient } from '@supabase/storage-js'
export const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
export const supabaseStorageUrl = import.meta.env.VITE_SUPABASE_STORAGE_URL;
export const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;
export const supabaseKey = import.meta.env.VITE_SUPABASE_KEY;

export const supabase = createClient(supabaseUrl, supabaseKey);

