<template>
    <v-app>
        <v-container>
            <!-- User List -->
            <v-card flat>
                <v-card-title class="d-flex align-center pe-2">
                    <v-icon>mdi-account-multiple</v-icon> &nbsp; User Information
                </v-card-title>

                <v-card-title class="d-flex align-center pe-2">
                    <v-btn class="mb-2" color="primary" dark @click="openInsertDialog">
                        +Admin/ Teacher/ Student/ Guardian
                    </v-btn>
                    <v-spacer />
                    <v-text-field v-model="search" density="compact" label="Search" prepend-inner-icon="mdi-magnify"
                        variant="solo-filled" flat hide-details single-line />
                </v-card-title>

                <!-- Data Table -->
                <v-data-table :headers="headers" :items="items" :items-per-page="itemsPerPage" :search="search"
                    :items-per-page-options="itemsPerPageOptions">
                    <template #item.actions="{ item }">
                        <v-icon class="me-2" size="small" @click="openEditDialog(item)">
                            mdi-pencil
                        </v-icon>
                        <v-icon size="small" @click="openDeleteDialog(item)">
                            mdi-delete
                        </v-icon>
                    </template>

                    <template #no-data>
                        <v-btn color="primary" @click="fetchRolesLookups"> Reset </v-btn>
                    </template>
                </v-data-table>

                <!-- Insert Dialog -->
                <v-dialog v-model="insertDialog" max-width="600px">
                    <v-card>
                        <v-card-title>New User Application Form</v-card-title>
                        <v-card-subtitle>
                            <v-select v-model="newUser.profile_role_name" label="Select Role" :items="rolesLookups" />
                        </v-card-subtitle>
                        <v-card-text>
                            <v-text-field v-model="newUser.email" label="Email" />
                            <v-text-field v-model="newUser.password" label="Password" type="password" />
                            <v-text-field label="Confirm Password" type="password" />
                            <v-text-field v-model="newUser.first_name" label="First Name" />
                            <v-text-field v-model="newUser.last_name" label="Last Name" />
                            <v-text-field v-model="newUser.contact_no" label="Contact" />
                        </v-card-text>
                        <v-card-actions>
                            <v-btn color="blue-darken-1" text @click="insertDialog = false">Cancel</v-btn>
                            <v-btn color="blue-darken-1" text @click="submitNewUser">Save</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>

                <!-- Edit Dialog -->
                <v-dialog v-model="editDialog" max-width="600px">
                    <v-card>
                        <v-card-title>Edit User</v-card-title>
                        <v-card-text>
                            <v-text-field v-model="editUser.email" label="Email" />
                            <v-text-field v-model="editUser.password" label="Password" type="password" />
                            <v-text-field v-model="editUser.first_name" label="First Name" />
                            <v-text-field v-model="editUser.last_name" label="Last Name" />
                            <v-text-field v-model="editUser.contact_no" label="Contact" />
                        </v-card-text>
                        <v-card-actions>
                            <v-btn color="blue-darken-1" text @click="editDialog = false">Cancel</v-btn>
                            <v-btn color="blue-darken-1" text @click="requestUpdate(editUser.id)">Update</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>

                <!-- Delete Dialog -->
                <v-dialog v-model="deleteDialog" max-width="600px">
                    <v-card>
                        <v-card-title>Confirm Delete</v-card-title>
                        <v-card-text>Are you sure you want to delete this user?</v-card-text>
                        <v-card-actions>
                            <v-btn color="blue-darken-1" text @click="deleteDialog = false">Cancel</v-btn>
                            <v-btn color="blue-darken-1" text @click="requestDelete(deleteUserId)">Delete</v-btn>
                        </v-card-actions>
                    </v-card>
                </v-dialog>
            </v-card>
        </v-container>
    </v-app>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { fetchRolesLookups, insertNewUser, deleteUser, updateUser, fetchUsers } from '@/stores/data-services';

const rolesLookups = ref([]);
const items = ref([]);
const headers = ref([
    { text: 'Name', value: 'name' },
    { text: 'Role', value: 'profile_role_name' },
    { text: 'Email', value: 'email' },
    { text: 'Contact', value: 'contact_no' },
    { text: 'Actions', value: 'actions', sortable: false }
]);
const search = ref('');
const itemsPerPage = ref(10);
const itemsPerPageOptions = [5, 10, 25, 50];

const insertDialog = ref(false);
const editDialog = ref(false);
const deleteDialog = ref(false);
const deleteUserId = ref(null);

const newUser = ref({
    profile_role_name: '',
    email: '',
    password: '',
    first_name: '',
    last_name: '',
    contact_no: ''
});

const editUser = ref({
    profile_role_name: '',
    email: '',
    password: '',
    first_name: '',
    last_name: '',
    contact_no: ''
});


function openInsertDialog() {
    insertDialog.value = true;
}

function openEditDialog(item) {
    editUser.value = { ...item };
    editDialog.value = true;
}

async function loadUsers() {
    try {
        const { data } = await fetchUsers();
        if (data.length > 0) {
            items.value = data;
        } else {
            return "no-data";
        }
        return data;
    } catch (err) {
        console.error('Error fetching roles:', err);
    }
}
async function loadRolesLookups() {
    try {
        const { data } = await fetchRolesLookups();
        rolesLookups.value = data.map(item => item.role_name) || [];
        console.log(rolesLookups.value);
    } catch (err) {
        console.error('Error fetching roles:', err);
    }
}

function openDeleteDialog(item) {
    deleteUserId.value = item.id;
    deleteDialog.value = true;
}

async function submitNewUser() {
    await insertNewUser({ formData:newUser });
    insertDialog.value = false;
    loadUsers();
}

async function requestUpdate(userId) {
    const formData = { ...editUser.value };  // Spread the `editUser` object into a new `formData`
    await updateUser({ formData, id: userId });
    editDialog.value = false;
    loadUsers();
}


async function requestDelete(userId) {
    await deleteUser({ id: deleteUserId.value });
    deleteDialog.value = false;
    loadUsers();
}

onMounted(() => {
    loadUsers();
    loadRolesLookups();
});
</script>