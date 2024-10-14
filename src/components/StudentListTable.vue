<template>
    <v-container>
        <v-card>
            <v-card-title>
                <v-icon>mdi-account-multiple</v-icon> &nbsp; Students
            </v-card-title>
            <v-card-title>

                <v-btn class="mb-2" color="primary" dark @click="navigateTo(`/students/form/${id}`)">
                    +Student Application Form
                </v-btn>
                <v-spacer />
                <v-text-field v-model="search" density="compact" label="Search" prepend-inner-icon="mdi-magnify"
                    variant="solo-filled" flat hide-details single-line />
            </v-card-title>
            <!-- Data Table -->
            <v-data-table :headers="headers" :items="items" :items-per-page="itemsPerPage" :search="search"
                :items-per-page-options="itemsPerPageOptions">
                <template #item.student_image_url="{ item }">
                    <v-card class="my-2" elevation="2">
                        <v-img :src="item.student_image_url" height="64" cover />
                    </v-card>
                </template>

                <template #item.actions="{ item }">
                    <v-icon class="me-2" size="small" @click="navigateTo(`/students/${item.id}`)">
                        mdi-camera
                    </v-icon>
                    <v-icon class="me-2" size="small"  @click="navigateTo(`/students/form/${item.id}`)">
                        mdi-pencil
                    </v-icon>
                    <v-icon size="small" @click="openDeleteDialog(item)">
                        mdi-delete
                    </v-icon>
                </template>

                <template #no-data>
                    <v-btn color="primary" @click="loadStudents"> Reset </v-btn>
                </template>
            </v-data-table>
            <!-- Delete Dialog -->
            <v-dialog v-model="deleteDialog" max-width="600px">
                <v-card>
                    <v-card-title>Confirm Delete ID: {{ deleteStudentId }}</v-card-title>
                    <v-card-text>Are you sure you want to delete this Student Data?</v-card-text>
                    <v-card-actions>
                        <v-btn color="blue-darken-1" text @click="deleteDialog = false">Cancel</v-btn>
                        <v-btn color="blue-darken-1" text @click="requestDelete">Delete</v-btn>
                    
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </v-card>
    </v-container>
</template>

<script>
import { deleteStudent, fetchStudents } from '@/stores/data-services';
import { useRouter } from 'vue-router';

export default {
    setup() {
        const id = ref('add');
        const router=useRouter();
        const search = ref('');
        const items = ref([]);
        const itemsPerPage = ref(2);
        const itemsPerPageOptions = [2, 3, 5, 10];
        const headers = [
            { title: 'Id', value: 'id', key: 'id' },
            { title: 'Photo', value: 'student_image_url' },
            { title: 'Name', value: 'student_name' },
            { title: 'Date of Birth', value: 'date_of_birth', key: 'date_of_birth' },
            { title: 'Academic Year', value: 'academic_year', key: 'academic_year' },
            { title: 'Contact', value: 'mobile_numer' },
            { title: 'Actions', key: 'actions', sortable: false },
        ];





        // Dialog control variables
        const deleteDialog = ref(false);
        const deleteStudentId = ref(null);
        function openDeleteDialog(student) {
            deleteStudentId.value = student.id;
            deleteDialog.value = true;
        }
        const requestDelete = async()=>{
            const {data} = deleteStudent({id:deleteStudentId.value});
            deleteDialog.value=false;
            deleteStudentId.value=null;
            
            router.push('/')
        }

        const loadStudents = async () => {
            console.log("STUDENT LIST TABLE ### # STUDENT FETCHED FROM DB");
            try {
                const { data } = await fetchStudents();
                console.log(data);
                items.value = data || [];
            } catch (err) {
                console.log("Error fetching student's data");
            }

        };

    const navigateTo=(path)=>{
    router.push(path);
  }

  
        onMounted(() => {
            fetchStudents();
            loadStudents();
            console.log(items);
        });

        return {
            id,
            search,
            items,
            itemsPerPage,
            itemsPerPageOptions,
            headers,
            loadStudents,
            deleteDialog,
            deleteStudentId,
            openDeleteDialog,
            requestDelete,
            navigateTo,
        };
    }

}
</script>