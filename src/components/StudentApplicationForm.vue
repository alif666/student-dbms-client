<template>
    <v-container>
        <v-sheet>
            <v-form @input="validateForm" fast-fail @submit.prevent>
                <v-card>
                    <v-toolbar color="primary">
                        <span v-if="id">
                            <v-card-title>Student ID: {{ id }}</v-card-title>
                        </span>
                        <span v-else>
                            <v-card-title>Student Application</v-card-title>
                        </span>
                        
                        <template v-slot:extension>
                            
                            <v-tabs v-model="tab" align-tabs="title">
                                <v-tab v-for="item in items" :key="item.title" v-text="item.title"
                                    :value="item.title"></v-tab>
                            </v-tabs>
                        </template>
                    </v-toolbar>

                    <v-tabs-window v-model="tab">
                        <v-tabs-window-item v-for="item in items" :key="item.title" :value="item.title">
                            <v-card flat>
                                <v-card-title>
                                    {{ item.title }}
                                </v-card-title>
                                <!-- General Tab -->
                                <span v-if="item.title === 'General'">
                                    <v-text-field label="Academic Year" v-model="student_general.academic_year"
                                        :rules="academicYearRules" />
                                    <v-text-field label="Student Code" v-model="student_general.student_code"
                                        :rules="studentCodeRules" />
                                    <v-text-field label="Admission Number" v-model="student_general.admission_number"
                                        :rules="admissionNumberRules" />
                                    <v-text-field type="date" label="Joining Date"
                                        v-model="student_general.joining_date" />
                                </span>

                                <!-- Personal Tab -->
                                <span v-else-if="item.title === 'Personal'">

                                    <!-- File Upload Input -->
                                    <v-file-input v-model="uploadedImage" label="Upload Photo" prepend-icon="mdi-camera"
                                        @change="previewImage" variant="filled" />

                                    <v-img v-if="student_personal.student_image_url"
                                        :src="student_personal.student_image_url" max-width="300" max-height="300" />

                                    <v-text-field label="Student Name" v-model="student_personal.student_name"
                                        :rules="studentNameRules" />
                                    <v-text-field label="Mother Tongue" v-model="student_personal.mother_tongue"
                                        :rules="motherTongueRules" />
                                    <v-text-field label="Identification Mark"
                                        v-model="student_personal.identification_mark"
                                        :rules="identificationMarkRules" />
                                    <v-text-field label="Previous School" v-model="student_personal.previous_school" />
                                    <v-text-field type="text" label="Remark" v-model="student_personal.remark" />
                                    <v-text-field type="text" label="Blood Group"
                                        v-model="student_personal.blood_group" />
                                    <v-text-field type="text" label="Religion" v-model="student_personal.religion" />
                                    <v-text-field type="date" label="Date of Birth"
                                        v-model="student_personal.date_of_birth" variant="solo-filled" />
                                    <v-select v-model="student_personal.gender" :items="genderLookups" item-title="name"
                                        item-value="code" item-text="name" label="Gender" single-line/>
                                </span>

                                <!-- Other tabs (Contact, Family, etc.) -->
                                <span v-else-if="item.title === 'Contact'">
                                    <v-text-field label="Mobile Number" v-model="student_contact.mobile_number" />
                                    <v-text-field label="Alternate Mobile" v-model="student_contact.alternate_mobile" />
                                    <v-text-field label="Pincode" v-model="student_contact.pincode" />
                                    <v-text-field type = "email" label="Email" :rules="emailValidRules" suffix="@gmail.com" v-model="student_contact.email"/>
                                </span>

                                <span v-else-if="item.title === 'Family'">
                                    <v-text-field label="Mother's Name" v-model="student_family.mother_name" />
                                    <v-text-field label="Father's Name" v-model="student_family.father_name" />
                                    <v-text-field label="Guardian's Name" v-model="student_family.guardian_name" />
                                    <v-text-field label="NID Number" v-model="student_family.nid_number" />
                                    <v-text-field label="Birth Certificate"
                                        v-model="student_family.birth_certificate" />
                                    <v-text-field label="Admission Date" v-model="student_family.admission_date"
                                        type="date" />
                                </span>
                            </v-card>
                        </v-tabs-window-item>

                        <button
                            class="bg-surface-light position-fixed bottom-0 right-0 ma-4 pa-4 pb-4 mb-4 elevation-4 rounded-lg"
                            type="button" @click="openConfirmDialog" block>
                            Submit
                        </button>



                    </v-tabs-window>

                    <!-- Delete Dialog -->

                    <v-dialog v-model="confirmDialog" max-width="600px">
                        <v-card>
                            <v-card-title>Confirm Submission ?</v-card-title>
                            <v-card-subtitle>Are you sure you want to submit ?</v-card-subtitle>
                            <v-card-actions>
                                <v-btn color="blue-darken-1" text @click="confirmDialog = false">Cancel</v-btn>
                                <v-btn color="blue-darken-1" text @click="submitNewStudent">Confirm</v-btn>

                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                </v-card>
            </v-form>
        </v-sheet>
    </v-container>
