<template #default>
    <v-list>
        <!-- School Name Display -->
      
            School Name for ID 1: {{ schoolData.name || 'Loading...' }}



        <!-- Class Names Display -->

        <v-list-subheader>
            Class Names:
        </v-list-subheader>

        <v-list-items v-if="classLookup.data.length">

            <v-list-item v-for="classItem in classLookup.data" :key="classItem.id">
                {{ classItem.value_en }} ({{ classItem.value_bn }})
            </v-list-item>

        </v-list-items>
        <v-list-item v-else>No Class Names Available</v-list-item>

        <!-- Class Groups Display -->
        <v-list-subheader>
            Class Groups:
        </v-list-subheader>
        <v-list-items v-if="classGroupLookUp.data.length">

            <v-list-item v-for="group in classGroupLookUp.data" :key="group.id">
                {{ group.groups }}
            </v-list-item>

        </v-list-items>
        <v-list-item v-else>NA</v-list-item>


        <!-- Section Lookup Display -->
        <v-list-subheader>
            Section:
        </v-list-subheader>
        <v-list-items v-if="sectionLookUp.data.length">

            <v-list-item v-for="section in sectionLookUp.data" :key="section.id">
                {{ section.value_en }} {{ section.value_bn }}
            </v-list-item>

        </v-list-items>
        <v-list-item v-else>NA</v-list-item>


        <!-- Subjects Lookup Display -->
        <v-list-subheader>
            Section:
        </v-list-subheader>
        <v-list-items v-if="sectionLookUp.data.length">

            <v-list-item v-for="section in sectionLookUp.data" :key="section.id">
                {{ section.value_en }} ({{ section.value_bn }})
            </v-list-item>
        </v-list-items>
        <v-list-item v-else>NA</v-list-item>

        <v-list-subheader>
            Subjects Lookup:
        </v-list-subheader>

   
            <v-list-items v-if="subjectLookUp.data.length">
           
                    <v-list-item v-for="subject in subjectLookUp.data" :key="subject.id">
                        {{ subject.value_en }} ({{ subject.value_bn }})
                    </v-list-item>
       
            </v-list-items>
            <v-list-item v-else>NA</v-list-item>

        <!-- Language Selection Section -->
        <v-list-subheader>Select Language</v-list-subheader>
        <select @change="changeLocale($event.target.value)">
            <option value="zhHans">Chinese (Simplified)</option>
            <option value="pl">Polish</option>
            <option value="sv">Swedish</option>
        </select>
    </v-list>
</template>


<script setup>
import { ref, onMounted } from 'vue';
import {
    fetchClassGroupLookUp,
    fetchClassNameLookup,
    fetchSchoolById,
    fetchSectionLookup,
    fetchSubjectLookUp
} from '@/stores/data-services';
import { useLocale } from 'vuetify';

// Locale handling
const { current } = useLocale();

// Function to change the current locale
function changeLocale(locale) {
    current.value = locale;
}

// State variables initialized with expected structure to avoid undefined
const schoolData = ref({ name: '' });
const classLookup = ref({ data: [] });
const classes = ref([]);
const sectionLookUp = ref({ data: [] });
const subjectLookUp = ref({ data: [] });

// Load data functions
async function loadSchoolData() {
    schoolData.value = await fetchSchoolById({ id: 1 });
}

async function loadLookups() {
    classLookup.value = await fetchClassNameLookup();
    classGroupLookUp.value = await fetchClassGroupLookUp();
    sectionLookUp.value = await fetchSectionLookup();
    subjectLookUp.value = await fetchSubjectLookUp();
}

// Load data on component mount
onMounted(async () => {
    await loadSchoolData();
    await loadLookups();
});
</script>

<style scoped>
    .v_list_sub_header{
        align-items: center;
        display:table-row-group;
        flex-direction: column;
    }
</style>