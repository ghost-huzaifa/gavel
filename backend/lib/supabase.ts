import { createClient, type Provider } from "@supabase/supabase-js";

export const supabase = createClient(
  process.env.BUN_PUBLIC_SUPABASE_URL!,
  process.env.BUN_PUBLIC_SUPABASE_ADMIN_KEY!,
);
export const provider = "google" as Provider;
