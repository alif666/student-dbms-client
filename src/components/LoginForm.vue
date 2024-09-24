<template>
  <!-- Login form -->
  <v-card class="mx-auto pa-12 pb-8 mt-12" elevation="8" max-width="448" rounded="lg">
    <v-list>
      <v-list-item class="login-box" prepend-icon="mdi-school" title="STUDENT DBMS" />
    </v-list>

    <v-text-field v-model="name" density="compact" placeholder="Email address"
      prepend-inner-icon="mdi-email-outline" variant="outlined" />

    <v-text-field v-model="password" @keypress.enter="login"
      :type="'password'" density="compact" placeholder="Enter your password"
      prepend-inner-icon="mdi-lock-outline" variant="outlined" />

    <template v-if="errorMsg">
      <v-text class="text-red">{{ errorMsg }}</v-text>
    </template>

    <v-btn class="mb-8" color="blue" size="large" variant="tonal" block @click="login">
      Log In
    </v-btn>
  </v-card>
  <!-- Login form ends -->
</template>

<script setup>
import { useCookies } from 'vue3-cookies';
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { authenticate } from '@/stores/data-services';

const { cookies } = useCookies();
const router = useRouter();

const name = ref('');
const password = ref('');
const errorMsg = ref('');

const login = async () => {
  const data = await authenticate({ email: name.value, password: password.value });
  
  if (data && data.length > 0) {
    const user = { name: name.value };
    cookies.set('user', user, '1d'); // Set cookie for 1 day
    router.push('/dashboard'); // Navigate to the dashboard
    console.log("COOKIE SET & LENGTH");
    localStorage.setItem('user',user);
    console.log(localStorage.getItem('user'));
  } else {
    errorMsg.value = "Wrong Username or Password";
  }
};
</script>
