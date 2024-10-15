/**
 * plugins/vuetify.js
 *
 * Framework documentation: https://vuetifyjs.com`
 */

// Styles
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'
import { sv } from 'vuetify/locale'
// Composables
import { createVuetify } from 'vuetify'
import { VBtn, VAppBar, VAvatar,VDivider } from 'vuetify/components'
// Translations provided by Vuetify
import { pl, zhHans } from 'vuetify/locale'

// Your own translation file


// Internationalization 


// https://vuetifyjs.com/en/introduction/why-vuetify/#feature-guides
export default createVuetify({
  locale: {
    locale: 'en',

  },
  date: {
    locale: {
      en: 'en-GB',
    },
  },
  theme: {
    defaultTheme: 'light',
  },
  aliases: {
    VBtnSecondary: VBtn,
    VBtnTertiary: VBtn,
    VAppBar: VAppBar,
  },
  defaults: {
    VBtn: {
      color: 'primary',
      variant: 'text',
    },
    VBtnSecondary: {
      color: 'secondary',
      variant: 'flat',
    },
    VBtnTertiary: {
      rounded: true,
      variant: 'plain',
    },
    VAppBar: {
      color: '#6B85E4',
      variant: 'plain',
    },
    VAvatar:{
      color:'#E1E1E1',

    
    },
    VDivider:{
      display: 'block',
      flex:' 1 1 100%',
      height: '0px',
      opacity: '1.0',
      transition: 'inherit',
    }

  },
})
// 