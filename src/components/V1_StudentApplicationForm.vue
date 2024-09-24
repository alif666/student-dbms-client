<template>
    <v-container>
        <v-sheet>
            <!--UPADATED FORM SECTION -->
            <v-form ref="form" v-model="isFormValid">
                <!-- File Upload -->
                <v-file-input v-model="uploadedImage" label="Upload Photo" prepend-icon="mdi-camera" variant="filled" />
                <v-text-field type="number" v-model="academic_year" :rules="academic_year_rules"
                    label="Academic Year:" />
                <v-text-field type="text" v-model="student_name" :rules="student_name_rules" label="Student's Name" />
                <v-text-field type="number" v-model="roll_no" label="Roll No." />

                <v-select v-model="grade_class" :items="class_lookups" hint="Pick the classes you teach"
                    label="Grade/ Class:" />
                <v-select v-model="gender" :hint="`${gender.code}, ${gender.name}`" :items="gender_lookups"
                    item-title="name" item-value="code" label="Select" persistent-hint return-object
                    single-line></v-select>


                <v-text-field type="text" v-model="father_name" label="Father's Name" />
                <v-text-field type="text" v-model="mother_name" label="Mother's Name" />
                <v-text-field type="text" v-model="guardian_name" label="Guardian's Name" />
                <v-text-field type="text" v-model="mobile_number" label="Mobile Number" />
                <v-date-picker v-model="dob" :allowed-dates="allowedDates" max="2020-01-01"
                    min="1990-01-01"></v-date-picker>

                <!-- Submit Button -->
                <v-btn :disabled="!isFormValid" @click="openPreviewDialog">Submit</v-btn>
            </v-form>
            <!--UPADATED FORM SECTION Ends-->

            <!--Preview Dialog-->
            <v-dialog v-model="previewDialog" max-width="600px">
                <v-card>
                    <v-card-title>
                        <span class="headline">Student Form Details</span>
                    </v-card-title>
                    <v-card-text>
                        <v-list dense>
                            <!-- Iterate over Proxy object properties using Object.keys or Object.entries -->
                            <v-list-item v-for="key in Object.keys(newStudent)" :key="key">
                                <v-list-item-content>
                                    <v-list-item-title>{{ key }}</v-list-item-title>
                                    <v-list-item-subtitle>
                                        <!-- Display value based on type -->
                                        <span v-if="typeof newStudent[key] === 'object'">{{
                                            JSON.stringify(newStudent[key]) }}</span>
                                        <span v-else>{{ newStudent[key] }}</span>
                                    </v-list-item-subtitle>
                                </v-list-item-content>
                            </v-list-item>
                        </v-list>
                    </v-card-text>
                    <v-card-actions>
                        <v-btn color="primary" text @click="previewDialog = false">Close</v-btn>
                        <v-btn color="primary" text @click="submitForm">Submit</v-btn>
                    </v-card-actions>
                </v-card>

            </v-dialog>
            <!--Preview Dialog-->
        </v-sheet>
    </v-container>
</template>
<script>
import { fetchClassLookups, insertNewStudent } from '@/stores/data-services';
import { ref, onMounted } from 'vue';
import { format } from 'date-fns';
import { useRouter } from 'vue-router';

