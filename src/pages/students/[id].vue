<template>
  <v-card>
    <v-toolbar color="primary">
      
     <span  v-if="action==='edit'"> <v-card-title> Student ID: {{ id }} {{action}}</v-card-title> </span>
     <span v-else><v-card-title>Student ID: {{ id }} Detail</v-card-title></span> 
     <template v-slot:extension>
        <v-tabs v-model="tab" align-tabs="title">
          <v-tab v-for="item in items" :key="item.title" v-text="item.title" :value="item.title"></v-tab>
        </v-tabs>
      </template>
    </v-toolbar>

    <v-tabs-window v-model="tab">
      <v-tabs-window-item v-for="item in items" :key="item.title" :value="item.title">
        <v-card flat>
          <v-card-title>
            {{ item.title }}
          </v-card-title>
          <v-list dense>
            <!-- Iterate over Proxy object properties using Object.keys or Object.entries -->
            <v-list-item v-model="item.text" v-for="key in Object.keys(item.student)" :key="key">
              <v-list-item-content>
                <v-list-item-title>{{ key }}</v-list-item-title>
                <v-list-item-title>
                  <!-- Display value based on type -->
                  <span v-if="typeof student[key] === 'object'">
                    <v-list-item-subtitle>



                      <!-- if came to this page with edit option -->
                      <span v-if="action==='edit'">

                        <v-text-field v-model="student[key]" :value="JSON.stringify(student[key])"/>
                      </span>



                      <!--if came to this page with detail option-->
                      <span v-else>
                        
                        {{JSON.stringify(student[key]) }} 
                      </span>
                 
                  
                    </v-list-item-subtitle>
                    
                  </span>
                  <span v-else>
                    {{ student[key] }}
                  </span>
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-card>
      </v-tabs-window-item>
    </v-tabs-window>
  </v-card>
</template>

<script>
import { fetchStudentById } from '@/stores/data-services';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';

export default {
  setup() {
    const route = useRoute();
    const id = ref(route.params.id);
    const action = ref(route.query.action);
    const tab = ref(null);
    const student = ref({
      academic_year: '',
      student_name: '',
      date_of_birth: '',
      father_name: '',
      mother_name: '',
      mobile_number: '',
      guardian_name: '',
      student_image_url: '',

    });

    // Reactive state for each tab's student data
    const student_general = ref({
      academic_year: '',
      student_code: '',
      admission_number: '',
      admission_date: '',
      stream_opted: '',
      joining_date: '',
    });

    
    const student_personal = ref({
        student_image_url: '',
        student_name: '',
        gender: '',
        date_of_birth: '',
        blood_group: '',
        mother_tongue: '',
        social_category: '',
        minority_group: '',
        out_of_school_child: '',
        mainstreamed: '',
        impairment_type: '',
        identification_mark: '',
        previous_school: '',
        religion: '',
        remark: ''
      });
  
      const student_contact = ref({
        permanent_address_id: null,
        present_address_id: null,
        pincode: '',
        mobile_number: '',
        alternate_mobile: '',
        email: '',
      });
  
      const student_family = ref({
        mother_name: '',
        father_name: '',
        guardian_name: '',
        nid_number: '',
        birth_certificate: '',
        guardian_id: null,
      });
  
      const student_education = ref({
        class_id: null,
        roll_no: '',
        previous_school: '',
        previous_class: '',
        previous_exam_status: '',
        exam_result: '',
        exam_percentage: '',
        scholarships: '',
        extracurricular: '',
        sub_group: '',
      });
  
      const student_attendance = ref({
        attendance_last_year: '',
      });


        const items = [
            { title: 'General', text: 'general', student: student_general.value },
            { title: 'Personal', text: 'personal', student: student_personal.value },
            { title: 'Contact', text: 'contact', student: student_contact.value },
            { title: 'Family', text: 'family', student: student_family.value }
        ];

    async function loadStudentById() {

      console.log("######## Student Detail Edit ####");

      student.value = await fetchStudentById({ id: id.value });
      console.log("#### STUDENT DETAIL EDIT ####### student.value");
      console.log(student.value);

      // Assign values to respective sections
      student_general.value = {
        academic_year: studentData.academic_year,
        student_code: studentData.student_code,
        admission_number: studentData.admission_number,
        admission_date: studentData.admission_date,
        stream_opted: studentData.stream_opted,
        joining_date: studentData.joining_date,
      };
      student_personal.value = {
          student_image_url: studentData.student_image_url,
          student_name: studentData.student_name,
          gender: studentData.gender,
          date_of_birth: studentData.date_of_birth,
          blood_group: studentData.blood_group,
          mother_tongue: studentData.mother_tongue,
          social_category: studentData.social_category,
          minority_group: studentData.minority_group,
          out_of_school_child: studentData.out_of_school_child,
          mainstreamed: studentData.mainstreamed,
          impairment_type: studentData.impairment_type,
          identification_mark: studentData.identification_mark,
          previous_school: studentData.previous_school,
          religion: studentData.religion,
          remark: studentData.remark,
        };
  
        student_contact.value = {
          permanent_address_id: studentData.permanent_address_id,
          present_address_id: studentData.present_address_id,
          pincode: studentData.pincode,
          mobile_number: studentData.mobile_number,
          alternate_mobile: studentData.alternate_mobile,
          email: studentData.email,
        };
  
        student_family.value = {
          mother_name: studentData.mother_name,
          father_name: studentData.father_name,
          guardian_name: studentData.guardian_name,
          nid_number: studentData.nid_number,
          birth_certificate: studentData.birth_certificate,
          guardian_id: studentData.guardian_id,
        };
  
        student_education.value = {
          class_id: studentData.class_id,
          roll_no: studentData.roll_no,
          previous_school: studentData.previous_school,
          previous_class: studentData.previous_class,
          previous_exam_status: studentData.previous_exam_status,
          exam_result: studentData.exam_result,
          exam_percentage: studentData.exam_percentage,
          scholarships: studentData.scholarships,
          extracurricular: studentData.extracurricular,
          sub_group: studentData.sub_group,
        };
  
        student_attendance.value = {
          attendance_last_year: studentData.attendance_last_year,
        };



    };



    // Example: Fetch student data based on ID
    onMounted(() => {
      console.log('Student ID:', id.value);
      // Fetch data based on ID, e.g., fetchStudentData(id.value);
      loadStudentById();
      console.log("#### ON MOUNTED STUDENT DETAIL EDIT ####### ");
      console.log(student.value);
    });

    return {
      id,
      action,
      tab,
      items,
      student,
      loadStudentById,

    };
  },
};
</script>