import { Document, Packer, Paragraph, TextRun, Footer, PageNumber } from 'docx';
import { saveAs } from 'file-saver';
import { renderAsync } from 'docx-preview'; // Import docx-preview's render function
import { useExamQuestionModelStore } from '@/stores/examQuestionModelStore';
export async function generateAndPreviewWordDocument(doc) {

    // Generate the document as an array buffer
    const buffer = await Packer.toBuffer(doc);

    // Render the document in the browser using docx-preview
    renderAsync(buffer, containerElement);
}




// ####################### GENEERATE WORD DOC ################################


export async function generateDoc() {
    const examStore = useExamQuestionModelStore();
    const doc = new Document({
        styles: {
            default: {
                heading2: {
                    run: {
                        font: "Calibri",
                        size: 14,
                        bold: true,
                    },
                    paragraph: {
                        alignment: "left",
                    },
                },
                paragraph: {
                    run: {
                        font: "Calibri",
                        size: 11,
                    },
                    paragraph: {
                        alignment: "justify",
                    },
                },
            },
        },
        sections: [],
    });

    // Iterate over each section in the exam model and add details to the document
    examStore.exam_question_model.sections.forEach((section, index) => {
        // Add a heading for each section
        doc.addSection({
            properties: {},
            children: [
                new Paragraph({
                    text: `Section ${index + 1}: ${section.section_title}`,
                    heading: "heading2"
                }),

                // Add the question category (e.g., MCQ, True/False)
                new Paragraph({
                    text: `Question Category: ${section.question_category}`,
                }),

                // Add number of questions if available
                section.section_number_of_questions
                    ? new Paragraph({
                          text: `Number of Questions: ${section.section_number_of_questions}`,
                      })
                    : null,

                // Add marks per question if available
                section.section_mark_each
                    ? new Paragraph({
                          text: `Marks per Question: ${section.section_mark_each}`,
                      })
                    : null,

                // Add the individual questions (dynamically based on how many exist)
                ...Object.keys(section)
                    .filter(key => key.startsWith("question_title_"))
                    .map(questionKey => 
                        new Paragraph({
                            text: `${section[questionKey]}`,
                        })
                    ),
            ].filter(Boolean), // Filter out any null/undefined values
        });
    });

    Packer.toBlob(doc).then((blob) => {
        saveAs(blob, "exam_document.docx");
    });


}



export async function generateWordDocument() {
    const doc = new Document({
        styles: {
            default: {
                heading2: {
                    run: {
                        font: "Shonar Bangla",
                        size: 28, // 14pt
                        bold: true,
                    },
                    paragraph: {
                        alignment: "left",
                    },
                },
                paragraph: {
                    run: {
                        font: "Shonar Bangla",
                        size: 24, // 12pt
                    },
                    paragraph: {
                        alignment: "justify",
                    },
                },
            },
        },
        sections: [],
    });

    const sections = [
        {
            title: "প্রশ্ন ১। সঠিক উত্তরে টিক (√) চিহ্ন দাও ।                                                                                   (১×১০=১০)",
            questionType: "MCQ",
            questions: [
                {
                    text: "নিম্নলিখিত কোনটি প্রাণী নয়?",
                    options: ["কুকুর", "বিড়াল", "গাড়ি", "হাতি"]
                },
                {
                    text: "বাংলাদেশের রাজধানী কোনটি?",
                    options: ["ঢাকা", "চট্টগ্রাম", "রাজশাহী", "সিলেট"]
                },
                {
                    text: "সবচেয়ে বড় মহাদেশ কোনটি?",
                    options: ["এশিয়া", "আফ্রিকা", "ইউরোপ", "অস্ট্রেলিয়া"]
                },
                {
                    text: "নিম্নলিখিত কোনটি নদী নয়?",
                    options: ["গঙ্গা", "যমুনা", "নেপচুন", "মেঘনা"]
                },
                {
                    text: "নিম্নলিখিত কোনটি ফল নয়?",
                    options: ["আপেল", "কমলা", "টমেটো", "গম"]
                }
            ],
        },
        {
            title: "প্রশ্ন ২। নিচের বক্তব্যের সঠিক বা ভুল নির্বাচন করো ।                                                                                   (১×১০=১০)",
            questionType: "TrueFalse",
            questions: [
                {
                    text: "সূর্য পূর্ব দিকে ওঠে।",
                    options: ["সত্য", "মিথ্যা"]
                },
                {
                    text: "পৃথিবী চাঁদের চারপাশে ঘোরে।",
                    options: ["সত্য", "মিথ্যা"]
                },
                {
                    text: "মানুষ শ্বাস নিয়ে বাঁচে।",
                    options: ["সত্য", "মিথ্যা"]
                },
                {
                    text: "গাছ কার্বন ডাই অক্সাইড গ্রহণ করে।",
                    options: ["সত্য", "মিথ্যা"]
                },
                {
                    text: "তাপমাত্রা হিমাঙ্কের নিচে পানি তরল অবস্থায় থাকে।",
                    options: ["সত্য", "মিথ্যা"]
                }
            ],
        }
    ];

    // Loop over sections and questions
    sections.forEach((section, sectionIndex) => {
        const questionParagraphs = section.questions.map((question, questionIndex) => {
            const questionTitle = new Paragraph({
                text: `প্রশ্ন ${sectionIndex * 5 + questionIndex + 1}: ${question.text}`,
                heading: "Heading2",
            });

            const optionParagraphs = question.options.map((option, i) => {
                return new Paragraph({
                    text: `${String.fromCharCode(97 + i)}. ${option}`,
                    style: "Normal",
                });
            });

            return [questionTitle, ...optionParagraphs];
        });

        // Ensure the children array is properly flattened and defined
        doc.addSection({
            children: [
                new Paragraph({
                    text: section.title,
                    heading: "Heading2",
                }),
                ...questionParagraphs.flat(), // Flattening the array
            ],
        });

    });

    // Footer with page number and version
    doc.addSection({
        children: [], // Must define children even for a section with only footers
        footers: {
            default: new Footer({
                children: [
                    new Paragraph({
                        children: [
                            new TextRun({
                                text: "পৃষ্ঠা সংখ্যা: ",
                                font: "Shonar Bangla",
                                bold: true,
                            }),
                            new TextRun({
                                text: PageNumber.CURRENT, // Ensure this is a text value
                                font: "Shonar Bangla",
                                bold: true,
                            }),
                            new TextRun({
                                text: " | Version 1.0",
                                font: "Calibri",
                                size: 24, // 12pt size for the version number in English
                            }),
                        ],
                        alignment: "center",
                    }),
                ],
            }),
        },
    });

    // Generate and save the document
    Packer.toBlob(doc).then((blob) => {
        saveAs(blob, "New1_Doc.docx");
    });
}
