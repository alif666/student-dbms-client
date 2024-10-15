<template>
    <div>
        <div id="export-container">
            <h3>Your content to be exported here</h3>
        </div>
        <ExportToWord element="export-container" filename="document">
            <button>Click here to export</button>
        </ExportToWord>
    </div>
</template>

<script lang="ts">
import { ExportToWord } from 'vue-doc-exporter';

export default {
    components: {
        ExportToWord
    }
}
</script>