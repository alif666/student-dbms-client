<script setup>

const props = defineProps({
    itemProps: String,
});
console.log("item props is");
console.log(props.itemProps);
</script>

<template>
    <v-container class= "mt-n16 mb-6">
        <v-sheet rounded class="d-flex flex-column align-center mt-n16 mb-16">

            <v-img v-if="itemProps==='1'" src="@/assets/setup_image.png" alt="User Icon" rounded class="stepper_icon icon-image"
                            width="36" height="36" align="center" contain>
                        
                            </v-img>
                            <v-img v-else-if="itemProps==='2'" src="@/assets/create_question.png" alt="User Icon" rounded class="stepper_icon icon-image"
                            width="36" height="36" align="center" contain />
                            <v-img v-else-if="itemProps==='3'" src="@/assets/mark_distribution.png" alt="User Icon" rounded class="stepper_icon icon-image"
                            width="36" height="36" align="center" contain />
                            <v-img v-else-if="itemProps==='4'" src="@/assets/preview_exam.png" alt="User Icon" rounded class="stepper_icon icon-image"
                            width="36" height="36" align="center" contain />
                            <v-spacer/>
                            
        </v-sheet>
    </v-container>


</template>

<style scoped>

</style>