<script setup>
import { ref, watch } from 'vue';
import VueDocumentEditor from 'vue-document-editor';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';

// Access the store
const examStore = useExamQuestionModelStore();

// Reactive content for the document editor
const content = ref([]);

// Function to generate HTML content from exam question model
const generateExamContent = () => {
    const examData = examStore.exam_question_model;
    // Start building the HTML content
    let generatedContent = `
    <h1>${examData.exam_name}</h1>
    <p><strong>Date: </strong> ${examData.exam_date}</p>
    <p><strong>Class: </strong> ${examData.exam_for_class} | <strong>Section:</strong> ${examData.class_section}</p>
    <p><strong>Total Marks:</strong> ${examData.total_marks}</p>
    <p><strong>Duration:</strong> ${examData.time_duration_hours} hours ${examData.time_duration_minutes} minutes</p>
    <hr/>`;

    // Loop through sections and add them to the content
    examData.sections.forEach((section, index) => {
        generatedContent += `
      <h3>Q ${index + 1}: ${section.section_title}  ${section.section_mark_each}  X  ${section.section_number_of_questions} = ${section.section_mark_each*section.section_number_of_questions}</h3>
      <p><strong>Category:</strong> ${section.question_category}</p>
      <hr/>`;
    });

    // Add any additional remarks
    generatedContent += `<p><strong>Additional Remarks:</strong> ${examData.additional_remark.value}</p>`;

    return generatedContent;
};

// Watch the exam question model for changes and update the content
watch(() => examStore.exam_question_model, () => {
    content.value.push(generateExamContent());
}, { immediate: true });

</script>

<template>
    <div style="font-family: Avenir, sans-serif">
        <vue-document-editor v-model:content="content" /> <!-- Vue 3 syntax -->
        <!-- <vue-document-editor :content.sync="content" /> --> <!-- Vue 2 syntax -->
    </div>
</template>