import 'dart:io';

import 'package:confinement/models/BrainAttestation.dart';
import 'package:confinement/models/WatermarkPaint.dart';
import 'package:confinement/screens/pdfWiewerScreen.dart';
import 'package:confinement/widgets/WidgetButton.dart';
import 'package:confinement/widgets/WidgetDatetime.dart';
import 'package:confinement/widgets/WidgetTextfield.dart';
import 'package:flutter/material.dart';

import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter/material.dart' as material;

class attestationScreen extends StatefulWidget {
  @override
  _attestationScreenState createState() => _attestationScreenState();
}

enum Sexe { Homme, Femme }

class _attestationScreenState extends State<attestationScreen> {
  brain brainA = new brain();
  TextEditingController controllerName, controllerVille, controllerAdresse;
  var dateFormated = "";
  var signature;
  var adresse = "";
  var motif = "Achats de première nécessité";
  var ville = "";
  var name = "";
  bool sexe = true;
  DateTime date;

  List<String> listMotifs = [
    "Achats de première nécessité",
    "Travail",
    "Hopital",
    "Famille agée",
    "Exercice physique",
  ];

  String selectedIndex;

  ByteData img = ByteData(0);
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();
  var monthNowFormated, dayNowFormated;
  var yearNow = DateTime.now().year;
  restore() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    setState(() {
      print(sharedPrefs.getString('adresse'));
      name = (sharedPrefs.getString('name'));

      dateFormated = (sharedPrefs.getString('date'));
      adresse = (sharedPrefs.getString('adresse'));
      ville = (sharedPrefs.getString('ville'));
      motif = (sharedPrefs.getString('motif'));
      sexe = (sharedPrefs.getBool('sexe') ?? true);
      if (sexe) {
        print(sexe);
        _defaultSexe = Sexe.Homme;
      } else {
        _defaultSexe = Sexe.Femme;
      }
      controllerName = TextEditingController(text: name);
      controllerVille = TextEditingController(text: ville);
      controllerAdresse = TextEditingController(text: adresse);

      //TODO: More restoring of settings would go here...
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    restore();
  }

  Sexe _defaultSexe = Sexe.Homme;

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
                        controller: controllerName,
                        hintText: "Entrer votre nom",
                        icon: Icons.people,
                        OnChanged: (value) {
                          setState(() {
                            name = value;
                          });
                          brain.save('name', value);
                        },
                        typePassword: false),
                    WidgetTextfield(
                        controller: controllerAdresse,
                        hintText: "Entrer votre adresse",
                        icon: Icons.place,
                        OnChanged: (value) {
                          setState(() {
                            adresse = value;
                          });
                          brain.save('adresse', value);
                        },
                        typePassword: false),
                    WidgetTextfield(
                        controller: controllerVille,
                        hintText: "Entrer votre ville",
                        icon: Icons.place,
                        OnChanged: (value) {
                          setState(() {
                            ville = value;
                          });
                          brain.save('ville', value);
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
                    Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      width: 340,
                      height: 50,
                      child: Center(
                        child: DropdownButton(
                          hint: Text('Pour quelle motif ?',
                              style: TextStyle(
                                color: Colors.black,
                              )), // Not necessary for Option 1
                          value: motif,
                          onChanged: (newValue) {
                            setState(() {
                              motif = newValue;
                            });
                            brain.save('motif', newValue);
                          },
                          items: listMotifs.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: ListTile(
                              title: const Text('Homme'),
                              leading: Radio(
                                value: Sexe.Homme,
                                groupValue: _defaultSexe,
                                onChanged: (Sexe value) {
                                  setState(() {
                                    _defaultSexe = value;
                                    sexe = true;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: const Text('Femme'),
                              leading: Radio(
                                value: Sexe.Femme,
                                groupValue: _defaultSexe,
                                onChanged: (Sexe value) {
                                  setState(() {
                                    _defaultSexe = value;
                                    sexe = false;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 2, bottom: 10),
                      child: Text("Signature",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 19)),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Signature(
                            color: Colors.black,
                            key: _sign,
                            onSign: () {
                              final sign = _sign.currentState;
                            },
                            backgroundPainter: WatermarkPaint("2.0", "2.0"),
                            strokeWidth: strokeWidth,
                          ),
                        ),
                      ),
                    ),
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
                          img = data;
                        });

                        dateFormated = brain.formatedDate(date, dateFormated);

                        brain.save('date', dateFormated.toString());
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('sexe', sexe);
                        monthNowFormated =
                            brain.formatedDateNow(DateTime.now().month);
                        dayNowFormated =
                            brain.formatedDateNow(DateTime.now().day);
                        print('sexe ::::' + sexe.toString());
                        print('default ::::' + _defaultSexe.toString());

                        var path = await brain.pdf(
                            img,
                            image,
                            name,
                            dateFormated,
                            adresse,
                            motif,
                            dayNowFormated,
                            monthNowFormated,
                            yearNow,
                            ville,
                            sexe);
                        print(path.Bytes);

                        material.Navigator.of(context).push(
                          material.MaterialPageRoute(
                            builder: (_) => PdfViewerPage(
                              path: path.path,
                              Bytes: path.Bytes,
                            ),
                          ),
                        );
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
