import { supabase } from "./supabase";
export async function authenticate({email,password}){
    console.log("#### authenticate ####");
    console.log(email);
    console.log(password);
    try {
        const { data, error } = await supabase.from('profiles').select('email').eq('email', email).eq('password',password);
        if (error) throw new Error(error.message);
        console.log("####### data-services.js ########  authenticate #########");
        console.log(data);
        return data;
      } catch (err) {
        console.error('Error authenticating admin:', err);
      }
}



