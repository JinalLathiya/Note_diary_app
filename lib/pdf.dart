import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'main.dart';

class CreateResume {
  static Future<File> generateCenteredText(String text) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: datas.map((e) => pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(15),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(e.time),
                  pw.SizedBox(height: 5),
                  pw.Text(e.data),
                ],
              ),
            )).toList(),
          );
        },
      ),
    );
    return saveDocument(name: "my_example.pdf", pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}