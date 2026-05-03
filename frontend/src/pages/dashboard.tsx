import { supabase } from "@/lib/supabase"
import type { User, UserResponse } from "@supabase/supabase-js"
import axios from "axios"
import { useEffect, useState } from "react"
import { useNavigate } from "react-router"
import { Navigate, redirect, Router } from "react-router"

export default function Dashboard() {

    const [user, setUser] = useState<User | null>()
    const [auctions, setAuctions] = useState<any>(null)
    useEffect(() => {
        async function getUserFromSupabase() {
            const user = await supabase.auth.getUser()
            setUser(user.data.user);
        }
        getUserFromSupabase()
    }, [])

    useEffect(() => {
        async function getAuctions() {
            try {
                const session = await supabase.auth.getSession()
                const token = session.data.session?.access_token

                const res = await axios.get('http://localhost:3001/api/v1/auctions/', {
                    headers: {
                        Authorization: token
                    }
                })
                setAuctions(res)
                console.log(auctions)
            }
            catch (error) {
                alert(error)
                clearAuth()
            }
        }
        getAuctions()
    }, [])

    function clearAuth() {
        useEffect(() => {
            supabase.auth.signOut()
            const navigate = useNavigate()
            navigate('/auth')
        }, [])
    }
    return (
        <div>
            <div>I am {user?.email || "not signed in"}</div>
            {<button onClick={clearAuth}> Goto Auth</button>}
            {user && <div>
                {auctions}

            </div>}
        </div>
    )
}
