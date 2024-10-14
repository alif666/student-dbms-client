<template>
  <DialogPopUp 
    button_text="Show Exam Details" 
    title_label="Exam Information" 
    title_text_icon="mdi-information" 
    :button_text="Open"
  >
    <!-- Pass the model to another component -->
     <h3 align="center">Exam Question Model</h3>
    <ModelViewTemplate :model_object="exam_question_model" />

    <span align="center" class="text-overline">
      {{ examStore.isComplete() }}
    </span> 
     
    <v-list-item>
                    
                    <v-btn @click="generateHeaderDoc">
                        Generate Header
                    </v-btn>
                </v-list-item>

                <v-list-item>
                    
                    <v-btn @click="generateExamQuestionsDoc">
                        Generate Questions
                    </v-btn>
                </v-list-item>
                <v-list-item>
                    
                    <v-btn @click="previewExamQuestionModel">
                        Preview Exam Question Model
                    </v-btn>
                </v-list-item>

  </DialogPopUp>
</template>

<script setup>
import { useExamQuestionModelStore } from '../stores/examQuestionModelStore';
import DialogPopUp from './DialogPopUp.vue';
import LookUps from './LookUps.vue';
import ModelViewTemplate from './ModelViewTemplate.vue';
import { generateHeaderDoc } from '@/stores/word-api/templates/header_insert';
import { generateExamQuestionsDoc } from '@/stores/word-api/templates/question_insert';

const previewExamQuestionModel = () => {
    console.log(examStore.exam_question_model);
}

// Access the store
const examStore = useExamQuestionModelStore();

// Access the model from the store
const exam_question_model = examStore.exam_question_model;
const exam_section_model = examStore.exam_section_model;

</script>
