<template>
    <v-card>
      <v-card-title>
        <h2>{{ isEdit ? "Edit Announcement" : "Create Announcement" }}</h2>
      </v-card-title>
      <v-card-text>
        <v-form ref="announcementForm" @submit.prevent="submitForm">
          <v-text-field
            label="Title"
            v-model="form.title"
            :rules="rules.required"
          />
          
          <v-textarea
            label="Description"
            v-model="form.description"
            :rules="rules.required"
          />
          <v-file-input
            label="Attachment"
            v-model="form.attachment"
            accept="image/*,application/pdf"
            prepend-icon="mdi-paperclip"
          />
  
          <v-menu
            v-model="menu"
            :close-on-content-click="false"
            :nudge-right="40"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                v-model="form.date"
                label="Announcement Date"
                prepend-icon="mdi-calendar"
                readonly
                v-bind="attrs"
                v-on="on"
              />
            </template>
            <v-date-picker v-model="form.date" @input="menu = false"></v-date-picker>
          </v-menu>
  
          <v-checkbox
            v-model="form.isActive"
            label="Active"
          />
  
          <v-btn
            color="primary"
            @click="submitForm"
            :loading="loading"
          >
            {{ isEdit ? "Update" : "Create" }}
          </v-btn>
          <v-btn color="secondary" @click="resetForm">Reset</v-btn>
        </v-form>
      </v-card-text>
    </v-card>
  </template>
  
  <script>
  export default {
    props: {
      announcement: Object, // for edit case, will pass data
    },
    data() {
      return {
        form: {
          title: this.announcement?.title || '',
          description: this.announcement?.description || '',
          attachment: null,
          date: this.announcement?.date || '',
          isActive: this.announcement?.isActive || false,
        },
        rules: {
          required: [(v) => !!v || "This field is required"],
        },
        loading: false,
        isEdit: !!this.announcement,
        menu: false,
      };
    },
    methods: {
      submitForm() {
        if (this.$refs.announcementForm.validate()) {
          this.loading = true;
          const formData = new FormData();
          formData.append("title", this.form.title);
          formData.append("description", this.form.description);
          if (this.form.attachment) {
            formData.append("attachment", this.form.attachment);
          }
          formData.append("date", this.form.date);
          formData.append("isActive", this.form.isActive);
  
          // Emit the form data
          this.$emit("submit", formData);
          this.loading = false;
        }
      },
      resetForm() {
        this.form = {
          title: '',
          description: '',
          attachment: null,
          date: '',
          isActive: false,
        };
      }
    }
  };
  </script>
  