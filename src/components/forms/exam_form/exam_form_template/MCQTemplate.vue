<template>

  <v-row>
    <!-- Pass field name and collect data from TemplateGeneration -->
    <TemplateGeneration 
      :nProps="nProps" 
      :iProps="iProps" 
      fieldName="question_title" 
      @updateFieldType="handleFieldUpdate" 
    />
    
    <!-- Select number of options for MCQ -->
    <v-select v-model="numberOfOptions" 
              :items="Array.from({ length: 19 }, (v, i) => i + 1)"
              label="Number of Options" />
    </v-row>
    <v-row>
    <!-- Dynamically generate options based on numberOfOptions -->
    <template v-if="numberOfOptions > 0">
      <v-row>
        <template v-for="o in numberOfOptions" :key="o">
          <CardElement :header_title="`Option ${o}`">
            <TemplateGeneration 
              :fieldName="`question_options[${o}]`" 
              @updateFieldType="handleFieldUpdate" 
            />
            
          </CardElement>
        </template>

        <CardElement header_title="Correct Option">
          <v-select v-model="correctOption" 
                    :items="Array.from({ length: numberOfOptions }, (v, i) => i + 1)"
                    label="Correct Option" />
        </CardElement>
      </v-row>
    </template>
  </v-row>

</template>

<script setup>
import { ref } from 'vue';
import TemplateGeneration from './TemplateGeneration.vue';
import CardElement from '@/components/CardElement.vue';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
const examStore = useExamQuestionModelStore();
const props = defineProps({
  question_category: String,
  iProps: Number,
  nProps: Number,
});

const question_title_content = [`<strong>Question ${props.iProps}</strong>`];
const numberOfOptions = ref(0); // Track number of options
const correctOption = ref(null); // Track correct option

// Function to handle updates from TemplateGeneration
const handleFieldUpdate = (data) => {
  console.log('Field Name:', data.fieldName);
  console.log('Question Type:', data.type);
  console.log(examStore.content);
  
  // You can store or process this data as needed
  // For example, you can push it to an array or object
};

// Watch for changes in examStore.content
watch(
  () => examStore.content,
  (newContent, oldContent) => {
    console.log("Section Index:", props.nProps); // Log nProps
    console.log("Question Index:", props.iProps); // Log iProps
    console.log("Content changed from:", oldContent, "to:", newContent); // Log content changes
    // Implement additional logic here if needed
  },
  { deep: true } // Use deep watching if content is an array or object
);
</script>
