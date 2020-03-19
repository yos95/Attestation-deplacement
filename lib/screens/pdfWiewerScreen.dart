import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;
  final List<int> Bytes;
  const PdfViewerPage({Key key, this.path, this.Bytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(path);
    return PDFViewerScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                final String dir =
                    (await getApplicationDocumentsDirectory()).path;
                final String path = '$dir/attestation_deplacement.pdf';
                final File file = File(path);

                File(path).delete();
                Navigator.popAndPushNamed(context, "HomeScreen");
              },
            ),
          ),
          title: Text("Attestation"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                final String dir =
                    (await getApplicationDocumentsDirectory()).path;
                final String path = '$dir/attestation_deplacement.pdf';
                final File file = File(path);
                await Printing.sharePdf(
                    bytes: Bytes, filename: 'attestation-deplacement.pdf');
              },
            ),
          ],
        ),
        path: path);
  }
}
