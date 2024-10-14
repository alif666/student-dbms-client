<template>
    <v-row align-content="space-evenly">
      <v-col cols="2">
        Option A:
      </v-col>
      <v-col cols="4">
        <v-text-field
          type="text"
          v-model="question_options[0]"
          label="Option A"
        />
      </v-col>
      <v-col cols="2">
        Option B:
      </v-col>
      <v-col cols="4">
        <v-text-field
          type="text"
          v-model="question_options[1]"
          label="Option B"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="2">
        Option C:
      </v-col>
      <v-col cols="4">
        <v-text-field
          type="text"
          v-model="question_options[2]"
          label="Option C"
        />
      </v-col>
      <v-col cols="2">
        Option D:
      </v-col>
      <v-col cols="4">
        <v-text-field
          type="text"
          v-model="question_options[3]"
          label="Option D"
        />
      </v-col>
    </v-row>
    <v-row align-content="space-evenly">
      <v-col cols="12">
        <v-select
          v-model="correct_answer"
          :items="options"
          item-title="name"
          item-value="code"
          label="Correct Option:"
          single-line
          hint="name"
          hide-no-data
        />
      </v-col>
    </v-row>
  </template>
  
  <script setup>
  const props = defineProps({
    question_options: Array,
    correct_answer: String,
  });
  
  const options = [
    { code: 1, name: 'Option: A' },
    { code: 2, name: 'Option: B' },
    { code: 3, name: 'Option: C' },
    { code: 4, name: 'Option: D' },
  ];
  </script>
  