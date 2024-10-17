<template>
  <!-- CONDITIONS FOR QUESTION PATTERNS -->
  <!-- <template v-if="question_category === 'MCQ'">
    <v-text-field v-model="question.question_options[0]" label="Option A" />
    <v-text-field v-model="question.question_options[1]" label="Option B" />
    <v-text-field v-model="question.question_options[2]" label="Option C" />
    <v-text-field v-model="question.question_options[3]" label="Option D" />
    <v-select :items="question.question_options" v-model="question.correct_answer" label="Correct Answer" />
  </template> -->
  
  <template v-if="question_category === 'MCQ'">
    <CardElement :header_title="`Question ${nProps}-${iProps}`">
    <MCQTemplate :nProps = "nProps" :iProps="iProps"/>
  </CardElement>
  </template>

</template>
<script setup>
import { ref, watch, onMounted, toRaw } from 'vue';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
import DocInputElement from './exam_form_template/Demo/DocInputElement.vue';
import DocImageUploadElement from './exam_form_template/Demo/DocImageUploadElement.vue';
import TemplateGeneration from './exam_form_template/TemplateGeneration.vue';
import MCQTemplate from './exam_form_template/MCQTemplate.vue';

const examStore = useExamQuestionModelStore();

// Define props for question category, section index (nProps), and question index (iProps)
const props = defineProps({
  question_category: String,
  iProps: Number, // Question index within the section
  nProps: Number, // Section index
});

const emit = defineEmits(['handleChange']); // Declare 'handleChange' event

// Local state for the question data
const question = ref({
  question_title: '',
  question_options: [], // Default to empty options for MCQs or TRUE/FALSE
  correct_answer: '',
  category: props.question_category,
});

// Watch for changes in question data and update the store
watch(
  () => toRaw(question.value), // Get a non-reactive version of the question object
  (newQuestion) => {
    examStore.updateQuestionInSection(props.nProps, props.iProps, 'question', toRaw(newQuestion));
    emit('handleChange', toRaw(newQuestion)); // Emit handleChange event with the updated question data
  },
  { deep: true }
);

// Method to update question data from the store when the component is mounted
onMounted(() => {
  console.log("EXAM QUESTIONS MOUNTED #####################################");
  console.log("iProps ",props.iProps);
  console.log("nProps",props.nProps);
  console.log(examStore.exam_question_model.sections[props.nProps-1].questions[props.iProps-1]);
  const section = examStore.exam_question_model.sections[props.nProps - 1];
  if (section && section.questions[props.iProps - 1]) {
    question.value = section.questions[props.iProps - 1]; // Load the existing question data
  }
});
</script>
