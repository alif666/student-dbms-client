<template>
   
      <v-app-bar
        color="primary"
        prominent
      >
        <v-app-bar-nav-icon variant="text" @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

        <v-toolbar-title>My files</v-toolbar-title>

        <v-spacer></v-spacer>

        <template v-if="$vuetify.display.mdAndUp">
          <v-btn icon="mdi-magnify" variant="text"></v-btn>

          <v-btn icon="mdi-filter" variant="text"></v-btn>
        </template>

        <v-btn icon="mdi-exit-run" variant="text" @click="userLogout"></v-btn>
      </v-app-bar>

      <v-navigation-drawer
        v-model="drawer"
        :location="$vuetify.display.mobile ? 'bottom' : undefined"
        temporary
      >
      <v-list>
          <v-list-item prepend-avatar="https://randomuser.me/api/portraits/women/85.jpg" subtitle="sandra_a88@gmail.com"
            title="Sandra Adams" />
        </v-list>
        <v-divider />
        <v-list density="compact" nav>
          <v-list-item prepend-icon="mdi-account-multiple" title="Students" @click="navigateTo('/students')" />
          <v-list-item prepend-icon="mdi-account-multiple" title="Staff" @click="navigateTo('/staff')" />
          <v-list-item prepend-icon="mdi-checkbox-marked" title="Attendance" @click="navigateTo('/attendance')" />
          <v-list-item prepend-icon="mdi-school" title="Grade" @click="navigateTo('/grade')" />
          <v-list-item prepend-icon="mdi-calendar-multiple" title="Routine" @click="navigateTo('/routine')" />
          <v-list-item prepend-icon="mdi-book-multiple" title="Homework" @click="navigateTo('/homework')" />
          <v-list-item prepend-icon="mdi-exit-run" title="Exam" @click="navigateTo('/exam')" />
          <v-list-item prepend-icon="mdi-archive" title="Inventory" @click="navigateTo('/inventory')" />
          <v-list-item prepend-icon="mdi-book-plus-multiple" title="Library" @click="navigateTo('/library')" />
        </v-list>
      </v-navigation-drawer>


</template>


<script setup>
import { useRouter } from 'vue-router'
import { useCookies } from 'vue3-cookies';
const router = useRouter()

const drawer = ref(false)

const navigateTo = (path) => {
  router.push(path)
}

const { cookies } = useCookies();


const userLogout=()=>{
  localStorage.removeItem('user');
  console.log("LOCALSTORAGE");
  localStorage.getItem('user');
  router.push('/');
}

</script>