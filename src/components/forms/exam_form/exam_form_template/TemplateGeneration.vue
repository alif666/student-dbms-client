<template>
<v-row>
  <v-col cols="12">
    <v-select v-model="questionCategory" :items="examStore.question_type_lookup" item-title="name" item-value="name" label="Type of Questions" single-line />
    <span v-if="questionCategory==='Text'">
      <DocInputElement :fieldName="fieldName" :content="content"/>
    </span>
    <span v-if="questionCategory==='Image'">
      <DocImageUploadElement :fieldName="fieldName" :content="content"/>
    </span>
    <span v-if="questionCategory==='TextImage'">
      <DocInputElement  :fieldName="fieldName" :content="content"/>
      <DocImageUploadElement  :fieldName="fieldName" :content="content"/>
    </span>
  </v-col>
</v-row>
</template>
<script setup>
  import DocInputElement from './Demo/DocInputElement.vue';
  import DocImageUploadElement from './Demo/DocImageUploadElement.vue';
  import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
  const props = defineProps({
    content: {
      type: Array,
      default: () => [],
    },
    fieldName: String
  });
  const examStore = useExamQuestionModelStore();
  const questionCategory = ref(null);
  const content =ref(props.content);
  const fieldName = ref(props.fieldName);
</script>