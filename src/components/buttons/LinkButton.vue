<template>
    <v-btn
      :color="color"
      :variant="variant"
      :icon="icon"
      :prepend-icon="prependIcon"
      :append-icon="appendIcon"
      :disabled="disabled"
      class="text-none"
      size="small"
      @click="navigateTo"
    >
      {{ text }}
    </v-btn>
  </template>
  
  <script setup>
  import { useRouter } from 'vue-router';
  
  // Props to define button behavior and styles
  const props = defineProps({
    text: {
      type: String,
      default: 'Click me',
    },
    path: {
      type: String,
      required: true, // The path to navigate to
    },
    color: {
      type: String,
      default: 'primary', // Button color
    },
    variant: {
      type: String,
      default: 'flat', // Can be 'flat', 'outlined', 'contained', etc.
    },
    icon: {
      type: Boolean,
      default: false, // Define if the button is an icon button
    },
    prependIcon: {
      type: String,
      default: '', // Prepend icon class
    },
    appendIcon: {
      type: String,
      default: '', // Append icon class
    },
    disabled: {
      type: Boolean,
      default: false, // Define if the button is disabled
    },
  });
  
  // Router for navigation
  const router = useRouter();
  
  // Function to handle navigation
  const navigateTo = () => {
    if (!props.disabled && props.path) {
      router.push(props.path);
    }
  };
  </script>
  