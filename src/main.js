/**
 * main.js
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

// Plugins
import { registerPlugins } from '@/plugins'
import dropzone from 'dropzone-vue';

// Components
import App from './App.vue'

// Composables
import { createApp } from 'vue'

// Cookies
import VueCookies from 'vue3-cookies';

const app = createApp(App)

app.use(dropzone);

registerPlugins(app)

app.config.errorHandler = (err, vm, info) => {
    console.error(err, info);
  };
  

app.mount('#app')
