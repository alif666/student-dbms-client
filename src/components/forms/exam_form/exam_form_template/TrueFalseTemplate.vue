<template>
    <v-row>
      <CardElement header_title="Question 1">
        <TemplateGeneration />
        <v-select
          v-model="numberOfOptions"
          :items="Array.from({ length: 19 }, (v, i) => i + 1)"
          label="Number of Options"
        />
      </CardElement>
    </v-row>
  
    <!-- Dynamically generate options based on numberOfOptions -->
     <template v-if="numberOfOptions>0">
        <v-row>
    <template v-for="o in numberOfOptions" :key="o">
   
        <CardElement :header_title="`Option ${o}`">
          <TemplateGeneration />
        </CardElement>
 
    </template>
    <CardElement header_title="Correct Option">
        <v-select
          v-model="numberOfOptions"
          :items="Array.from({ length: numberOfOptions }, (v, i) => i + 1)"
          label="Correct Option"
        />
    </CardElement>
</v-row>
</template>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  
  const numberOfOptions = ref(0); 
  </script>
  