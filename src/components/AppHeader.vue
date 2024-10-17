<template>
  <v-app-bar prominent>
    <!-- Navigation Icon -->
    <v-app-bar-nav-icon class="custom-nav-icon" @click.stop="drawer = !drawer">
      <v-img src="@/assets/nav_icon.png" alt="Nav Icon" class="icon-image" width="24" height="24" contain />
    </v-app-bar-nav-icon>

    <!-- App Title -->
    <v-toolbar-title>Student DBMS</v-toolbar-title>

    <v-spacer></v-spacer>

    <!-- User Icon Button (visible only on medium and up screens) -->
    <template v-if="$vuetify.display.mdAndUp">
      <v-btn  >
        <v-img src="@/assets/user_placeholder.png" alt="User Icon" rounded class="icon-image" width="36" height="36" contain />
      </v-btn>
    </template>
  </v-app-bar>

  <!-- Navigation Drawer -->
  <v-navigation-drawer v-if="$vuetify.display.mdAndUp" flat permanent rail>
    <v-divider />

    <!-- Navigation Items List -->
    <v-list density="compact" nav>
      <v-list-item
        v-for="item in items"
        :key="item.id"
        :title="item.nav_text"
        :prepend-icon="item.nav_icon"
        @click="navigateTo(`/${item.nav_path}`)"
      />
    </v-list>
  </v-navigation-drawer>
  <v-navigation-drawer v-model="drawer" elevation="4" :location="$vuetify.display.mobile ? 'bottom' : undefined">
    <v-divider />

    <!-- Navigation Items List -->
    <v-list density="compact" nav>
      <v-list-item
        v-for="item in items"
        :key="item.id"
        :title="item.nav_text"
        @click="navigateTo(`/${item.nav_path}`)"
      />
    </v-list>
  </v-navigation-drawer>
</template>

  <!-- </template> -->

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

  <style scoped>
    .custom-nav-icon {
      background-color: transparent;
      /* Makes the inside transparent */
      border-radius: 50%;
      /* Makes the icon outline rounded */
      width: 48px;
      /* Set a width for the nav icon */
      height: 48px;
      /* Set a height for the nav icon */
      display: flex;
      align-items: center;
      justify-content: center;

    }
  </style>
