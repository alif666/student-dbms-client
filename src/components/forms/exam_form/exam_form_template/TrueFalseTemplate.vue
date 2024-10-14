<template>
    <v-row align-content="space-evenly">
        <v-col cols="2">
            If TRUE
        </v-col>
        <v-col cols="4">
            <v-text-field type="text" />
        </v-col>
        <v-col cols="2">
            If FALSE
        </v-col>
        <v-col cols="4">
            <v-text-field type="text" />
        </v-col>
    </v-row>
    <v-row align-content="space-evenly">
        <v-select  :items="options" item-title="name" item-value="code" item-text="name"
            label="Correct Option:" single-line />
    </v-row>

</template>

<script setup>
const options = [
    { code: 1, name: 'TRUE' },
    { code: 2, name: 'FALSE' },
];
</script>