import { ref } from 'vue';

const examData = {
  exam_school_name: ref('ABC School'),
  exam_school_logo: ref(null),
  exam_school_medium: ref('English'),
  exam_school_shift: ref('Morning'),
  exam_created_by: ref('Teacher A'),
  exam_question_requested_by: ref('Head of Department'),

  exam_approver: ref('Principal'),
  exam_appproved_by: ref('Principal A'),

  exam_subject: ref('Mathematics'),
  exam_name: ref('Class Test | 2024 | Class 1'),
  total_marks: ref(100),
  actual_total_marks: ref(80),
  remaining_total_marks: ref(20),
  time_duration_hours: ref('1'),
  time_duration_minutes: ref('30'),

  exam_date: ref(new Date('2024-10-17')),
  exam_for_class: ref(1),
  class_section: ref(2),
  exam_category: ref('Class Test'),
  exam_year: ref('2024'),
  additional_remark: ref('Handwriting will earn additional marks'),

  number_of_sections: ref(2),
  sections: [
    {
      section_title: 'Section 1',
      question_category: 'MCQ',
      section_number_of_questions: 2,
      section_mark_each: 5,
      questions: [
        { question_title: 'Question 1', question_options: ['A', 'B', 'C', 'D'] },
        { question_title: 'Question 2', question_options: ['A', 'B', 'C', 'D'] }
      ]
    },
    {
      section_title: 'Section 2',
      question_category: 'TRUE_FALSE',
      section_number_of_questions: 2,
      section_mark_each: 5,
      questions: [
        { question_title: 'Question 1', question_options: ['True', 'False'] },
        { question_title: 'Question 2', question_options: ['True', 'False'] }
      ]
    }
  ]
};

export default examData;
