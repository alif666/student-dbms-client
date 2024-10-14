<template>
    <Suspense>
        <template #default>
            <div>
                <!-- School Name Display -->
                <span>
                    School Name for ID 1: {{ schoolData.name || 'Loading...' }}
                </span>
                <br>

                <!-- Class Names Display -->
                <span>
                    Class Names: 
                    <span v-if="classLookup">
                        <ul>
                            <li v-for="classItem in classLookup" :key="classItem.id">
                                {{ classItem.value_en }} ({{ classItem.value_bn }})
                            </li>
                        </ul>
                    </span>
                    <span v-else>No Class Names Available</span>
                </span>
                <br>

                <!-- Class Groups Display -->
                <span>
                    Class Groups: 
                    <span v-if="classGroupLookUp">
                        <ul>
                            <li v-for="group in classGroupLookUp" :key="group.id">
                                {{ group.groups }}
                            </li>
                        </ul>
                    </span>
                    <span v-else>No Class Groups Available</span>
                </span>
                <br>

                <!-- Section Lookup Display -->
                <span>
                    Section Lookup: 
                    <span v-if="sectionLookUp">
                        <ul>
                            <li v-for="section in sectionLookUp" :key="section.id">
                                {{ section.value_en }} ({{ section.value_bn }})
                            </li>
                        </ul>
                    </span>
                    <span v-else>No Sections Available</span>
                </span>
                <br>

                <!-- Subjects Lookup Display -->
                <span>
                    Subjects Lookup: 
                    <span v-if="subjectLookUp">
                        <ul>
                            <li v-for="subject in subjectLookUp" :key="subject.id">
                                {{ subject.value_en }} ({{ subject.value_bn }})
                            </li>
                        </ul>
                    </span>
                    <span v-else>No Subjects Available</span>
                </span>
                <br>

                <!-- Language Selection Section -->
                <div>
                    <h2>Select Language</h2>
                    <select @change="changeLocale($event.target.value)">
                        <option value="zhHans">Chinese (Simplified)</option>
                        <option value="pl">Polish</option>
                        <option value="sv">Swedish</option>
                    </select>
                </div>
            </div>
        </template>

        <template #fallback>
            <span>Loading data...</span>
        </template>
    </Suspense>
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
const classLookup = ref([]);
const classGroupLookUp = ref([]);
const sectionLookUp = ref([]);
const subjectLookUp = ref([]);

// Load data functions
async function loadSchoolData() {
    schoolData.value = await fetchSchoolById({ id: 1 });
}

async function loadLookups() {
    classLookup.value = (await fetchClassNameLookup()).data;
    classGroupLookUp.value = (await fetchClassGroupLookUp()).data;
    console.log("ClassGroupLookup",classGroupLookUp.value);
    sectionLookUp.value = (await fetchSectionLookup()).data;
    console.log("SectionLookup",sectionLookUp.value);
    subjectLookUp.value = (await fetchSubjectLookUp()).data;
    console.log("Subject Lookup",subjectLookUp.value);
}

// Load data on component mount
onMounted(async () => {
    await loadSchoolData();
    await loadLookups();
});
</script>
