<template>
  <v-app>
    <v-layout>
      <AppHeader /> <!-- Ensure this is outside of <router-view /> to apply to all pages -->
      <v-main>
        <router-view /> <!-- This will render the content of each route -->

      </v-main>
    </v-layout>
  </v-app>

</template>

<script setup>
import AppHeader from '@/components/AppHeader.vue';
import AppFooter from '@/components/AppFooter.vue';
</script>
