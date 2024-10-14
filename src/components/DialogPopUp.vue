<template>
  <div class="text-center pa-4">
    <v-dialog v-model="dialog" max-width="400" persistent>
      <template v-slot:activator="{ props: activatorProps }">
        <v-btn v-bind="activatorProps">
          {{ button_text }}
        </v-btn>
      </template>

      <v-card>

        >
        <v-card-title :prepend-icon="title_text_icon" :title="title_label">

        </v-card-title>
        <slot></slot>

        <template v-slot:actions>
          <v-spacer></v-spacer>



          <v-btn prepend-icon="mdi-close" @click="dialog = false">
            Close
          </v-btn>


        </template>
      </v-card>
    </v-dialog>
  </div>
</template>
<script setup>
const dialog = ref(false);
const props = defineProps({
  button_text: String,
  title_label: String,
  title_text_icon: String,
});
</script>