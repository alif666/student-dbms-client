<template>
    <v-app>
      <v-container>
        <!-- Staff List -->
        <v-card flat>
          <v-card-title class="d-flex align-center pe-2">
            <v-icon>mdi-account-multiple</v-icon> &nbsp; Staffs / Teachers
          </v-card-title>
  
          <v-card-title class="d-flex align-center pe-2">
            <v-btn class="mb-2" color="primary" dark @click="openInsertDialog">
              +Add
            </v-btn>
            <v-spacer />
            <v-text-field v-model="search" density="compact" label="Search" prepend-inner-icon="mdi-magnify"
              variant="solo-filled" flat hide-details single-line />
          </v-card-title>
  
          <!-- Data Table -->
          <v-data-table :headers="headers" :items="items" :items-per-page="itemsPerPage" :search="search"
            :items-per-page-options="itemsPerPageOptions">
            <template #item.image_url="{ item }">
              <v-card class="my-2" elevation="2">
                <v-img :src="item.image_url" height="64" cover />
              </v-card>
            </template>
  
            <template #item.actions="{ item }">
              <v-icon class="me-2" size="small" @click="openEditDialog(item)">
                mdi-pencil
              </v-icon>
              <v-icon size="small" @click="openDeleteDialog(item)">
                mdi-delete
              </v-icon>
              <v-icon size ="small" @click="popupMsg">
                mdi-camera
              </v-icon>
            </template>
  
            <template #no-data>
              <v-btn color="primary" @click="fetchStaffs"> Reset </v-btn>
            </template>
          </v-data-table>
  
          <!-- Insert Dialog -->
          <v-dialog v-model="insertDialog" max-width="600px">
            <v-card>
              <v-card-title>New Staff Application Form</v-card-title>
              <v-card-text>
                <v-text-field v-model="newStaff.name" label="Name" />
                <v-select
  v-model="newStaff.gender" label="Gender" hint="Enter your sex" :items="genderLookUp"
                  persistent-hint />
                <v-text-field v-model="newStaff.contact_mobile" label="Contact" />
                <v-autocomplete
  v-model="newStaff.subjects_taught" :items="subjectLookups" label="Subjects Taught"
                 hint="Pick the subjects you teach" color="white" hide-no-data />
                <v-select
  v-model="newStaff.classes_taught" :items="classLookups" hint="Pick the classes you teach"
                  label="Classes Taught" />
  
                <!-- Dropzone for Image Upload -->
  
                <v-card-text>
                  <dropzone :accepted-files="['image']" dropzone-class-name="dropzone-box" :multiple="false"  @added-file="onFileAdd"/>
                </v-card-text>
  
              </v-card-text>
  
              <v-card-actions>
                <v-btn color="blue-darken-1" text @click="insertDialog = false">Cancel</v-btn>
                <v-btn color="blue-darken-1" text @click="insertNewStaff">Save</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
  
          <!-- Edit Dialog -->
          <v-dialog v-model="editDialog" max-width="600px">
            <v-card>
              <v-card-title>Edit Staff</v-card-title>
              <v-card-text>
                <v-text-field v-model="editStaff.name" label="Name" />
                <v-select v-model="editStaff.gender" :items="genderLookUp" label="Gender" />
                <v-text-field v-model="editStaff.contact_mobile" label="Contact" />
                <v-autocomplete v-model="editStaff.subjects_taught" :items="subjectLookups" label="Subjects Taught"
                  multiple />
                <v-select v-model="editStaff.classes_taught" :items="classLookups" label="Classes Taught" multiple />
              </v-card-text>
              <v-card-actions>
                <v-btn color="blue-darken-1" text @click="editDialog = false">Cancel</v-btn>
                <v-btn color="blue-darken-1" text @click="updateStaff(editStaff.id)">Update</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
  
          <!-- Delete Dialog -->
          <v-dialog v-model="deleteDialog" max-width="600px">
            <v-card>
              <v-card-title>Confirm Delete</v-card-title>
              <v-card-text>Are you sure you want to delete this staff member?</v-card-text>
              <v-card-actions>
                <v-btn color="blue-darken-1" text @click="deleteDialog = false">Cancel</v-btn>
                <v-btn color="blue-darken-1" text @click="deleteStaff(deleteStaffId)">Delete</v-btn>
                
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-card>
      </v-container>
    </v-app>
  </template>
  
  
  
  
  
  
  
  
  
  <!-- ################################## SCRIPT ################################# -->
  
  
  
  <script setup>
  import { ref, onMounted } from 'vue';
  import { supabase, supabaseStorageUrl } from '@/stores/supabase';
  import dropzone from 'dropzone-vue';
  
  // State management
  const uploadedImage = ref([]);

  const popupMsg = ()=>{
    window.alert("Pop Up Message");
  }
  
  function onFileAdd(file){
    console.log("DROPZONE ADDED");
    console.log(file.file);
    uploadedImage.value = file.file;
    console.log(uploadedImage);
  }
  
  // State management
  const search = ref('');
  const items = ref([]); // Initialize as an array to avoid invalid prop warning
  const itemsPerPage = ref(2);
  const itemsPerPageOptions = [2, 5, 10];
  
  // Dropdown lookups
  const genderLookUp = ['Male', 'Female', 'Others'];
  const subjectLookups = ref([]);
  const classLookups = ref([]);
  
  // New staff data
  const newStaff = ref({
    name: '',
    gender: '',
    contact_mobile: '',
    subjects_taught: [],
    classes_taught: [],
    image_url: '',
  });
  const editStaff = ref({});
  
  // Table headers
  const headers = [
    { title: 'SL', value: 'id', key: 'id' },
    { title: "Profile Photo", value: 'image_url' },
    { title: 'Name', value: 'name' },
    { title: 'Gender', value: 'gender' },
    { title: 'Contact', value: 'contact_mobile' },
    { title: 'Subjects Taught', value: 'subjects_taught' },
    { title: 'Classes Taught', value: 'classes_taught' },
    { title: 'Actions', key: 'actions', sortable: false },
  ];
  
  // Dialog control variables
  const insertDialog = ref(false);
  const editDialog = ref(false);
  const deleteDialog = ref(false);
  const deleteStaffId = ref(null);
  
  // Fetch staff data
  async function fetchStaffs() {
    try {
      const { data, error } = await supabase.from('staff').select('*');
      if (error) throw new Error(error.message);
      items.value = data || [];
    } catch (err) {
      console.error('Error fetching staff data:', err);
    }
  }
  
  // Fetch lookup data
  async function fetchSubjectLookups() {
    try {
      const { data, error } = await supabase.from('subject_lookup').select('*');
      if (error) throw new Error(error.message);
      subjectLookups.value = data.map(item => item.subject_name) || [];
    } catch (err) {
      console.error('Error fetching subjects:', err);
    }
  }
  
  async function fetchClassLookups() {
    try {
      const { data, error } = await supabase.from('class_lookup').select('*');
      if (error) throw new Error(error.message);
      classLookups.value = data.map(item => item.class_name) || [];
    } catch (err) {
      console.error('Error fetching classes:', err);
    }
  }
  
  // Insert new staff with image upload
  async function insertNewStaff() {
    try {
      // let imageUrl = ''; 
      if (uploadedImage.value) {
        const { data, error } = await supabase.storage
          .from('staff-images')
          .upload(`${uploadedImage.value.name}`, uploadedImage.value);
        if (error) throw new Error(error.message);
        // imageUrl = data.path;
      }
      const { error: insertError } = await supabase.from('staff').insert([{ ...newStaff.value, image_url: (supabaseStorageUrl+`/staff-images/${uploadedImage.value.name}`) }]);
      if (insertError) throw new Error(insertError.message);
      insertDialog.value = false;
      fetchStaffs();
    } catch (err) {
      console.error('Error inserting staff:', err);
    }
  }
  
  
  // Update existing staff
  async function updateStaff(staffId) {
    try {
      const { error } = await supabase.from('staff').update(editStaff.value).eq('id', staffId);
      if (error) throw new Error(error.message);
      editDialog.value = false;
      fetchStaffs();
    } catch (err) {
      console.error('Error updating staff:', err);
    }
  }
  
  // Delete staff
  async function deleteStaff(staffId) {
    try {
      const { error } = await supabase.from('staff').delete().eq('id', staffId);
      if (error) throw new Error(error.message);
      deleteDialog.value = false;
      fetchStaffs();
    } catch (err) {
      console.error('Error deleting staff:', err);
    }
  }
  
  // Dialog open handlers
  function openInsertDialog() {
    insertDialog.value = true;
  }
  
  function openEditDialog(staff) {
    editStaff.value = { ...staff };
    editDialog.value = true;
  }
  
  function openDeleteDialog(staff) {
    deleteStaffId.value = staff.id;
    deleteDialog.value = true;
  }
  
  // On mounted hook
  onMounted(() => {
    fetchStaffs();
    fetchSubjectLookups();
    fetchClassLookups();
    console.log("ON MOUNTED");
    console.log(items);
  });
  </script>
  
  <style scoped>
  .dropzone-box{
    display: flex;
    background-color: whitesmoke;
    justify-content: center;
    align-items: center;
    border-radius: .25rem;
    border:dotted;
    min-height: 10rem;
  }
  .dropzone-message{
    background-color: aqua;
  }
  .fileinput-button {
    cursor: pointer;
    display: inline-block;
  }
  
  .dz-message {
    text-align: center;
    margin: 10px 0;
  }
  
  .previewSection {
    height: 100px;
    width: 100px;
  
  
  }
  
  
  </style>
  