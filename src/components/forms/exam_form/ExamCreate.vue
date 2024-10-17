<template>

    <v-select v-model="examStore.exam_question_model.number_of_sections"
        :items="Array.from({ length: 19 }, (v, i) => i + 1)" label="Number of Sections"
        :rules="numberOfSectionsRules" />
    <v-card flat>


            <v-row class="d-flex flex-column flex-sm-row">

            <v-spacer></v-spacer>

            <v-btn :disabled="examStore.exam_question_model.sections.length > 0 ? true : false" prepend-icon="mdi-check-bold"
                class="primary" variant="text"
                @click="examStore.createNewSection(examStore.exam_question_model.number_of_sections)">
                Create Sections
            </v-btn>

            <v-spacer></v-spacer>
            <v-btn :disabled="examStore.exam_question_model.sections.length > 0 ? false : true" prepend-icon="mdi-restart"
                class="primary" variant="text" @click="examStore.resetSection()">
                Reset
            </v-btn>
            <v-spacer class="my-7"></v-spacer>
            </v-row>
        


    </v-card>
    <!-- Create a button to generate number of sections -->

    <template v-if="examStore.exam_question_model.sections.length > 0" flat>
        <v-sheet>
            <v-row>
                <v-col cols="12">
                    <v-tabs v-model="tabs" direction="horizontal" next-icon="mdi-arrow-right-bold-box-outline"
                        prev-icon="mdi-arrow-left-bold-box-outline" show-arrows>

                        <v-tab prepend-icon="mdi-check-bold" :value="n"
                            v-for="n in examStore.exam_question_model.number_of_sections" :key="n"
                            :text="`Section ${n}`">

                        </v-tab>
                    </v-tabs>
                </v-col>
            </v-row>
            <v-row>
                <!-- Tab Window Items -->
                <v-col cols="12">
                    <v-tabs-window v-model="tabs">
                        <template v-for="n in examStore.exam_question_model.number_of_sections" :key="n">
                            <v-tabs-window-item :value="n">
                                <CardElement header_title="Section " :header_title_value="n">
                                   
                                    <CardElement header_title="Marks Distribution of Section " :header_title_value="n">
                                        <v-row class="d-flex flex-column">
                                            <v-col cols="12">
                                                <v-text-field
                                                    v-model="examStore.exam_question_model.sections[n - 1].section_title"
                                                    @input="(e) => examStore.addFieldToSections('section_title', e.target.value, n)"
                                                    label="Section Title:" />
                                            </v-col>

                                        </v-row>
                                        
                                        <v-row class="d-flex flex-column flex-sm-row">
                                            <v-col cols="12" sm="4">
                                                <v-select
                                                    :readonly="examStore.exam_question_model.sections[n - 1].questions.length > 0 ? true : false"
                                                    v-model="examStore.exam_question_model.sections[n - 1].question_category"
                                                    @change="(val) => examStore.addFieldToSections('question_category', val, n)"
                                                    :items="examStore.question_category_lookup" item-title="name"
                                                    item-value="name" label="Type of Questions" single-line />
                                            </v-col>

                                            <v-col cols="12" sm="3">
                                                <v-select
                                                    :readonly="examStore.exam_question_model.sections[n - 1].questions.length > 0 ? true : false"
                                                    v-model="examStore.exam_question_model.sections[n - 1].section_number_of_questions"
                                                    :items="Array.from({ length: 19 }, (v, i) => i + 1)"
                                                    :rules="numberOfQuestionsRules" label="Questions" />
                                            </v-col>

                                            <span class="my-9">X</span>

                                            <v-col cols="12" sm="3">
                                                <v-text-field
                                                    :readonly="examStore.exam_question_model.sections[n - 1].questions.length > 0 ? true : false"
                                                    v-model.number="examStore.exam_question_model.sections[n - 1].section_mark_each"
                                                    @input="(e) => {
                                                        const value = e.target.value === '' ? 0 : Number(e.target.value);
                                                        examStore.addFieldToSections('section_mark_each', value, n);
                                                    }" type="number" label="Mark" min="0" step="1" />
                                            </v-col>

                                            <span class="my-9">
                                                = {{
                                                    examStore.exam_question_model.sections[n - 1].section_number_of_questions
                                                * examStore.exam_question_model.sections[n-1].section_mark_each }}
                                            </span>
                                        </v-row>

                                        <v-row class="d-flex flex-column flex-sm-row">

                                            
                                            <v-spacer></v-spacer>
                                            <v-btn class="secondary"
                                                :disabled="examStore.exam_question_model.sections[n - 1].questions.length > 0 ? true : false"
                                                prepend-icon="mdi-check-bold" variant="outlined"
                                                @click="examStore.createNewQuestion(n - 1, examStore.exam_question_model.sections[n - 1].section_number_of_questions, examStore.exam_question_model.sections[n - 1].question_category)">
                                                Create Questions
                                            </v-btn>

                                            <v-spacer></v-spacer>
                                            <v-btn
                                                :disabled="examStore.exam_question_model.sections[n - 1].questions.length > 0 ? false : true"
                                                prepend-icon="mdi-restart" class="primary" variant="outlined"
                                                @click="examStore.resetQuestion(n - 1)">
                                                Reset
                                            </v-btn>
                                            <v-spacer class="my-7"></v-spacer>
                                        

                                        </v-row>

                                    </CardElement>
                                    <v-container>
                                        <template
                                            v-if="examStore.exam_question_model.sections[n - 1].section_number_of_questions > 0 && examStore.exam_question_model.sections[n - 1].question_category != null"
                                            flat>
                                            <v-row
                                                v-for="index in examStore.exam_question_model.sections[n - 1].questions.length || 0"
                                                :key="index">
                                                <ExamQuestion :iProps="index" :nProps="n"
                                                    :question_category="examStore.exam_question_model.sections[n - 1]?.question_category"
                                                    @handleChange="(value) => examStore.updateQuestionInSection(n, index, 'question_title', value)" />
                                            </v-row>
                                        </template>
                                    </v-container>

                                  
                                </CardElement>
                            </v-tabs-window-item>
                        </template>


                    </v-tabs-window>
                </v-col>
            </v-row>
        </v-sheet>
        <v-chip rounded="xl" size="xl"
            :color="examStore.exam_question_model.remaining_total_marks >= 0 ? 'secondary' : 'pink'" variant="elevated"
            :prepend-icon="examStore.exam_question_model.remaining_total_marks === 0 ? 'mdi-edit-bold' : 'mdi-calculator'"
            class="position-fixed bottom-0 right-0 ma-5 pa-3">

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

    </template>
