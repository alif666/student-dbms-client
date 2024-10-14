<template>
            <v-text-field v-model="exam_question_model.time_duration" :active="menu2" :focus="menu2" :label="labelProps"
                append-inner-icon="mdi-clock-time-four-outline"  readonly >
                <v-menu v-model="menu2" :close-on-content-click="false" activator="parent"
                    transition="scale-transition">
                    <v-time-picker v-if="menu2" v-model="exam_question_model.time_duration" title="Duration of Exam" ></v-time-picker>
                </v-menu>
            </v-text-field>
</template>

<script setup>
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
import { VTimePicker } from 'vuetify/labs/components';
const props = defineProps({
    labelProps : String,
    // handleOnChange: Function,

});

// const time = ref(null);
const menu2 = ref(false);
const examStore = useExamQuestionModelStore();
const exam_question_model = examStore.exam_question_model;
exam_question_model.time_duration = ref(null);

// const onTimeChange = () =>{
//     e.preventDefault();
    
//     console.log("### OnTIMECHANGE");
//     if(props.handleOnChange){
//         props.handleOnChange = time.value;
//     }
// }
</script>