<script setup>
import { ref } from 'vue'
import { VuetifyTiptap, VuetifyViewer } from 'vuetify-pro-tiptap'
import 'vuetify-pro-tiptap/style.css'
import { BaseKit, Bold, Italic, Underline, Strike, Color, Highlight, Heading, Link, Image, Video, Table, Fullscreen, History } from 'vuetify-pro-tiptap'


const props = defineProps({
  rich_heading:String,
})

const extensions = [
  BaseKit.configure({
    placeholder: {
      placeholder: 'Enter some text...'
    }
  }),
  Bold,
  Italic,
  Underline,
  Strike,
  Color,
  Highlight,
  Heading,
  Link,
  Image,
  Video,
  Table,
  Fullscreen,
  History
]

const content = ref('')
</script>

<template>
  <v-app id="app">
    <v-container>
      <VuetifyTiptap v-model="content" alt-labels :label="rich_heading" rounded :min-height="200" :max-height="465" :max-width="900" :extensions="extensions"  />
      <VuetifyViewer :value="content" />
    </v-container>
  </v-app>
</template>