import { defineStore } from 'pinia';
import { format } from 'date-fns';
import { ref } from 'vue';

export const useExamQuestionModelStore = defineStore('examQuestionModelStore', {
  state: () => ({
    exam_question_model: {
      total_marks: ref(0),
      actual_total_marks: ref(0), // Add this field for actual total marks
      remaining_total_marks: ref(0),
      time_duration_hours: ref(1),
      time_duration_minutes: ref(0),
      exam_subject: ref(null),
      exam_date: ref(format(new Date('2024-01-01'), 'yyyy-MM-dd')),
      exam_for_class: ref(null),
      class_section: ref(null),
      exam_category: ref(null),
      exam_year: ref(''),
      additional_remark: ref(''),
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
      } else if (this.exam_question_model.time_duration === null) {
        console.log("time_duration is null");
        return false;
      } else if (this.exam_question_model.exam_subject === null) {
        console.log("exam_subject is null");
        return false;
      } else if (this.exam_question_model.exam_date === format(new Date('2024-01-01'), 'yyyy-MM-dd')) {
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
      } else if (this.exam_question_model.additional_remark === '') {
        console.log("additional_remark is null");
        return false;
      } else {
        console.log("All conditions of exam_question_model met");
        return true;
      }
    },

    addFieldToSections(fieldKey, fieldValue, sectionIndex) {
      // Ensure the section exists
      if (!this.exam_question_model.sections[sectionIndex - 1]) {
        this.exam_question_model.sections[sectionIndex - 1] = {
          section_title: '',
          question_category: '',
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
      if (n > currentSectionsLength) {
        for (let i = currentSectionsLength; i < n; i++) {
          this.exam_question_model.sections.push({
            section_title: '',
            question_category: null, // Set to null as per your request
            section_number_of_questions: 1,
            section_mark_each: 0,
            questions: []
          });
        }
        console.log(this.exam_question_model, "#### CREATE NEW SECTION ########");
      }

      this.updateRemainingTotalMarks();
      console.log(this.exam_question_model);
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
