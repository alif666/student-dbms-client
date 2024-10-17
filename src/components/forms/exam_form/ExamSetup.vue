<template>
  <v-card class="d-flex flex-column mb-6">
    <!-- Class Information Section -->
    <v-sheet class="ma-2 pa-2">
      <CardElement header_title="Class Information">

        <v-date-input center-affix v-model="examStore.exam_question_model.exam_date"
          label="Date of Exam"/>
        <v-text-field type="text" prepend-icon="mdi-calendar"  v-model="examStore.exam_question_model.exam_year"
          label="Exam Year"/>
        
        <v-autocomplete prepend-icon="mdi-school"v-model="examStore.exam_question_model.exam_category" label="Type of Exam "
          :items="exam_categories" />
        <v-autocomplete prepend-icon="mdi-account-box-multiple" v-model="examStore.exam_question_model.exam_for_class" label="Class " :items="classes"
          item-value="id" item-title="value_en" />
        <v-autocomplete prepend-icon="mdi-account-box-multiple" v-model="examStore.exam_question_model.class_section" label="Sections" :items="sections"
          item-value="id" item-title="value_en" />
      </CardElement>
    </v-sheet>


    <!-- Exam Information Section -->
    <v-sheet class="ma-2 pa-2">
      <CardElement header_title="Exam Information">
        <v-text-field type="text" prepend-icon="mdi-school"  v-model="examStore.exam_question_model.exam_name"
          label="Name of Exam" :hint="(examStore.exam_question_model.exam_for_class&&examStore.exam_question_model.exam_category)? examStore.exam_question_model.exam_category+' | '+examStore.exam_question_model.exam_year+' | Class'+examStore.exam_question_model.exam_for_class:'Display on Heading Section'"/>


        <!-- examStore.exam_question_model.total_marks -->

        <v-text-field v-model.number="examStore.exam_question_model.total_marks" prepend-icon="mdi-calculator" :rules="totalMarksRules" @input="(e) => {
          const value = e.target.value === '' ? 0 : Number(e.target.value);
          examStore.addFieldToSections('section_mark_each', value, n);
        }" type="number" label="Total Marks" min="0" step="1" variant="solo-filled"
          hint="Exam Total Marks" />
        <!-- duration -->
  
        <TimeDurationInputField />
        
        <!-- Exam Subject -->
        <v-autocomplete v-model="examStore.exam_question_model.exam_subject" label="Exam Subject" prepend-icon="mdi-book-multiple" :items="exam_subjects"
          item-value="id" item-title="value_en" />



      </CardElement>
    </v-sheet>


    <!-- Remarks Section -->
    <v-sheet class="ma-2 pa-2">
      <CardElement header_title="Remarks">
        <v-textarea v-model="examStore.exam_question_model.additional_remark" label="Additional Remark"
          variant="filled" />
      </CardElement>
    </v-sheet>

  </v-card>
</template>

<script setup>
import { fetchClassNameLookup, fetchSectionLookup, fetchSubjectLookUp } from '@/stores/data-services';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
import { onMounted } from 'vue';
import { useDate } from 'vuetify';
import { VDateInput } from 'vuetify/labs/components';

const date = useDate();
// const exam_subjects = ['English', 'Bangla', 'Math'];
// const classes = ['Class I', 'Class II', 'Class III'];
const exam_categories = ['Half Semester', 'Class Test', 'Final'];
// const sections = ['A', 'B', 'C', 'D'];
// ################### LOOKUPS ########################

// State variables initialized with expected structure to avoid undefined
// const schoolData = ref({ name: '' });
const classes = ref([]);
// const classGroupLookUp = ref([]);
const sections = ref([]);
const exam_subjects = ref([]);

// Load data functions
async function loadSchoolData() {
  schoolData.value = await fetchSchoolById({ id: 1 });
}

async function loadLookups() {
  classes.value = (await fetchClassNameLookup()).data;

  // classGroupLookUp.value = (await fetchClassGroupLookUp()).data;
  // console.log("ClassGroupLookup",classGroupLookUp.value);
  sections.value = (await fetchSectionLookup()).data;
  // console.log("SectionLookup",sectionLookUp.value);
  exam_subjects.value = (await fetchSubjectLookUp()).data;
  // console.log("Subject Lookup",subjectLookUp.value);
}

// Load data on component mount
onMounted(async () => {
  // await loadSchoolData();
  await loadLookups();
});
// ################### LOOKUPS ENDS ###################
const examStore = useExamQuestionModelStore();
const duration = ref(null);
// Validation Rules

const totalMarksRules = [
  v => (v && v >= 0 && v <= 100) || 'Should be between 0 and 100',
];



const examSubjectRules = [
  v => {
    const normalizedInput = (v || '').trim().toLowerCase();
    return normalizedInput || 'Need to create this new exam subject, please click Add new exam subject';
  }
];
const examForClassRules = [
  v => {
    const normalizedInput = (v || '').trim().toLowerCase();
    // const normalizedClasses = classes.map((classItem,index) => classItem.toLowerCase()); // Use classes instead of exam_subjects
    return normalizedInput || 'Class not found';
  }
];


const handleTimeChange = (selectedTime) => {
  console.log("### TIME DURATION ###");
  console.log(selectedTime)
  duration.value = selectedTime;
  console.log('Selected duration:', duration.value);
};



// Validatoin Rules Ends
</script>