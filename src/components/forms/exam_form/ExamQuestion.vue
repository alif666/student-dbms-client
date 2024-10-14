<template>
  <v-text-field v-model="question.question_title" type="text" label="Enter Question" />

  <!-- CONDITIONS FOR QUESTION PATTERNS -->
  <template v-if="question_category === 'MCQ'">
    <v-text-field v-model="question.question_options[0]" label="Option A" />
    <v-text-field v-model="question.question_options[1]" label="Option B" />
    <v-text-field v-model="question.question_options[2]" label="Option C" />
    <v-text-field v-model="question.question_options[3]" label="Option D" />
    <v-select :items="question.question_options" v-model="question.correct_answer" label="Correct Answer" />
  </template>

  <template v-if="question_category === 'TRUE_FALSE'">
    <v-text-field v-model="question.question_options[0]" label="True" />
    <v-text-field v-model="question.question_options[1]" label="False" />
    <v-select :items="question.question_options" v-model="question.correct_answer" />
  </template>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
import { toRaw } from 'vue';
const examStore = useExamQuestionModelStore();

// Define props for question category, section index (nProps), and question index (iProps)
const props = defineProps({
  question_category: String,
  iProps: Number, // Question index within the section
  nProps: Number, // Section index
  questionModel: {
      type: Object,
      required: true
    },
  emits:['handleChange'],
});

// Local state for the question data
const question = ref({
  question_title: '',
  question_options: ['', '', '', ''], // Default to empty options for MCQs or TRUE/FALSE
  correct_answer: '',
  category: props.question_category,
});

// Watch for changes in question data and update the store
watch(
  () => toRaw(question.value), // Get a non-reactive version of the question object
  (newQuestion) => {
    examStore.updateQuestionInSection(props.nProps, props.iProps, 'question', toRaw(newQuestion));
  },
  { deep: true }
);
// Method to update question data from the store when the component is mounted
onMounted(() => {
  const section = examStore.exam_question_model.sections[props.nProps - 1];
  if (section && section.questions[props.iProps - 1]) {
    question.value = section.questions[props.iProps - 1]; // Load the existing question data
  }
});



</script>
