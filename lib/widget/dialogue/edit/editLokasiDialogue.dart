import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_admin/const/default.dart';

class Editlokasidialogue extends StatefulWidget {
  const Editlokasidialogue({super.key, required this.documentId});

  final String documentId;

  @override
  State<Editlokasidialogue> createState() => _EditlokasidialogueState();
}

class _EditlokasidialogueState extends State<Editlokasidialogue> {
  final TextEditingController tempatController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();

  Future<void> _loadLokasi() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('lokasi')
        .doc(widget.documentId)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();
      setState(() {
        tempatController.text = data?['tempat'] ?? '';
        longitudeController.text = data?['longitude'].toString() ?? '';
        latitudeController.text = data?['latitude'].toString() ?? '';
        radiusController.text = data?['radius'].toString() ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLokasi();
  }

  Future<void> _editLokasi() async {
    await FirebaseFirestore.instance
        .collection('lokasi')
        .doc(widget.documentId)
        .update({
      'tempat': tempatController.text,
      'longitude': double.tryParse(longitudeController.text) ?? 0.0,
      'latitude': double.tryParse(latitudeController.text) ?? 0.0,
      'radius': double.tryParse(radiusController.text) ?? 0.0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: secondaryColor,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.45,
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Lokasi',
                style: GoogleFonts.roboto(
                    color: mainColor,
                    fontSize: MediaQuery.sizeOf(context).width * 0.017,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.sizeOf(context).width * 0.35),
                child: Divider(
                  color: mainColor,
                  thickness: 3,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  controller: tempatController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tempat',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.015,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  controller: longitudeController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Longitude',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.015,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  controller: latitudeController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Latitude',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.015,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  controller: radiusController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Radius',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.048,
                      height: MediaQuery.sizeOf(context).height * 0.048,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width * 0.006),
                        child: SvgPicture.asset(
                          'assets/cancel icon.svg',
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.005,
                  ),
                  GestureDetector(
                    onTap: () {
                      _editLokasi();
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.048,
                      height: MediaQuery.sizeOf(context).height * 0.048,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.check,
                        color: secondaryColor,
                        size: MediaQuery.sizeOf(context).width * 0.02,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
