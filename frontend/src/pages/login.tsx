import { provider, supabase } from '@/lib/supabase';

export default function Login() {

    async function loginWithGoogle() {
        // ---cut---
        await supabase.auth.signInWithOAuth({
            provider,
            options: {
                // redirectTo: `http://localhost:3000/auth/callback`,
                redirectTo: `http://localhost:3000/dashboard`,
            },
        })
    }

    return (
        <button onClick={loginWithGoogle}>Login With Google</button>
    )
}
