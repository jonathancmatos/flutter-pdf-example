import 'dart:io';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Report{

  pw.Document? doc;

  Report(){
    doc = pw.Document();
  }

  Future<void> generatePDF() async{
    doc?.addPage(pw.MultiPage(
        margin: const pw.EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context ctx) => <pw.Widget>[
           pw.Container(
             alignment: pw.Alignment.center,
             child: pw.Column(
               children: [
                 pw.Text("Title Report", style: pw.TextStyle(
                   fontSize: 25,
                   fontWeight: pw.FontWeight.bold
                 )),
                 pw.SizedBox(height: 15),
                 pw.Text("Generate in: ${DateFormat("dd/MM/yyyy").format(DateTime.now())}", style: pw.TextStyle(
                     fontSize: 14,
                     fontWeight: pw.FontWeight.bold
                 )),
               ]
             )
          ),
          pw.SizedBox(height: 56),
          pw.ListView.builder(
              itemCount: 5, //dynamic quantity
              itemBuilder: (ctx, index){
                return pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 16),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                      children: [
                        pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: pw.BoxDecoration(
                                borderRadius: pw.BorderRadius.circular(4),
                                color: PdfColors.black
                            ),
                            child: pw.Text("0${index+1} - Group", style: pw.TextStyle(
                                color: PdfColors.white,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 18
                            ))
                        ),
                        pw.ListView.builder(
                          itemCount: 12, //dynamic quantity
                          itemBuilder: (ctx, index){
                            return pw.Container(
                                alignment: pw.Alignment.centerLeft,
                                padding: const pw.EdgeInsets.all(16),
                                margin: const pw.EdgeInsets.only(bottom: 4),
                                width: double.infinity,
                                color: PdfColors.grey300,
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                                  children: [
                                    pw.Text("Item Product"),
                                    pw.SizedBox(height: 12),
                                    pw.Wrap(
                                        children: List.generate(3, (index){
                                          return pw.Container(
                                              margin: const pw.EdgeInsets.only(right: 14, bottom: 12),
                                              width: 60,
                                              height: 60,
                                              color: PdfColors.grey500
                                          );
                                        })
                                    )
                                  ]
                                )
                            );
                          },
                        )
                      ])
                );
              })
        ])
    );
    await _save();
  }

  Future<void> _save() async {
    final output = await getApplicationDocumentsDirectory();
    final fileName = "${output.path}/example.pdf";

    final file = File(fileName);
    await file.writeAsBytes(await doc!.save());
    await OpenFile.open(fileName);
  }

}