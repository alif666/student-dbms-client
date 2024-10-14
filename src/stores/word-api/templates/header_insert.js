import { saveAs } from 'file-saver';
import Docxtemplater from 'docxtemplater';
import PizZip from 'pizzip'; // Required for Docxtemplater to read .docx files
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';

export const generateHeaderDoc = async () => {

    const examStore = useExamQuestionModelStore();
    // Log the entire exam_question_model to debug
    console.log("Exam Question Model:", examStore.exam_question_model);

    try {
        // Fetch the .docx template
        const response = await fetch('/heading_table.docx'); // Use relative path
        if (!response.ok) throw new Error('Network response was not ok');
        
        const blob = await response.blob();
        const arrayBuffer = await blob.arrayBuffer();

        // Load the document using PizZip
        const zip = new PizZip(arrayBuffer);
        const doc = new Docxtemplater(zip, { paragraphLoop: true, lineBreaks: true });

        // Log each field to see if they're being correctly unwrapped
     
        console.log("Data being set to the document:", examStore.exam_question_model); // Log the data being passed

        // Set the values for the placeholders using the 'data' object
        doc.setData(examStore.exam_question_model);

        // Render the document (replace placeholders with actual values)
        doc.render();

        // Generate the modified document and download it
        const output = doc.getZip().generate({ type: 'blob' });
        saveAs(output, 'header_output.docx'); // Name the generated file

    } catch (error) {
        console.error('Error generating document:', error);
    }
};


export const generateHeader = async () => {

    const examStore = useExamQuestionModelStore();
    // Log the entire exam_question_model to debug
    console.log("Exam Question Model:", examStore.exam_question_model);

    try {
        // Fetch the .docx template
        const response = await fetch('/heading_table.docx'); // Use relative path
        if (!response.ok) throw new Error('Network response was not ok');
        
        const blob = await response.blob();
        const arrayBuffer = await blob.arrayBuffer();

        // Load the document using PizZip
        const zip = new PizZip(arrayBuffer);
        const doc = new Docxtemplater(zip, { paragraphLoop: true, lineBreaks: true });

        // Log each field to see if they're being correctly unwrapped
     
        console.log("Data being set to the document:", examStore.exam_question_model); // Log the data being passed

        // Set the values for the placeholders using the 'data' object
        doc.setData(examStore.exam_question_model);

        // Render the document (replace placeholders with actual values)
        doc.render();

        return doc;
    } catch (error) {
        console.error('Error generating document:', error);
        return error;
    }
};
