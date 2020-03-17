import 'dart:io';

import 'package:confinement/models/reportView.dart';
import 'package:confinement/screens/pdfWiewerScreen.dart';
import 'package:confinement/widgets/WidgetButton.dart';
import 'package:confinement/widgets/WidgetDatetime.dart';
import 'package:confinement/widgets/WidgetTextfield.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter/material.dart' as material;
import 'package:direct_select/direct_select.dart';

import 'package:pdf/widgets.dart' as pw;

class attestationScreen extends StatefulWidget {
  @override
  _attestationScreenState createState() => _attestationScreenState();
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;
  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {}

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _attestationScreenState extends State<attestationScreen> {
  final listMotifs = [
    "Achats de première nécessité",
    "Travail",
    "Hopital",
    "Famille agée",
    "Exercice physique",
  ];
  int selectedIndex1 = 0;
  List<Widget> _buildItems1() {
    return listMotifs
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  ByteData _img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  var signature;
  var name;
  var adresse;
  var motif;
  var ville;
  DateTime date;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              Container(
                height: 160.0,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF50BEE4),
                        Color(0xFFAB3A85),
                      ],
                    )),
              ),
              Positioned(
                  bottom: 15,
                  left: 10,
                  child: Column(
                    children: <Widget>[
                      Text("Attestation de déplacement",
                          style: TextStyle(
                            fontFamily: "OpenSans-Bold",
                            fontSize: 26,
                            color: Color(0xffffffff),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    WidgetTextfield(
                        hintText: "Entrer votre nom",
                        icon: Icons.people,
                        OnChanged: (value) {
                          name = value;
                        },
                        typePassword: false),
                    WidgetTextfield(
                        hintText: "Entrer votre adresse",
                        icon: Icons.place,
                        OnChanged: (value) {
                          adresse = value;
                        },
                        typePassword: false),
                    WidgetTextfield(
                        hintText: "Entrer votre ville",
                        icon: Icons.place,
                        OnChanged: (value) {
                          ville = value;
                        },
                        typePassword: false),
                    WidgetDatetime(
                      colorGradOne: Color(0xFFFFFFFF),
                      colorGradTwo: Color(0xFFFFFFFF),
                      text: "Date de naissance",
                      OnPressed: () async {
                        date = await showRoundedDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 80),
                          lastDate: DateTime.now(),
                          borderRadius: 2,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 10, bottom: 10),
                      child: Text(
                        "Pour quelle motif ?",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 19),
                      ),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      width: 340,
                      height: 50,
                      child: DirectSelect(
                          itemExtent: 75.0,
                          selectedIndex: selectedIndex1,
                          child: MySelectionItem(
                            isForList: true,
                            title: listMotifs[selectedIndex1],
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedIndex1 = index;
                              motif = listMotifs[index];
                            });
                          },
                          items: _buildItems1()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 10, bottom: 10),
                      child: Text("Signature",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 19)),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        width: 400,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Signature(
                            color: Colors.black,
                            key: _sign,
                            onSign: () {
                              final sign = _sign.currentState;
                              debugPrint(
                                  '${sign.points.length} points in the signature');
                            },
                            backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                            strokeWidth: strokeWidth,
                          ),
                        ),
                      ),
                    ),
                    Container(),
                    WidgetButton(
                      colorGradOne: Color(0xFF50BEE4),
                      colorGradTwo: Color(0xFFAB3A85),
                      text: "Générer l'attestation",
                      OnPressed: () async {
                        final sign = _sign.currentState;
                        //retrieve image data, do whatever you want with it (send to server, save locally...)
                        final image = await sign.getData();
                        var data = await image.toByteData(
                            format: ui.ImageByteFormat.rawRgba);
                        sign.clear();
                        final encoded =
                            base64.encode(data.buffer.asUint8List());
                        setState(() {
                          _img = data;
                        });
                        debugPrint("onPressed " + encoded);
                        print(date);
                        var dateFormated = date.day.toString() +
                            "/" +
                            date.month.toString() +
                            "/" +
                            date.year.toString();
                        print(adresse.toString());
                        print(name);
                        print(motif);

                        final pdf = pw.Document();
                        final imageX = PdfImage(
                          pdf.document,
                          image: _img.buffer.asUint8List(),
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
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: <pw.Widget>[
                                        pw.Text(
                                          'ATTESTATION DE DÉPLACEMENT DÉROGATOIRE',
                                          textScaleFactor: 1.6,
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            decoration:
                                                pw.TextDecoration.underline,
                                          ),
                                        ),
                                        pw.SizedBox(height: 20),
                                        pw.Text(
                                            'En application de l\'article 1er du décret du 16 mars 2020 portant réglementation des déplacements dans le cadre de la lutte contre la propagation du virus Covid-19',
                                            textScaleFactor: 0.9),
                                        pw.SizedBox(height: 60),
                                        pw.Text('Je soussigné(e) ' + name,
                                            textScaleFactor: 2.4),
                                        pw.Text('né(e) le ' + dateFormated,
                                            textScaleFactor: 2.4),
                                        pw.Text('demeurant au ' + adresse,
                                            textScaleFactor: 2.4),
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
                                          DateTime.now().day.toString() +
                                          "/" +
                                          DateTime.now().month.toString() +
                                          "/" +
                                          DateTime.now().year.toString() +
                                          ' a ' +
                                          ville,
                                      textScaleFactor: 1.2),
                                  pw.Image(imageX),
                                ],
                              ); // Center
                            }));

                        final String dir =
                            (await getApplicationDocumentsDirectory()).path;
                        final String path = '$dir/report.pdf';
                        final File file = File(path);
                        await file.writeAsBytes(pdf.save());
                        material.Navigator.of(context).push(
                          material.MaterialPageRoute(
                            builder: (_) => PdfViewerPage(path: path),
                          ),
                        );
                        reportView(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}