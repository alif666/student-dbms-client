<template>
    <v-container flat>
        <!-- <v-card>
            <ExamQuestionModel />
        </v-card> -->
        <v-stepper v-model="exam_counter" :complete="exam_counter>steps" steps="4" alt-labels :editable="false" >
            <v-stepper-header class="pt-16 mt-2">

                <v-stepper-item  align="center" :complete="exam_counter>'1'"  :value="1">
                    
                    <span class="justify-space-evenly">
                        <StepperTopElementContainer itemProps="1" />
                    </span>
                    <span class="mt-n6"> 
                     Exam Create
                    </span>
                </v-stepper-item>

                <v-divider length="align-content" :color="getDividerColor(1)" thickness="4px"></v-divider>
               
                <v-stepper-item align="center"   :value="2" :complete="exam_counter>'2'" >

                    <span class="justify-space-evenly">
                        <StepperTopElementContainer itemProps="2" />
                    </span>
                   Add Questions
                </v-stepper-item>

                <v-divider length="align-content"  :color="getDividerColor(2)" thickness="4px"></v-divider>
                <v-stepper-item align="center"  :value="3" :complete="exam_counter>'3'" >

                    <span class="justify-space-evenly">
                        <StepperTopElementContainer itemProps="3" />
                    </span>
                   Preview Question
                </v-stepper-item>

                <v-divider length="align-content" :color="getDividerColor(3)" thickness="4px"></v-divider>
                <v-stepper-item align="center"  :value="4" :complete="exam_counter>'4'" >

                    <span class="justify-space-between">
                        <StepperTopElementContainer itemProps="4" />
                    </span>
                   Submission
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
                    <ExamPreview/>
                </v-stepper-window-item>

                <!-- Preview -->
                <v-stepper-window-item :value="4" >
                    Are you sure you want to submit?
                    <br>
                    <v-btn class="mt-2" variant="elevated">Yes</v-btn>
                    <br>
                    <v-btn class="mt-2" variant="elevated">No</v-btn>
                </v-stepper-window-item>


            </v-stepper-window>
            <span v-if="exam_counter === 1">
                <v-stepper-actions prev-text="" next-text="Next" @click:next="next" @click:prev="prev"
                  :disabled="disabled('next')"
                     />
            </span>
            <span v-else-if="exam_counter === steps">
                <v-stepper-actions prev-text="Previous" next-text="" @click:next="next" @click:prev="prev"
                    :disabled="disabled('next')" />
            </span>
            <span v-else>
                <v-stepper-actions prev-text="Previous" next-text="Next" @click:next="next" @click:prev="prev"
                    :disabled="disabled('next')" />
            </span>
            {{exam_counter}}

        </v-stepper>




    </v-container>
</template>


<script setup>
import ExamSetup from '@/components/forms/exam_form/ExamSetup.vue';
import ExamCreate from '@/components/forms/exam_form/ExamCreate.vue';
import ExamQuestionModel from '@/components/ExamQuestionModel.vue';
import StepperTopElementContainer from '@/components/StepperTopElementContainer.vue';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
import { VStepperItem } from 'vuetify/components';
const examStore = useExamQuestionModelStore();
const exam_counter = ref(1);

// Stepper Action Methods


const steps = ref(4); // Total number of steps
// Method to check if a step is complete and set divider color
const getDividerColor = (step) => {
  return exam_counter.value > step ? '#48AD64' : '#E1E1E1';
};

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
    // const examStore = useExamQuestionModelStore();

    // if (direction === 'prev') {
    //     // Disable 'Prev' if it's the first step
    //   if(exam_counter.value === 1) {
    //     return true;
    //   }
    // }
    // if (direction === 'next') {
    //     // Disable 'Next' if it's the last step or if exam is not complete
    //     if(exam_counter.value===1){
    //         if(exam_counter.value === steps.value || !examStore.isComplete()){
    //             return true;
    //         }
    //     }
      
    // }
    return false;
};

// Disabled Login Ends


</script>
<style scoped>
.mdi-pencil {
    background-color: black;
}

::v-deep .v-stepper-item--complete .v-stepper-item__avatar.v-avatar,
::v-deep .v-stepper-item--selected .v-stepper-item__avatar.v-avatar{
    background-color: #48AD64  !important; 
    color: #FFFFFF !important;
  } 

 
</style>
