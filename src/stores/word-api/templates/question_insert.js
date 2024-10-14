import { Document, Packer, Paragraph, Table, TableCell, TableRow, WidthType, ImageRun } from 'docx';
import { saveAs } from 'file-saver';
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
const examStore = useExamQuestionModelStore();
async function loadImageFile(url) {
  const response = await fetch(url);
  const blob = await response.blob();  // Convert response to a Blob

  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = (event) => resolve(event.target.result);
    reader.onerror = (error) => reject(error);
    reader.readAsArrayBuffer(blob); // Read as binary data from Blob
  });
}

export const generateExamQuestionsDoc = async () => {
  const store = useExamQuestionModelStore();
  const sections = store.exam_question_model.sections;

  // Filter out null sections
  const validSections = sections.filter(section => section !== null);

  // Initialize an array to hold the table rows
  const tableRows1 = [];
  const tableRows = [];

  // Await for the image to load properly
  const imageBuffer = await loadImageFile('/logo/scolastica_logo.png');

  // Add a new Table before the table with 12 column

  tableRows1.push(
    new TableRow({
      children: [
        // First Column: 
        new TableCell({
          columnSpan:8,
          children: [
            // Create a paragraph that contains an image
            new Paragraph({
              alignment: 'center',
              children: [
                new ImageRun({
                  data: imageBuffer,
                  transformation:{
                    width:75,
                    height:50,
                  
                  }
                
                }),
              ],
            }),
          ]
        }),
      ],
    }),
    new TableRow({
      children: [
        // First Column: Name
        new TableCell({
          children: [
            new Paragraph({
              // First Column: Name
              text: `Name`,
              style: `customOptionStyle`,
            }),
          ]
        }),
        // Second Column: Name Data
        new TableCell({
          children: [

            new Paragraph({
              // Second Column: Name Data
              text: '                ',
              style: `customOptionStyle`,

            }),
          ],
          columnSpan: 5,
        }),

        // Third Column: Mark Obtained 
        new TableCell({
          children: [
            new Paragraph({
              text: 'Marks Obtained',
              style: 'customOptionStyle',
            }),
          ]
        }),
        // Fourth Column
        new TableCell({
          children: [
            new Paragraph({
              // Fourth Column: Marks obtained Data
              text: '                ',
              style: `customOptionStyle`,

            }),
          ],
        }),
      ],
    }),

    new TableRow({
      children: [
        // First Column: Name
        new TableCell({
          children: [
            new Paragraph({
              // First Column: Name
              text: `Class`,
              style: `customOptionStyle`,
            }),
          ]
        }),
        // Second Column: Name Data
        new TableCell({
          children: [

            new Paragraph({
              // Second Column: Name Data
              text: examStore.exam_question_model.exam_for_class,
              style: `customOptionStyle`,

            }),
          ],
        }),

        // Third Column: Mark Obtained 
        new TableCell({
          children: [
            new Paragraph({
              text: 'Section',
              style: 'customOptionStyle',
            }),
          ]
        }),
        // Fourth Column
        new TableCell({
          children: [
            new Paragraph({
              // Fourth Column: Marks obtained Data
              text: examStore.exam_question_model.class_section,
              style: `customOptionStyle`,

            }),
          ],
        }),
        // fifth Column
        new TableCell({
          children: [
            new Paragraph({
              // Fourth Column: Marks obtained Data
              text: 'ID',
              style: `customOptionStyle`,

            }),
          ],
        }),

        // sixth Column
        new TableCell({
          children: [
            new Paragraph({
              // sixth Column: Marks obtained Data
              text: 'Total',
              style: `customOptionStyle`,

            }),
          ],
        }),
        new TableCell({
          children: [
            new Paragraph({
              // seventh Column: Marks obtained Data
              text: examStore.exam_question_model.total_marks,
              style: `customOptionStyle`,

            }),
          ],
        }),

      ],
    }),

    // Row before additional remark
    new TableRow({
      
      children:[
        new TableCell({
          children:[
            new Paragraph({
              text:'Date',
              style:'customOptionStyle',
            }),

          ],
         
        }),
        new TableCell({
          children:[
            new Paragraph({
              text:examStore.exam_question_model.exam_date,
              style:'customOptionStyle',
            }),
            
          ],
          colSpan:2,
        }),
        new TableCell({
          children:[
            new Paragraph({
              text:'Teacher',
              style:'customOptionStyle',
            }),

          ],
         columnSpan:2,
        }),
        new TableCell({
          children:[
            new Paragraph({
              text:'',
              style:'customOptionStyle',
            }),
            
          ],
          columnSpan:2,
        }),
      ],
    }),
    new TableRow({
      
      children:[
        new TableCell({
          children:[
            new Paragraph({
              text:examStore.exam_question_model.additional_remark,
              style:'customOptionStyle',
            }),


          ],
          colSpan: 8,
         
        }),
       
      ],
    }),
  );

  // Iterate over each section
  validSections.forEach((section, index) => {
    // Calculate total marks for the section
    const totalMarks = section.section_number_of_questions * section.section_mark_each;

    // Add a row for the section title and marks details
    tableRows.push(
      new TableRow({
        children: [
          // First column: Section title
          new TableCell({
            children: [
              new Paragraph({
                text: `${index + 1}. ${section.section_title}.`,
                style: 'customHeadingStyle', // Use custom named style
              }),
            ],
            borders: { top: { size: 0, color: "ffffff" }, bottom: { size: 0, color: "ffffff" }, left: { size: 0, color: "ffffff" }, right: { size: 0, color: "ffffff" } }, // White borders
          }),
          // Second column: Marks details
          new TableCell({
            children: [
              new Paragraph({
                text: `${section.section_number_of_questions} X ${section.section_mark_each} = ${totalMarks} Marks`,
                style: 'customMarksStyle', // Use custom named style
              }),
            ],
            borders: { top: { size: 0, color: "ffffff" }, bottom: { size: 0, color: "ffffff" }, left: { size: 0, color: "ffffff" }, right: { size: 0, color: "ffffff" } }, // White borders
          }),
        ],
      })
    );

    // Iterate over each question in the section
    section.questions.forEach((question, qIndex) => {
      // Add the question title in the first column
      tableRows.push(
        new TableRow({
          children: [
            new TableCell({
              children: [
                new Paragraph({
                  text: `Q${qIndex + 1}: ${question.question_title}`,
                  style: 'customParagraphStyle', // Use custom named style
                }),
              ],
              borders: { top: { size: 0, color: "ffffff" }, bottom: { size: 0, color: "ffffff" }, left: { size: 0, color: "ffffff" }, right: { size: 0, color: "ffffff" } }, // White borders
            }),
            new TableCell({
              children: [],
              borders: { top: { size: 0, color: "ffffff" }, bottom: { size: 0, color: "ffffff" }, left: { size: 0, color: "ffffff" }, right: { size: 0, color: "ffffff" } }, // White borders
            }),
          ],
        })
      );

      // If the question has options, list them in two columns
      if (question.question_options && question.question_options.length > 0) {
        const optionPairs = [];

        // Prepare option pairs (A with B, C with D)
        for (let i = 0; i < question.question_options.length; i += 2) {
          optionPairs.push([
            question.question_options[i], // Option A or C
            question.question_options[i + 1] || "", // Option B or D (may be empty if odd number of options)
          ]);
        }

        // Add rows for each pair of options
        optionPairs.forEach(([option1, option2], optionIndex) => {
          tableRows.push(
            new TableRow({
              children: [
                new TableCell({
                  children: [
                    new Paragraph({
                      text: `${String.fromCharCode(65 + optionIndex * 2)}: ${option1}`, // Option A, C
                      style: 'customOptionStyle', // Use custom named style
                    }),
                  ],
                  borders: { top: { size: 0, color: "ffffff" }, bottom: { size: 0, color: "ffffff" }, left: { size: 0, color: "ffffff" }, right: { size: 0, color: "ffffff" } }, // White borders
                }),
                new TableCell({
                  children: [
                    new Paragraph({
                      text: `${String.fromCharCode(66 + optionIndex * 2)}: ${option2}`, // Option B, D
                      style: 'customOptionStyle', // Use custom named style
                    }),
                  ],
                  borders: { top: { size: 0, color: "ffffff" }, bottom: { size: 0, color: "ffffff" }, left: { size: 0, color: "ffffff" }, right: { size: 0, color: "ffffff" } }, // White borders
                }),
              ],
            })
          );
        });
      }
    });
  });

// Create the tables
const docTable1 = new Table({
  rows: tableRows1,
  width: { size: 100, type: WidthType.PERCENTAGE },
  borders: {
    top: { size: 1, color: "000000", style: "single" },
    bottom: { size: 1, color: "000000", style: "single" },
    left: { size: 1, color: "000000", style: "single" },
    right: { size: 1, color: "000000", style: "single" },
  },
});

const docTable = new Table({
  rows: tableRows,
  layout: 'autofit',
  width: { size: 100, type: WidthType.PERCENTAGE },
  borders: {
    top: { size: 0, color: "ffffff" },
    bottom: { size: 0, color: "ffffff" },
    left: { size: 0, color: "ffffff" },
    right: { size: 0, color: "ffffff" },
  },
});

  // Create the document with the table as content
  const doc = new Document({
    styles: {
      paragraphStyles: [
        {
          id: 'customHeadingStyle',
          name: 'Custom Heading Style',
          basedOn: 'Heading1',
          next: 'Normal',
          quickFormat: true,
          run: {
            bold: true,
            size: 28,
            font: 'Calibri',
          },
        },
        {
          id: 'customMarksStyle',
          name: 'Custom Marks Style',
          basedOn: 'Normal',
          next: 'Normal',
          quickFormat: true,
          run: {
            bold: true,
            size: 24,
            font: 'Calibri',
          },
        },
        {
          id: 'customParagraphStyle',
          name: 'Custom Paragraph Style',
          basedOn: 'Normal',
          next: 'Normal',
          quickFormat: true,
          run: {
            size: 24,
            font: 'Calibri',
          },
        },
        {
          id: 'customOptionStyle',
          name: 'Custom Option Style',
          basedOn: 'Normal',
          next: 'Normal',
          quickFormat: true,
          run: {
            size: 24,
            font: 'Calibri',
          },
        },
      ],
    },
    sections: [
      {
        children: [new Paragraph({ text: '' }), docTable1, new Paragraph({ text: '' }), docTable],
      },
    ],
  });

  // Save the document
  const buffer = await Packer.toBlob(doc);
  saveAs(buffer, 'exam-questions.docx');
};