</template>

<script setup>
import { ref, computed } from 'vue';
import ExamQuestion from './ExamQuestion.vue';
import CardElement from '@/components/CardElement.vue';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
import { watch } from 'vue';
const tabs = ref(0);
const examStore = useExamQuestionModelStore();



const numberOfSectionsRules = [
    v => (!!v && v >= 1 && v < 20) || 'Sections must be between 1 and 19',
];

const numberOfQuestionsRules = [
    v => (!!v && v >= 1 && v < 20) || 'Questions must be between 1 and 19',
];

// Watch for changes in examStore.exam_question_model.section[n-1].section_number_of_questions and examStore.exam_question_model.section[n-1].question_category data and update the store
// watch(
//   () => toRaw(examStore.exam_question_model.sections[props.nProps-1].section_number_of_question || examStore.exam_question_model.sections[props.nProps-1].question_category), // Get a non-reactive version of the question object
//   () => {
//     console.log("####################  Watch for changes in examStore.exam_question_model.section[n-1].section_number_of_questions and examStore.exam_question_model.section[n-1].question_category data and update the store");
//     examStore.createNewQuestion(props.nProps,examStore.exam_question_model.sections[props.nProps-1].section_number_of_question,examStore.exam_question_model.sections[props.nProps-1].question_category);
//     },
//   { deep: true }
// );

</script>