export default {
    setup() {

        const router = useRouter();
        function formatDate(date) {
            if (!(date instanceof Date)) return date; // Check if the value is a Date object
            return format(date, 'yyyy-MM-dd');
        }

        // Updated Form
        const isFormValid = ref(false);
        const academic_year = ref('');

        const uploadedImage = ref([]);
        const student_name = ref('');
        const class_lookups = ref([]);
        const gender_lookups = ref([
            { code: 1, name: 'Male' },
            { code: 2, name: 'Female' },
            { code: 3, name: 'Others' },
        ]);
        const gender = ref({ code: 1, name: 'Male' });
        const roll_no = ref('');
        const father_name = ref('');
        const mother_name = ref('');
        const guardian_name = ref('');
        const mobile_number = ref('');

        // Define mobile number validation rules
        const mobile_number_rules = [
            // Rule to check if the field is not empty
            (v) => !!v || 'Mobile number is required',
            // Rule to check if the number is of valid length (example: 10 digits for a standard mobile number)
            // (v) => /^\d{10}$/.test(v) || 'Mobile number must be 10 digits',
            // Optional: Rule to check if the number starts with a specific pattern (example: in India, it starts with 6-9)
            // (v) => /^[6-9]\d{9}$/.test(v) || 'Mobile number must start with 6, 7, 8, or 9',
        ];
        // Load class lookups asynchronously
        const loadClassLookups = async () => {
            console.log("StudentApplicationForm ######## Load Class Lookups #########");

            const response = await fetchClassLookups();

            // Access the 'data' property from the response
            if (response && Array.isArray(response.data)) {
                class_lookups.value = response.data.map(item => item.class_name);
            } else {
                console.error("Invalid data format or no data returned");
            }

            console.log(class_lookups.value);
        };
        const grade_class = ref('');
        const academic_year_rules = [
            v => (!!v && v <= 2024 && v > 1990) || 'Range must be between 1990 and 2024',
        ];
        const student_name_rules = [
            v => (!!v && v.length < 20) || 'Name must be within 20 characters',
        ];
        const dob = ref(new Date('1994-01-01'));
        const allowedDates = () => true;


        //Open Dialog to submit form
        const newStudent = ref({
            academic_year: '',
            student_name: '',
            date_of_birth: '',
            grade_class: '',
            gender: '',
            roll_no: '',
            father_name: '',
            mother_name: '',
            guardian_name: '',
            student_image_url: null,
            mobile_number: '',
        });
        const previewDialog = ref(false);
        function openPreviewDialog() {
            newStudent.value = {
                academic_year: academic_year.value,
                student_name: student_name.value,
                date_of_birth: formatDate(dob.value),
                grade_class: grade_class.value,
                gender: gender.value.code,
                roll_no: roll_no.value,
                father_name: father_name.value,
                mother_name: mother_name.value,
                guardian_name: guardian_name.value,
                student_image_url: null,
                mobile_number: mobile_number.value,
            }
            console.log("NEW STUDENT FOUND ##################### ");
            console.log(newStudent.value);
            previewDialog.value = true;
        }
        // Open Dialog to submit form ends



        // Form submission logic
        const submitForm = async () => {
            console.log(newStudent.value);
            try {
                const { data } = await insertNewStudent({ newStudent, student_image_url: newStudent.value.student_image_url, uploadedImage: uploadedImage });
                console.log(data);
            } catch (err) {
                console.log(err.message);
            }

            console.log("FORM SUBMITTED SUCCESSFULLY");
            alert('##########3 Form submitted !#########3');

            previewDialog.value = false;
            router.push('/students');
        };

        // Call loadClassLookups when component is mounted
        onMounted(() => {
            // loadClassLookups();
            console.log('Form is mounted');
            console.log('Gender Lookups:', gender_lookups.value);
            console.log('Class Lookups:', class_lookups.value);
            loadClassLookups();

        });

        const navigateTo=(path)=>{
    router.push(path);
  };
        return {
            academic_year,
            academic_year_rules,
            student_name,
            student_name_rules,
            dob,
            grade_class,
            loadClassLookups,
            class_lookups,
            allowedDates,
            isFormValid,
            submitForm,
            gender_lookups,
            gender,
            roll_no,
            father_name,
            mother_name,
            guardian_name,
            mobile_number,
            newStudent,
            openPreviewDialog,
            previewDialog,
            formatDate,
            format,
            uploadedImage,
            navigateTo,
        };
    }
};
</script>

<style scoped>
.v-btn {
    margin-top: 20px;
}
</style>
