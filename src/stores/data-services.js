import { supabase, supabaseStorageUrl } from './supabase';

export async function authenticate({ email, password }) {
    console.log('#### authenticate ####');
    console.log(email);
    console.log(password);
    try {
        const { data, error } = await supabase
            .from('profiles')
            .select('email')
            .eq('email', email)
            .eq('password', password);
        if (error) throw new Error(error.message);
        console.log('####### data-services.js ########  authenticate #########');
        console.log(data);
        return data;
    } catch (err) {
        console.error('Error authenticating admin:', err);
    }
}

export async function fetchRolesLookups() {
    try {
        const { data, error } = await supabase.from('roles_lookup').select('*');
        if (error) throw new Error(error.message);

        return { data };
    } catch (err) {
        console.error('Error fetching roles:', err);
    }
}

export async function fetchClassLookups() {
    console.log("### data-services ####### fetchClassLookups ######## ");
    try {
        const { data, error } = await supabase.from('class_lookup').select('*');
        if (error) throw new Error(error.message);
        console.log(data);
        return { data };
    } catch (err) {
        console.error('Error fetching classes:', err);
    }
}

export async function fetchUsers() {
    try {
        const { data, error } = await supabase.from('profiles').select('*');
        if (error) throw new Error(error.message);
        return { data };
    } catch (err) {
        console.error('Error fetching staff data:', err);
    }
}

export async function insertNewUser({ formData }) {
    try {
        const { data, error } = await supabase
            .from('profiles')
            .insert([{ ...formData.value }]);
        if (error) throw new Error(error.message);
        return { data };
    } catch (err) {
        console.error('Error inserting user:', err);
    }
}

export async function updateUser({ formData, id }) {
    try {
        const { data, error } = await supabase
            .from('profiles')
            .update(formData)
            .eq('id', id);  // Make sure 'id' here matches the field in your database.

        if (error) throw new Error(error.message);

        return { data };
    } catch (err) {
        console.error('Error updating user:', err);
    }
}


export async function deleteUser({ id }) {
    try {
        const { data, error } = await supabase
            .from('profiles')
            .delete()
            .eq('id', id);
        if (error) throw new Error(error.message);
        return { data };
    } catch (err) {
        console.error('Error deleting user:', err);
    }
}


export async function fetchNavigations() {
    console.log("############ FETCH NAVIGATIONS ####################");
    try {
        const { data, error } = await supabase.from('navigations').select('*');
        if (error) throw new Error(error.message);
        console.log(data);
        return { data };
    } catch (err) {
        console.error('Error fetching staff data:', err);
    }
}


// ###################### STUDENTS ########################################

// Insert new student with image upload
export async function insertNewStudent({ newStudent, student_image_url, uploadedImage }) {
    try {
        // let imageUrl = ''; 
        if (uploadedImage.value) {
            const { data, error } = await supabase.storage
                .from('student-images')
                .upload(`${uploadedImage.value.name}`, uploadedImage.value);
            if (error) throw new Error(error.message);
            // imageUrl = data.path;


            const { d, insertError } = await supabase.from('students').insert([{ ...newStudent.value, student_image_url: (supabaseStorageUrl + `/student-images/${uploadedImage.value.name}`) }]);
            if (insertError) throw new Error(insertError.message);
            return { d };
        }
    } catch (err) {
        console.error('Error inserting student:', err);
    }
}

export async function fetchStudents() {
    try {
        const { data, error } = await supabase.from('students').select('*');
        if (error) throw new Error(error.message);
        console.log("STUDENT FETCHED FROM DB ###############");
        console.log(data);
        return { data };
    } catch (err) {
        console.error('Error fetching student data:', err);
    }
}

export async function fetchStudentById({id}) {
    try {
        const { data, error } = await supabase.from('students').select('*').eq('id',id);
        if (error) throw new Error(error.message);
        console.log("STUDENT FETCHED FROM DB ###############");
        console.log(data[0]);
        return data[0];
        
    } catch (err) {
        console.error('Error fetching student data:', err);
    }
}

export async function deleteStudent({ id }) {
    try {
        const { data, error } = await supabase
            .from('students')
            .delete()
            .eq('id', id);
        if (error) throw new Error(error.message);
        return { data };
    } catch (err) {
        console.error('Error deleting Student:', err);
    }
}