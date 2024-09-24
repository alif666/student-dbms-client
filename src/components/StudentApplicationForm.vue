<template>
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
                    <v-tab v-for="item in items" :key="item.title" v-text="item.title" :value="item.title"></v-tab>
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
                        <v-text-field label="Academic Year" v-model="student_general.academicYear" :rules="academicYearRules" />
                        <v-text-field label="Student Code" v-model="student_general.studentCode" :rules="studentCodeRules" />
                        <v-text-field label="Admission Number" v-model="student_general.admissionNumber" :rules="admissionNumberRules" />
                        <v-text-field type="date" label="Joining Date" v-model="student_general.joiningDate" />
                    </span>

                    <!-- Personal Tab -->
                    <span v-else-if="item.title === 'Personal'">
                        <!-- File Upload -->
                        <v-container>
                            <v-file-input v-model="student_personal.uploadedImage" label="Upload Photo" prepend-icon="mdi-camera"
                                variant="filled" @change="previewImage" />
                            <v-img v-if="student_personal.studentImageUrl" :src="student_personal.studentImageUrl" max-width="300" max-height="300" />
                        </v-container>

                        <v-text-field label="Student Name" v-model="student_personal.studentName" :rules="studentNameRules" />
                        <v-text-field label="Mother Tongue" v-model="student_personal.motherTongue" :rules="motherTongueRules" />
                        <v-text-field label="Identification Mark" v-model="student_personal.identificationMark"
                            :rules="identificationMarkRules" />
                        <v-text-field label="Previous School" v-model="student_personal.previousSchool" />
                        <v-text-field type="text" label="Remarks" v-model="student_personal.remarks" />
                        <v-text-field type="text" label="Blood Group" v-model="student_personal.bloodGroup" />
                        <v-text-field type="text" label="Religion" v-model="student_personal.religion" />
                        <v-text-field type="date" label="Date of Birth" v-model="student_personal.dateOfBirth" variant="solo-filled" />
                        <v-select v-model="student_personal.gender" :items="genderLookups" item-title="name" item-value="code"
                            label="Gender" single-line return-object></v-select>
                    </span>

                    <!-- Other tabs (Contact, Family, etc.) -->
                    <span v-else-if="item.title === 'Contact'">
                        <v-text-field label="Mobile Number" v-model="student_contact.mobileNumber" />
                        <v-text-field label="Alternate Mobile" v-model="student_contact.alternateMobile" />
                        <v-text-field label="Email" v-model="student_contact.email" />
                        <v-text-field label="Permanent Address" v-model="student_contact.permanentAddressId" />
                        <v-text-field label="Present Address" v-model="student_contact.presentAddressId" />
                        <v-text-field label="Pincode" v-model="student_contact.pincode" />
                    </span>

                    <span v-else-if="item.title === 'Family'">
                        <v-text-field label="Mother's Name" v-model="student_family.motherName" />
                        <v-text-field label="Father's Name" v-model="student_family.fatherName" />
                        <v-text-field label="Guardian's Name" v-model="student_family.guardianName" />
                        <v-text-field label="NID Number" v-model="student_family.nidNumber" />
                        <v-text-field label="Birth Certificate" v-model="student_family.birthCertificate" />
                        <v-text-field label="Admission Date" v-model="student_family.admissionDate" type="date" />
                    </span>
                </v-card>
            </v-tabs-window-item>
        </v-tabs-window>
    </v-card>
</template>

<script>
import { fetchStudentById } from '@/stores/data-services';
import { ref, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';
export default{
    setup() {
        const route = useRoute();
        const id = ref(route.params.id);
        const tab = ref(null);

        // General Tab Data
        const student_general = ref({
            academicYear: 2024,
            studentCode: '',
            admissionNumber: '',
            joiningDate: ''
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

        // Personal Tab Data
        const student_personal = ref({
            uploadedImage: null,
            studentImageUrl: null,
            studentName: '',
            motherTongue: '',
            identificationMark: '',
            previousSchool: '',
            remarks: '',
            bloodGroup: '',
            religion: '',
            dateOfBirth: '',
            gender: { code: 1, name: 'Male' }
        });
        
        const previewImage = () => {
            if (student_personal.value.uploadedImage) {
                student_personal.value.studentImageUrl = URL.createObjectURL(student_personal.value.uploadedImage);
            } else {
                student_personal.value.studentImageUrl = null;
            }
        };

        watch(() => student_personal.value.uploadedImage, () => {
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

        // Contact Tab Data
        const student_contact = ref({
            mobileNumber: '',
            alternateMobile: '',
            email: '',
            permanentAddressId: '',
            presentAddressId: '',
            pincode: ''
        });

        // Family Tab Data
        const student_family = ref({
            motherName: '',
            fatherName: '',
            guardianName: '',
            nidNumber: '',
            birthCertificate: '',
            admissionDate: ''
        });

        const items = [
            { title: 'General', text: 'general', student: student_general.value },
            { title: 'Personal', text: 'personal', student: student_personal.value },
            { title: 'Contact', text: 'contact', student: student_contact.value },
            { title: 'Family', text: 'family', student: student_family.value }
        ];

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
                    academicYear: studentData.academic_year || 2024,
                    studentCode: studentData.student_code || '',
                    admissionNumber: studentData.admission_number || '',
                    joiningDate: studentData.joining_date || ''
                };

                // Assign Personal Data
                student_personal.value = {
                    uploadedImage: null,
                    studentImageUrl: studentData.student_image_url || '',
                    studentName: studentData.student_name || '',
                    motherTongue: studentData.mother_tongue || '',
                    identificationMark: studentData.identification_mark || '',
                    previousSchool: studentData.previous_school || '',
                    remarks: studentData.remark || '',
                    bloodGroup: studentData.blood_group || '',
                    religion: studentData.religion || '',
                    dateOfBirth: studentData.date_of_birth || '',
                    gender: studentData.gender || { code: 1, name: 'Male' }
                };

                // Assign Contact Data
                student_contact.value = {
                    mobileNumber: studentData.mobile_number || '',
                    alternateMobile: studentData.alternate_mobile || '',
                    email: studentData.email || '',
                    permanentAddressId: studentData.permanent_address_id || '',
                    presentAddressId: studentData.present_address_id || '',
                    pincode: studentData.pincode || ''
                };

                // Assign Family Data
                student_family.value = {
                    motherName: studentData.mother_name || '',
                    fatherName: studentData.father_name || '',
                    guardianName: studentData.guardian_name || '',
                    nidNumber: studentData.nid_number || '',
                    birthCertificate: studentData.birth_certificate || '',
                    admissionDate: studentData.admission_date || ''
                };
            }
        }

        onMounted(()=>{
            console.log("#################  ON MOUNTED STUDENT APPLICATION FORM ########### ");

            if(id.value==='add'){
                console.log("########## new form ##########");
            }else{
                loadStudentById();
                console.log(id.value);
            }
        });

        return {
            id,
            tab,
            items,
            student_general,
            academicYearRules,
            studentCodeRules,
            admissionNumberRules,
            student_personal,
            previewImage,
            studentNameRules,
            identificationMarkRules,
            motherTongueRules,
            genderLookups,
            student_contact,
            student_family
        };
    },
};
</script>
