<template>
    <v-container>
        <v-sheet>
            <v-form fast-fail @submit.prevent>
                <!-- Expansion Panel for General Information -->


                <v-expansion-panels v-model="panel" multiple>
                    <v-expansion-panel>
                        <v-expansion-panel-title>1. General Information</v-expansion-panel-title>
                        <v-expansion-panel-text>

                            <!-- 1.1. Name of the Student -->
                            <v-text-field v-model="student_name" :rules="student_name_rules"
                                label="1.1 Name of the Student (in Capital Letters):" />

                            <!-- 1.2. Gender -->
                            <v-select v-model="gender" :items="genderLookUp" :rules="gender_rules"
                                label="1.2 Gender: Male (1) / Female (2) / Transgender (3)" />

                            <!-- 1.3. Date of Birth -->
                            <v-text-field v-model="dob" :rules="dob_rules" label="1.3 Date of Birth (DD/MM/YYYY):" />

                            <!-- 1.4. Mother's Name -->
                            <v-text-field v-model="mother_name" label="1.4 Mother's Name:" />

                            <!-- 1.5. Father's Name -->
                            <v-text-field v-model="father_name" label="1.5 Father's Name:" />

                            <!-- 1.6. Guardian's Name -->
                            <v-text-field v-model="guardian_name" label="1.6 Guardian's Name (If Applicable):" />

                            <!-- 1.7. NID Number -->
                            <v-text-field v-model="nid_number" label="1.7 NID Number of Student:" />

                            <!-- 1.8. BRN Number -->
                            <v-text-field v-model="brn_number" label="1.8 BRN Number of Student:" />

                            <!-- 1.9. Address -->
                            <v-textarea v-model="address" label="1.9 Address:" />

                            <!-- 1.9(b). Pincode -->
                            <v-text-field v-model="pincode" label="1.9(b) Pincode:" />

                            <!-- 1.10(a). Mobile Number -->
                            <v-text-field v-model="mobile_number"
                                label="1.10(a) Mobile Number (of Student/Parent/Guardian):" />

                            <!-- 1.10(b). Alternate Mobile Number -->
                            <v-text-field v-model="alternate_mobile" label="1.10(b) Alternate Mobile Number:" />

                            <!-- 1.11. Contact Email-ID -->
                            <v-text-field v-model="email" label="1.11 Contact Email-ID (of Student/Parent/Guardian):" />

                            <!-- 1.12. Mother Tongue -->
                            <v-text-field v-model="mother_tongue" label="1.12 Mother Tongue of the Student:" />

                            <!-- 1.13. Social Category -->
                            <v-select v-model="social_category" :items="socialCategoryLookUp"
                                label="1.13 Social Category: capitalist farmers (1) / rich peasants (2) / middle peasants (3) / marginal peasants (4) / landless (5)" />


                        </v-expansion-panel-text>
                    </v-expansion-panel>

                    <v-expansion-panel>
                        <v-expansion-panel-title>2. Enrollment Details Of Student In Present School For Current Year
                        </v-expansion-panel-title>
                        <v-expansion-panel-text>
                            <v-text-field v-model="academic_year" label="Academic Year: 2022-23" />
                            <v-text-field v-model="udise_code" label="UDISE Code of School:" />
                            <v-text-field v-model="admission_number" label="2.1 Admission Number in School:" />
                            <v-container>
                                <v-date-picker header="Admission Date" v-model="admission_date"
                                    title="2.2 Present Class (DD/MM/YYYY):" />
                                <v-select v-model="stream_opted" :items="streamOptedLookups"
                                    label="2.3 Academic Stream Opted (For Higher Secondary): Art (1) / Science (2) / Commerce (3) / Vocational (4) / Other (5)" />

                            </v-container>
                        </v-expansion-panel-text>
                    </v-expansion-panel>

                    <v-expansion-panel>
                        <v-expansion-panel-title>3. Facilities & Other Details of Student</v-expansion-panel-title>
                        <v-expansion-panel-text> Some content </v-expansion-panel-text>
                    </v-expansion-panel>
                    <v-expansion-panel>
                        <v-expansion-panel-title>4. Upload Photo</v-expansion-panel-title>
                        <v-expansion-panel-text>
                            Some Content

                        </v-expansion-panel-text>
                    </v-expansion-panel>

                </v-expansion-panels>

                <!-- Submit Button -->
                <v-btn class="mt-2" type="submit" block>Submit</v-btn>
            </v-form>
        </v-sheet>
    </v-container>
</template>

<script>

export default {
    

    data: () => ({
        panel: [0, 1],
        student_name: '',
        student_name_rules: [
            value => value?.length >= 3 || 'First name must be at least 3 characters.',
        ],
        gender: null,
        genderLookUp: ['Male', 'Female', 'Transgender'],
        gender_rules: [value => value !== null || 'Gender is required.'],
        dob: '',
        dob_rules: [
            value => !!value || 'Date of Birth is required',
            value => /^\d{2}\/\d{2}\/\d{4}$/.test(value) || 'Enter date in DD/MM/YYYY format'
        ],
        academic_year: '',
        udise_code: '',
        mother_name: '',
        father_name: '',
        guardian_name: '',
        nid_number: '',
        brn_number: '',
        address: '',
        pincode: '',
        mobile_number: '',
        alternate_mobile: '',
        email: '',
        mother_tongue: '',
        social_category: null,
        socialCategoryLookUp: ['Capitalist Farmers', 'Rich Peasants', 'Middle Peasants', 'Marginal Peasants', 'Landless'],
        stream_opted: null,
        streamOptedLookups: ['Art', 'Science', 'Commerce', 'Vocational', 'Others'],


    }),
}
</script>
