<template>
       <v-container >
    <v-card>
        <ExamQuestionModel />
    </v-card>
    <v-stepper v-model = "exam_counter" alt-labels :editable="false" disabled="true" accordion>
        <v-stepper-header class="pt-16 mt-2" >

            <v-stepper-item align="center" :value="1" >

                <span class="justify-space-evenly" >
                    <StepperTopElementContainer itemProps="1" />
                </span>
                <span class="mt-n6"> Setup Exam</span>
            </v-stepper-item>

            <v-divider></v-divider>

            <v-stepper-item align="center" :value="2" >

                <span class="justify-space-evenly" >
                    <StepperTopElementContainer itemProps="2" />
                </span>
                Create Exam
            </v-stepper-item>

            <v-divider></v-divider>
            <v-stepper-item align="center" :value="3" >

                <span class="justify-space-evenly" >
                    <StepperTopElementContainer itemProps="3" />
                </span>
                Mark Distribution
            </v-stepper-item>

            <v-divider></v-divider>
            <v-stepper-item align="center" :value="4" >

                <span class="justify-space-between" >
                    <StepperTopElementContainer itemProps="4" />
                </span>
                Preview Exam
            </v-stepper-item>
        </v-stepper-header>

        <v-stepper-window>
            <v-stepper-window-item :value="1">
                <ExamSetup />
            </v-stepper-window-item>


            <!-- Create Question -->
            <v-stepper-window-item :value="2">
                <ExamCreate />
            </v-stepper-window-item>

            <!-- Preview -->
            <v-stepper-window-item :value="3">
                Mark Distribution
            </v-stepper-window-item>

            <!-- Preview -->
            <v-stepper-window-item :value="4">
                Preview
            </v-stepper-window-item>
  

        </v-stepper-window>
        
        <v-stepper-actions prev-text = "Back" next-text="Continue" @click:next="next" @click:prev="prev" :disabled="disabled('next')"
        
        />


    </v-stepper>




</v-container>
</template>


<script setup>
import ExamSetup from '@/components/forms/exam_form/ExamSetup.vue';
import ExamCreate from '@/components/forms/exam_form/ExamCreate.vue';
import ExamQuestionModel from '@/components/ExamQuestionModel.vue';
import StepperTopElementContainer from '@/components/StepperTopElementContainer.vue';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
const examStore = useExamQuestionModelStore();
const exam_counter = ref(1);

// Stepper Action Methods
const steps = ref(4); // Total number of steps

const next = () => {
  if (exam_counter.value < steps.value) {
    exam_counter.value++;
  }
};

const prev = () => {
  if (exam_counter.value > 1) {
    exam_counter.value--;
  }
};
// Stepper Action Methods Ends

// Disabled Login
const disabled = (direction) => {
  const examStore = useExamQuestionModelStore();

  if (direction === 'prev') {
    // Disable 'Prev' if it's the first step
    return exam_counter.value === 1; 
  }
  if (direction === 'next') {
    // Disable 'Next' if it's the last step or if exam is not complete
    return exam_counter.value === steps.value || !examStore.isComplete();
  }
  return false;
};

// Disabled Login Ends


</script>
<style scoped>
.mdi-pencil{
    background-color: black;
}
</style>