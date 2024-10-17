import { defineStore } from 'pinia';
import { format } from 'date-fns';
import { ref } from 'vue';

export const useExamQuestionModelStore = defineStore('examQuestionModelStore', {
  state: () => ({
        question_category_lookup:ref([
          { code: 1, name: 'MCQ' },
          { code: 2, name: 'TRUE_FALSE' },
          { code: 3, name: 'BROAD' }
      ]),
        question_type_lookup:ref([
          { code: 1, name: 'Text' },
          { code: 2, name: 'Image' },
          { code: 3, name: 'TextImage'},
      ]),
    exam_question_model: {
      // Exam Setup & Requests

      // metadata
      exam_school_name: ref(''),
      exam_school_logo: ref(null),
      exam_school_medium: ref(null),
      exam_school_shift: ref(null),
      exam_created_by: ref(null),
      exam_question_requested_by: ref(null),



      // Teacher's Information
      exam_approver: ref(null),
      exam_appproved_by: ref(null),




      exam_subject: ref(null),
      exam_name: ref(''),
      total_marks: ref(0),
      actual_total_marks: ref(0), // Add this field for actual total marks
      remaining_total_marks: ref(0),
      time_duration_hours: ref(null),
      time_duration_minutes: ref(null),

      exam_date: ref(null),
      exam_for_class: ref(null),
      class_section: ref(null),
      exam_category: ref(null),
      exam_year: ref(''),
      additional_remark: ref(''),

      // Exam Setup Section Ends

      number_of_sections: ref(0),
      sections: [],
    },
  }),

  actions: {
    isComplete() {
      console.log("################## isComplete ###########");

      if (this.exam_question_model.total_marks === 0) {
        console.log("total_marks is 0");
        return false;
      } else if (this.exam_question_model.time_duration_hours === null && this.exam_question_model.time_duration_minutes === null) {
        console.log("time_duration is null");
        return false;
      } else if (this.exam_question_model.exam_subject === null) {
        console.log("exam_subject is null");
        return false;
      } else if (this.exam_question_model.exam_date === '') {
        console.log("exam_date is not updated");
        return false;
      } else if (this.exam_question_model.exam_for_class === null) {
        console.log("exam_for_class is null");
        return false;
      } else if (this.exam_question_model.class_section === null) {
        console.log("class_section is null");
        return false;
      } else if (this.exam_question_model.exam_category === null) {
        console.log("exam_category is null");
        return false;
      } else if (this.exam_question_model.exam_year === '') {
        console.log("exam_year is null");
        return false;
      }



      // Additional Remarks validation not required
      // else if (this.exam_question_model.additional_remark === '') {
      //   console.log("additional_remark is null");
      //   return false;
      // } 
      else {
        console.log("All conditions of exam_question_model met");
        return true;
      }
    },

    addFieldToSections(fieldKey, fieldValue, sectionIndex) {
      // Ensure the section exists
      if (!this.exam_question_model.sections[sectionIndex - 1]) {
        this.exam_question_model.sections[sectionIndex - 1] = {
          section_title: '',
          question_category: null,
          section_number_of_questions: 0,
          section_mark_each: 0,
          questions: []
        };
      }

      // Update section fields
      this.exam_question_model.sections[sectionIndex - 1][fieldKey] = fieldValue;

      // If updating the number of questions, ensure the questions array is updated
      if (fieldKey === 'section_number_of_questions') {
        const numberOfQuestions = parseInt(fieldValue, 10);
        const section = this.exam_question_model.sections[sectionIndex - 1];

        // Ensure questions array has the right number of questions
        while (section.questions.length < numberOfQuestions) {
          section.questions.push({ question_title: '', question_options: [] });
        }

        // Trim questions array if it has more than required
        if (section.questions.length > numberOfQuestions) {
          section.questions = section.questions.slice(0, numberOfQuestions);
        }
      }

      this.updateRemainingTotalMarks(); // Call this method whenever a section is modified
      console.log(this.exam_question_model);
    },

    updateQuestionInSection(sectionIndex, questionIndex, key, value) {
      const section = this.exam_question_model.sections[sectionIndex - 1];
      if (section && section.questions[questionIndex - 1]) {
        section.questions[questionIndex - 1][key] = value;
      }
    },

    // Create new sections if n > sections.length
    createNewSection(n) {
      const currentSectionsLength = this.exam_question_model.sections.length;

      // If n is greater than the current number of sections, create new sections
      if(this.exam_question_model.sections.length===0){
        for (let i = 0; i < n; i++) {
          this.exam_question_model.sections.push({
            section_title: '',
            question_category: null, // Set to null as per your request
            section_number_of_questions: 0,
            section_mark_each: 0,
            questions: []
          });
        }
      }
        console.log(this.exam_question_model, "#### CREATE NEW SECTION ########");
      

      this.updateRemainingTotalMarks();
      console.log(this.exam_question_model);
    },

    // Create new sections if n > sections.length
    createNewQuestion(n, numberOfQuestions,question_category) {
      // if (this.exam_question_model.sections[n].questions) {
        const currentSectionsLength = this.exam_question_model.sections.length;
        console.log("########## CREATE NEW QUESTION ###########");
        console.log("Section Index  " + n + " numberOfQuestions  " + numberOfQuestions);
        // If n is greater than the current number of sections, create new sections
        console.log("Length of questions are ",this.exam_question_model.sections[n].questions.length);
        if(this.exam_question_model.sections[n].questions.length===0) {
          for (let i = 0; i < numberOfQuestions; i++) {
            console.log("Pushing to ",this.exam_question_model.sections[n]);
            this.exam_question_model.sections[n].questions.push({
              question_title: null,
              question_category: question_category, // Set to null as per your request
              question_options: [],
              question_correct_answer: null,
            });
            console.log(this.exam_question_model.sections[n]);
          }
          console.log(this.exam_question_model, "#### CREATE NEW QUESTION ########");
        // }

        this.updateRemainingTotalMarks();
        console.log(this.exam_question_model, "#### UPDATED REMAINING TOTAL MARKS ####");

      }

    },
    // Method to update remaining total marks and actual total marks
    updateRemainingTotalMarks() {
      const totalSectionMarks = this.exam_question_model.sections.reduce(
        (total, section) => total + (section.section_number_of_questions * section.section_mark_each),
        0
      );

      this.exam_question_model.actual_total_marks = totalSectionMarks; // Update actual total marks
      this.exam_question_model.remaining_total_marks = this.exam_question_model.total_marks - totalSectionMarks;
      console.log(this.exam_question_model);
    }
  }
});
