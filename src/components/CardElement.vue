<script setup lang="ts">
import SubTitleDivider from './SubTitleDivider.vue';

import { defineProps } from 'vue';

// Define props in a single script setup
const props = defineProps({
    header_title: String,
    header_title_value:Number,
});
</script>

<template>
    <v-container flat>
        <SubTitleDivider>
            <SubTitleDivider>
                <div  class="bg-white px-2 text-h1 font-weight-black text-overline text-center">
                    {{ props.header_title }} {{ props.header_title_value? props.header_title_value:'' }}
                </div>
            </SubTitleDivider>
        </SubTitleDivider>
     
        <v-sheet elevation="2" class="text_through_style rounded border-md">
            <v-container  elevated= "4">
                <slot />
            </v-container>
     
        </v-sheet>


    </v-container>
</template>
<style scoped>
.rounded {
    border-radius: 25px !important;

}

.text_through_style {
    margin-top: -16px;
}
</style>