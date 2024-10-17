<template>
    <CardElement header_title="Image Upload">
      <!-- File input for image upload -->
      <v-file-input v-model="image_content"
      @change="handleUpdate"
    accept="image/*"
    label="Upload"
    prependIcon="mdi-camera"
    variant="filled"
  ></v-file-input>
      <!-- Image Preview -->
      <div v-if="imagePreview" class="image-preview">
        <img :src="imagePreview" alt="Image Preview" class="uploaded-image" />
      </div>
  
      <!-- Display the selected file object -->
      <p>{{ image_content }}</p>
    </CardElement>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  
  const image_content = ref(null); // Store selected file
  const imagePreview = ref(null);  // Store image preview (data URL)
  
  const handleUpdate = (event) => {
    const file = event.target.files[0]; // Access the selected file
    if (file && file.type.startsWith('image/')) {
      const reader = new FileReader();
      reader.onload = (e) => {
        imagePreview.value = e.target.result; // Set the preview to the data URL
      };
      reader.readAsDataURL(file); // Convert image file to data URL
    } else {
      imagePreview.value = null; // Reset if no image is selected
    }
  };
  </script>
  
  <style scoped>
  .uploaded-image {
    max-width: 250px;
    height: auto;
    margin-top: 10px;
  }
  
  .image-preview {
    margin-top: 20px;
  }
  </style>
  