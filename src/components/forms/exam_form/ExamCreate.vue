<template>
    <CardElement header_title="Questions">
        <v-select v-model="examStore.exam_question_model.number_of_sections"
            @update:model-value="examStore.createNewSection(examStore.exam_question_model.number_of_sections)"
            :items="Array.from({ length: 19 }, (v, i) => i + 1)" label="Number of Sections"
            :rules="numberOfSectionsRules" />
    </CardElement>

    <v-stepper v-if="examStore.exam_question_model.number_of_sections > 0" flat>
        <v-stepper-header editable>
            <template v-for="n in examStore.exam_question_model.number_of_sections" :key="n">
                <v-stepper-item align="center" editable :value="n" flat />
                <v-divider v-if="n !== examStore.exam_question_model.number_of_sections"></v-divider>
            </template>
        </v-stepper-header>

        <v-stepper-window>
            <v-stepper-window-item v-for="n in examStore.exam_question_model.number_of_sections" :key="`${n}-content`"
                :value="n">
                <CardElement header_title="Question No." :header_title_value="n">
                    <v-container>
                        <v-row>
                            <v-text-field v-model="examStore.exam_question_model.sections[n - 1].section_title"
                                @input="(e) => examStore.addFieldToSections('section_title', e.target.value, n)"
                                label="Section Title:" />
                        </v-row>
                        <v-row class="d-flex flex-column flex-sm-row">
                            <v-col cols="12" sm="4">
                                <v-select v-model="examStore.exam_question_model.sections[n - 1].question_category"
                                    @change="(val) => examStore.addFieldToSections('question_category', val, n)"
                                    :items="questionCategoryLookups" item-title="name" item-value="name"
                                    label="Type of Questions" single-line />
                            </v-col>

                            <v-col cols="12" sm="3">
                                <v-select
                                    v-model="examStore.exam_question_model.sections[n - 1].section_number_of_questions"
                                    @change="(val) => examStore.addFieldToSections('section_number_of_questions', val, n)"
                                    @update:model-value="examStore.updateRemainingTotalMarks"
                                    :items="Array.from({ length: 19 }, (v, i) => i + 1)" :rules="numberOfQuestionsRules"
                                    label="Questions" />
                            </v-col>

                            <span class="my-9">X</span>

                            <v-col cols="12" sm="3">
                                <v-text-field
                                    v-model.number="examStore.exam_question_model.sections[n - 1].section_mark_each"
                                    @input="(e) => {
                                        const value = e.target.value === '' ? 0 : Number(e.target.value);
                                        examStore.addFieldToSections('section_mark_each', value, n);
                                    }" type="number" label="Mark" min="0" step="1" />
                            </v-col>

                            <span class="my-9">
                                = {{ examStore.exam_question_model.sections[n - 1].section_number_of_questions *
                                    examStore.exam_question_model.sections[n - 1].section_mark_each }}
                            </span>
                        </v-row>

                        <v-chip rounded="xl" size="xl"
                            :color="examStore.exam_question_model.remaining_total_marks >= 0 ? 'secondary' : 'pink'"
                            variant="elevated"
                            :prepend-icon="examStore.exam_question_model.remaining_total_marks === 0 ? 'mdi-check-bold' : 'mdi-calculator'"
                            class="position-fixed bottom-0 rounded-lg ma-5 pa-3">

                            <span class="font-weight-black mx-1">
                                {{ examStore.exam_question_model.total_marks }}
                            </span>
                            -
                            <span class="font-weight-black mx-1">
                                {{ examStore.exam_question_model.actual_total_marks }}
                            </span>
                            =
                            <span class="font-weight-black mx-1">
                                {{ examStore.exam_question_model.remaining_total_marks }}
                            </span>
                        </v-chip>


                        <v-row align-content="center">
                            <v-col cols="12">
                                <v-row
                                    v-for="i in examStore.exam_question_model.sections[n - 1]?.section_number_of_questions || 0"
                                    :key="i">
                                    <CardElement class="my-4" header_title="Q - " :header_title_value="i">
                                        <ExamQuestion :i-props="i" :n-props="n"
                                            :questionModel="examStore.exam_question_model.sections[n - 1]?.questions[i - 1]"
                                            :question_category="examStore.exam_question_model.sections[n - 1]?.question_category"
                                            @handleChange="(value) => examStore.updateQuestionInSection(n, i, 'question_title', value)" />
                                    </CardElement>
                                </v-row>
                            </v-col>
                        </v-row>
                    </v-container>
                </CardElement>
            </v-stepper-window-item>
        </v-stepper-window>
    </v-stepper>
</template>

<script setup>
import { ref, computed } from 'vue';
import ExamQuestion from './ExamQuestion.vue';
import CardElement from '@/components/CardElement.vue';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';

const examStore = useExamQuestionModelStore();

const questionCategoryLookups = ref([
    { code: 1, name: 'MCQ' },
    { code: 2, name: 'TRUE_FALSE' },
    { code: 3, name: 'BROAD' }
]);

const numberOfSectionsRules = [
    v => (!!v && v >= 1 && v < 20) || 'Sections must be between 1 and 19',
];

const numberOfQuestionsRules = [
    v => (!!v && v >= 1 && v < 20) || 'Questions must be between 1 and 19',
];
</script>

<style scoped>
.stepper_class {
    color: aliceblue;
}

.stepper_selected_class {
    color: darkblue;
}

.red-text {
    color: red;
}
</style>
