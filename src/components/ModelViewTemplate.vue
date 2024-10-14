<template>
    <div class="text-left pa-4">
        <v-card>
            <v-list dense>
                <v-list-item v-for="(value, key, index) in model_object" :key="key">

                    <v-sheet class="d-flex justify-space-evenly border-thin">
                        <v-sheet v-if="index !== NaN" class="ma-2 pa-2">
                            <v-avatar variant="elevated">
                                {{ index + 1 }}
                            </v-avatar>
                        </v-sheet>
                        <v-sheet class="ma-2 pa-2">
                            <v-list-item>
                                <v-list-item-subtitle v-if="key !== examStore.exam_question_model.sections"
                                    class="font-weight-black text-start align-self-start text-overline">
                                    {{ key }}
                                </v-list-item-subtitle>

                                {{ value }}
                            </v-list-item>
                        </v-sheet>

                        <v-sheet class="ma-2 pa-2 me-auto text-start" />



                    </v-sheet>

                </v-list-item>
                

            </v-list>
            <v-list>
                <v-list-subheader>
                    LOOKUPS
                </v-list-subheader>
                <v-list-item>
                    <v-sheet>
                        <LookUps/>
                    </v-sheet>
                </v-list-item>
            
            </v-list>
        </v-card>
    </div>
</template>

<script setup>
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
const props = defineProps({
    title_text_icon: String,
    title_label: String,
    model_object: Object,
});
const examStore = useExamQuestionModelStore();


</script>