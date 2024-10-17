<template>
  <v-container>
  <v-sheet>
    <v-row>
    <v-col cols="12">
      <v-select 
        v-model="questionCategory" 
        :items="examStore.question_type_lookup" 
        item-title="name" 
        item-value="name"
        label="Type of Questions" 
        single-line 
      />
      </v-col>
      </v-row>
      <v-row>
        <v-col cols = "12">
      <!-- Conditionally render components based on questionCategory -->
      <span v-if="questionCategory === 'Text'">
        <DocInputElement 
          :sectionIndex="nProps" 
          :questionIndex="iProps" 
          :fieldName="fieldName" 
          @updateContent="updateContent"
        />
      </span>

      <span v-if="questionCategory === 'Image'">
        <DocImageUploadElement 
          :fieldName="fieldName" 
          @updateContent="updateContent"
        />
      </span>

      <span v-if="questionCategory === 'TextImage'">
        <DocInputElement 
          :fieldName="fieldName" 
        />
        <DocImageUploadElement 
          :fieldName="fieldName" 
          @updateContent="updateContent"
        />
      </span>
    </v-col>
  </v-row>
  </v-sheet>
  </v-container>

</template>

<script setup>
import { ref, watch, defineEmits } from 'vue';
import DocInputElement from './Demo/DocInputElement.vue';
import DocImageUploadElement from './Demo/DocImageUploadElement.vue';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';

// Define props
const props = defineProps({
  iProps: Number,
  nProps: Number,
  fieldName: String
});

// Define Pinia store
const examStore = useExamQuestionModelStore();

// Define emits to send data to parent
const emit = defineEmits(['updateFieldTypeAndData']);

// Define state variables
const questionCategory = ref(null); // This will track the selected question type

// Watch for changes in questionCategory and emit the type, fieldName, and content
watch(() => questionCategory.value, (newValue) => {
  emit('updateFieldTypeAndData', {
    fieldName: props.fieldName, 
    type: newValue, 
    
  });
});

// Update content and emit
const updateContent = () => {
  emit('updateFieldTypeAndData', {
    fieldName: props.fieldName, 
    type: questionCategory.value, 
    
  });
};
</script>
