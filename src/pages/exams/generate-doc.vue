<template>
    <v-container>
        <DefaultButton
        :prepend-icon="'mdi-open-in-new'"
        color="primary"
        variant="tonal"
        :onClick="callGenerateDoc"
        text="Generate Doc"
        />
    </v-container>
    </template>



<script setup>
    import DefaultButton from "@/components/buttons/DefaultButton.vue"
    import {generateWordDocument} from '@/stores/word-api/templates/scolastica_templates'
    const callGenerateDoc = async()=>{
        console.log("########## Word - API ##### call Generate Doc");
        await generateWordDocument();
    }

</script>