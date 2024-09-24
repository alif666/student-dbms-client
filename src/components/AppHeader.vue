<template>

  <v-app-bar color="primary" prominent>
    <v-app-bar-nav-icon variant="text" @click.stop="drawer = !drawer"></v-app-bar-nav-icon>

    <v-toolbar-title>Student DBMS</v-toolbar-title>

    <v-spacer></v-spacer>

    <template v-if="$vuetify.display.mdAndUp">
      <v-btn icon="mdi-magnify" variant="text"></v-btn>

      <v-btn icon="mdi-filter" variant="text"></v-btn>
    </template>

    <v-btn icon="mdi-exit-run" variant="text" @click="userLogout"></v-btn>


  </v-app-bar>
  <v-navigation-drawer v-model="drawer" :location="$vuetify.display.mobile ? 'bottom' : undefined" temporary>
    <v-divider />
    <v-list v-for="item in items" :key="item.id" density="compact" nav>
      <v-list-item :title="item.nav_text" :prepend-icon="item.nav_icon"
        @click="navigateTo(`/${item.nav_path}`)"
        />
    </v-list>

  </v-navigation-drawer>



</template>

<script setup>
import { fetchNavigations } from '@/stores/data-services';

import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const drawer = ref(false);
const items = ref([]);

const navigateTo = (path) => {
  router.push(path);
};

async function loadNavigations() {
  console.log("################### LOAD NAVIGATION CALLED ##################");
  const response = await fetchNavigations();
  if (response && response.data) {
    items.value = response.data; // Set items.value directly to the data array
    console.log("ITEMS FETCHED #######################", items.value);
  } else {
    console.error("No data fetched or there was an error.");
  }
}


// Load navigation items on component mount
onMounted(() => {
  loadNavigations();
});

const userLogout = () => {
  localStorage.removeItem('user');
  console.log("LOCALSTORAGE");
  localStorage.getItem('user');
  router.push('/');
};
</script>
