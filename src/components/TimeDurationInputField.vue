<template>
      <v-row>
          <v-col cols="6">
            <v-text-field v-model="examStore.exam_question_model.time_duration_hours" prepend-icon="mdi-clock" :rules="totalMarksHoursRules" type="number" label="Duration (hh)" min="1" max="24"   step="1" variant="solo-filled"
          hint="Duration of Exam (Hours)" />
          </v-col>
          <v-col cols="6">
            <v-text-field v-model="examStore.exam_question_model.time_duration_minutes" prepend-icon="mdi-clock-outline" :rules="totalMarksMinutesRules" type="number" label="Duration (minutes)" min="1" max="60" step="1" variant="solo-filled"
          hint="Duration of Exam (Minutes)" />
          </v-col>
        </v-row>
</template>

<script setup>
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';

const examStore = useExamQuestionModelStore();

const totalMarksHoursRules = [
    v=> !!v && (v>=1 && v<24) || "Maximum hours in a day is 24"
];

const totalMarksMinutesRules = [
    v=> !!v && (v>=0 && v<60) || "Maximum 60 minutes in an hour"
];

</script>