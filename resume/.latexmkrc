$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -halt-on-error %O %S';

# After every successful compile, publish the PDF to the website.
$success_cmd = 'cp resume.pdf ../assets/pdf/resume.pdf && echo "Published -> assets/pdf/resume.pdf"';