</template>

<script>
import { fetchStudentById } from '@/stores/data-services';
import { ref, onMounted, watch } from 'vue';
import { useRoute,useRouter } from 'vue-router';
import {format} from 'date-fns';
import { insertNewStudent } from '@/stores/data-services';

export default {
    setup() {
        const router=useRouter();
        const route = useRoute();
        const id = ref(route.params.id);
        const tab = ref(null);

        function stringToDate(newValue){
            return  format(new Date(newValue), 'yyyy-MM-dd') 
        }

        const uploadedImage = ref(null);
        // Personal Tab Data
        const student_personal = ref({
            student_image_url: '',
            student_name: '',
            mother_tongue: '',
            identification_mark: '',
            previous_school: '',
            remark: '',
            blood_group: '',
            religion: '',
            date_of_birth: stringToDate('1990-01-01'),
            gender: 1,
        });
        // Contact Tab Data
        const student_contact = ref({
            mobile_number: '',
            alternate_mobile: '',
            email: '',
            pincode: ''
        });


        // Family Tab Data
        const student_family = ref({
            mother_name: '',
            father_name: '',
            guardian_name: '',
            nid_number: '',
            birth_certificate: '',
            admission_date: stringToDate('1990-01-01'),
        });


        const confirmDialog = ref(false);
        const openConfirmDialog = () => {
            confirmDialog.value = true;
        };
        const image_url = ref('');

        // General Tab Data
        const student_general = ref({
            academic_year: 0,
            student_code: '',
            admission_number: '',
            joining_date : stringToDate('1990-01-01'),
        });

        const academicYearRules = [
            v => (!!v && v <= 2024 && v > 1990) || 'Range must be between 1990 and 2024',

        ];
        const studentCodeRules = [
            v => (!!v && v.length < 10) || 'Length must be less than 10',

        ];
        const admissionNumberRules = [
            v => (!!v && v.length < 10) || 'Length must be less than 10',

        ];

        const emailValidRules = [
    v => !!v || 'Email is required', 
    v => /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(v) || 'Invalid Email format', 
];

        const previewImage = () => {
            console.log("############# previewImage accessed #############");
            if (uploadedImage.value) {
                student_personal.value.student_image_url = URL.createObjectURL(uploadedImage.value);
            } else {
                student_personal.value.student_image_url = '';
            }
            console.log(student_personal.value.student_image_url);
        };


        watch(() => uploadedImage, (newValue) => {
            previewImage();
        });

        const studentNameRules = [
            v => (!!v && v.length < 20) || 'Student name length cannot exceed 20 characters',
        ];
        const identificationMarkRules = [
            v => !!v || 'Must have Identification Mark',
        ];
        const motherTongueRules = [
            v => !!v || 'Must have mother tongue',
        ];

        // Gender Dropdown
        const genderLookups = ref([
            { code: 1, name: 'Male' },
            { code: 2, name: 'Female' },
            { code: 3, name: 'Other' }
        ]);



        const items = [
            { title: 'General', text: 'general', student: student_general.value },
            { title: 'Personal', text: 'personal', student: student_personal.value },
            { title: 'Contact', text: 'contact', student: student_contact.value },
            { title: 'Family', text: 'family', student: student_family.value }
        ];


        const navigateTo=(path)=>{
    router.push(path);
  }

        async function submitNewStudent() {
            console.log("############ StudentApplicationForm ########### SubmitNewStudent ##########");
            try {
                // Validate the form using the v-form reference

                if (!validateForm) {
                    console.log('Form is invalid');
                    return;
                }

                // Combine the student data into a single object
                const combinedStudentData = {
                    ...student_general.value,
                    ...student_personal.value,
                    ...student_contact.value,
                    ...student_family.value,
                };

                console.log(combinedStudentData);

                // Submit the new student data
                const data = await insertNewStudent({
                    newStudent: combinedStudentData,
                    uploadedImage: uploadedImage,
                });

                alert("SUCCESSFUL");
            } catch (error) {
                console.error("Error submitting student data:", error);
                navigateTo(`/students/forms/add`);
            }
            navigateTo(`/students`);
        }




        // Fetch Student By Id
        // Fetch student data based on ID
        async function loadStudentById() {
            console.log("######## loadStudentById() #### id:");
            console.log(id.value);
            if (!id.value) return;

            const studentData = await fetchStudentById({ id: id.value });
            console.log("#### STUDENT DETAIL EDIT ####### studentData", studentData);

            // Check and assign student data to respective sections
            if (studentData) {
                // Assign General Data
                student_general.value = {
                    academic_year: studentData.academic_year || 2024,
                    student_code: studentData.student_code || '',
                    admission_number: studentData.admission_number || '',
                    joining_date: studentData.joining_date || stringToDate('1990-01-01'),
                };
                uploadedImage: null,
                    // Assign Personal Data
                    student_personal.value = {
                        student_image_url: studentData.student_image_url || '',
                        student_name: studentData.student_name || '',
                        mother_tongue: studentData.mother_tongue || '',
                        identification_mark: studentData.identification_mark || '',
                        previous_school: studentData.previous_school || '',
                        remark: studentData.remark || '',
                        blood_group: studentData.blood_group || '',
                        religion: studentData.religion || '',
                        date_of_birth: studentData.date_of_birth || stringToDate('1990-01-01'),
                        gender: studentData.gender || 1,
                    };

                // Assign Contact Data
                student_contact.value = {
                    mobile_number: studentData.mobile_number || '',
                    alternate_mobile: studentData.alternate_mobile || '',
                    email: studentData.email || '',           
                    pincode: studentData.pincode || '',
                };

                // Assign Family Data
                student_family.value = {
                    mother_name: studentData.mother_name || '',
                    father_name: studentData.father_name || '',
                    guardian_name: studentData.guardian_name || '',
                    nid_number: studentData.nid_number || '',
                    birth_certificate: studentData.birth_certificate || '',
                    admission_date: studentData.admission_date || stringToDate('1990-01-01'),
                };
            }
        }




        // FORM VALIDATion


        // Check all rules for all fields
        const validateForm = () => {
            console.log("VALIDATE FORM ######################################3")
            const academicYearValid = academicYearRules.every(rule => rule(student_general.value.academic_year));
            const studentCodeValid = studentCodeRules.every(rule => rule(student_general.value.student_code));
            const admissionNumberValid = admissionNumberRules.every(rule => rule(student_general.value.admission_number));

            const studentNameValid = studentNameRules.every(rule => rule(student_personal.value.student_name));
            const motherTongueValid = motherTongueRules.every(rule => rule(student_personal.value.mother_tongue));
            const identificationMarkValid = identificationMarkRules.every(rule => rule(student_personal.value.identification_mark));

            const mobileNumberValid = !!student_contact.value.mobile_number;
            const emailValidRules = !!student_contact.value.email;
            const isValid = academicYearValid && studentCodeValid && admissionNumberValid &&
                studentNameValid && motherTongueValid && identificationMarkValid &&
                mobileNumberValid && emailValidRules;
            console.log(isValid);
            const formData = {
                ...student_general.value,
                ...student_personal.value,
                ...student_contact.value,
                ...student_family.value,
            };
            console.log(formData);
            return isValid;
        };
        const handleFormChange = () => {
            console.log("Form input changed, checking validity...");
            console.log("Current form valid state:", validateForm());
            const formData = {
                ...student_general.value,
                ...student_personal.value,
                ...student_contact.value,
                ...student_family.value,
            };
            console.log(formData);
        };
        watch([student_general, student_personal, student_contact, student_family], validateForm, { deep: true });

        // FORM VALIDATION ENDS

        // Fetch Existing Student Data if ID is Present
        onMounted(() => {
            console.log("#################  ON MOUNTED STUDENT APPLICATION FORM ########### ");

            if (id.value === 'add') {
                console.log("########## new form ##########");
            } else {
                console.log(id.value + " ######## EDIT FLAG ############## ");
                loadStudentById();
            }
            validateForm();

        });
        return {
            uploadedImage,
            loadStudentById,
            id,
            tab,
            validateForm,
            confirmDialog,
            openConfirmDialog,
            genderLookups,
            student_general,
            student_personal,
            student_contact,
            student_family,
            items,
            submitNewStudent,
            image_url,
            admissionNumberRules,
            studentCodeRules,
            studentNameRules,
            academicYearRules,
            identificationMarkRules,
            emailValidRules,
            motherTongueRules,
            previewImage,
            handleFormChange,
        };
    }
};
</script>

<style scoped>
.disabled {
    pointer-events: none;
}
</style>
