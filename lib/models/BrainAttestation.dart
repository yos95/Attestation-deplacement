import 'dart:core';
import 'dart:io';
import 'package:confinement/models/Print.dart';
import 'package:printing/printing.dart';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;

var logger = Logger();

class brain {
  static save(String key, String value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString(key, value);
  }

  static String formatedDate(DateTime date, String dateFormated) {
    if (date == null) {
    } else {
      var month = date.month;
      var day = date.day;
      var monthFormated, dayFormated;
      if (month < 10) {
        monthFormated = "0" + month.toString();
      } else {
        monthFormated = month.toString();
      }
      if (day < 10) {
        dayFormated = "0" + day.toString();
      } else {
        dayFormated = day.toString();
      }
      dateFormated = dayFormated.toString() +
          "/" +
          monthFormated.toString() +
          "/" +
          date.year.toString();
    }
    return dateFormated;
  }

  static String formatedDateNow(var date) {
    if (date < 10) {
      return "0" + date.toString();
    } else {
      return date.toString();
    }
  }

  static Future<print> pdf(img, image, name, dateFormated, adresse, motif,
      dayNowFormated, monthNowFormated, yearNow, ville) async {
    final pdf = pw.Document();
    final imageX = PdfImage(
      pdf.document,
      image: img.buffer.asUint8List(),
      width: image.width,
      height: image.height,
    );
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: <pw.Widget>[
              pw.Container(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Text(
                      'ATTESTATION DE DÉPLACEMENT DÉROGATOIRE',
                      textScaleFactor: 1.6,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                        'En application de l\'article 1er du décret du 16 mars 2020 portant réglementation des déplacements dans le cadre de la lutte contre la propagation du virus Covid-19',
                        textScaleFactor: 0.9),
                    pw.SizedBox(height: 60),
                    pw.Text('Je soussigné(e) ' + name, textScaleFactor: 2.4),
                    pw.Text('né(e) le ' + dateFormated, textScaleFactor: 2.4),
                    pw.Text('demeurant au ' + adresse, textScaleFactor: 2.4),
                    pw.Text(
                        'certifie me rendre à l\'éxterieur pour le motif: ' +
                            motif,
                        textScaleFactor: 2.4),
                    pw.SizedBox(height: 80),
                  ],
                ),
              ),
              pw.Text(
                  'Le ' +
                      dayNowFormated.toString() +
                      "/" +
                      monthNowFormated.toString() +
                      "/" +
                      yearNow.toString() +
                      ' a ' +
                      ville,
                  textScaleFactor: 1.2),
              pw.Image(imageX),
            ],
          ); // Center
        }));

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/attestation_deplacement.pdf';
    final File file = File(path);
    var Bytes = pdf.save();

    print prints = print(path, Bytes);
    return prints;
  }
}
