<template>
  <v-container>
    <v-row>
      <v-col cols="12" class="d-flex justify-end">
        <v-btn color="primary" @click="showForm = true">Create Announcement</v-btn>
      </v-col>
    </v-row>

    <v-row>
      <v-col cols="12">
        <v-data-table
          :headers="headers"
          :items="announcements"
          :items-per-page="5"
          class="elevation-1"
        >
          <template v-slot:item.actions="{ item }">
            <v-icon small @click="editAnnouncement(item)">mdi-pencil</v-icon>
            <v-icon small @click="deleteAnnouncement(item)">mdi-delete</v-icon>
          </template>
        </v-data-table>
      </v-col>
    </v-row>

    <v-dialog v-model="showForm" max-width="600px">
      <form-announcement
        v-if="currentAnnouncement"
        :announcement="currentAnnouncement"
        @submit="handleSubmit"
      />
      <form-announcement
        v-else
        @submit="handleSubmit"
      />
    </v-dialog>
  </v-container>
</template>

<script>
import FormAnnouncement from './form.vue';

export default {
  components: { FormAnnouncement },
  data() {
    return {
      announcements: [],
      showForm: false,
      currentAnnouncement: null,
      headers: [
        { text: 'Title', value: 'title' },
        { text: 'Description', value: 'description' },
        { text: 'Date', value: 'date' },
        { text: 'Active', value: 'isActive' },
        { text: 'Actions', value: 'actions', sortable: false },
      ],
    };
  },
  methods: {
    handleSubmit(data) {
      if (this.currentAnnouncement) {
        // update logic
        Object.assign(this.currentAnnouncement, data);
      } else {
        // create logic
        this.announcements.push({ ...data, id: Date.now() });
      }
      this.showForm = false;
      this.currentAnnouncement = null;
    },
    editAnnouncement(announcement) {
      this.currentAnnouncement = announcement;
      this.showForm = true;
    },
    deleteAnnouncement(announcement) {
      this.currentAnnouncement = announcement;
      this.showForm = true;
    }
  }
};
</script>
