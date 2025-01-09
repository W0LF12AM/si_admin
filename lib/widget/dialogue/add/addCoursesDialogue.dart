import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_admin/const/default.dart';

class Addcoursesdialogue extends StatefulWidget {
  const Addcoursesdialogue({super.key});

  @override
  State<Addcoursesdialogue> createState() => _AddcoursesdialogueState();
}

class _AddcoursesdialogueState extends State<Addcoursesdialogue> {
  final TextEditingController pertemuanController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController jamController = TextEditingController();
  final TextEditingController tempatController = TextEditingController();

  String? _selectedLocationId;
  List<Map<String, dynamic>> _locations = [];

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('lokasi').get();
    setState(() {
      _locations = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'tempat': doc['tempat'],
          'longitude': doc['longitude'],
          'latitude': doc['latitude'],
          'radius': doc['radius'],
        };
      }).toList();
    });
  }

  Future<void> _addClass() async {
    // String className = kelasController.text;

    if (_selectedLocationId != null) {
      try {
        DocumentSnapshot lokasiDoc = await FirebaseFirestore.instance
            .collection('lokasi')
            .doc(_selectedLocationId)
            .get();

        if (lokasiDoc.exists) {
          double longitude = lokasiDoc['longitude'];
          double latitude = lokasiDoc['latitude'];
          double radius = lokasiDoc['radius'];
          String tempat = lokasiDoc['tempat'];

          await FirebaseFirestore.instance.collection('kelas').add({
            'pertemuan': pertemuanController.text,
            'kelas': kelasController.text,
            'jam': jamController.text,
            'tempat': tempat,
            'longitude': longitude,
            'latitude': latitude,
            'radius': radius,
          });

          print('Nama Tempat: $tempat');
        } else {
          print('Dokumen lokasi tidak ditemukan');
        }
      } catch (e) {
        print('Error: $e');
      }
      pertemuanController.clear();
      kelasController.clear();
      jamController.clear();
      _selectedLocationId = null;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Tolong pilih lokasi')));
    }
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
                'Add Course',
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
                  controller: pertemuanController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Pertemuan',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  onChanged: (value) {},
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
                  controller: kelasController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Kelas',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  onChanged: (value) {},
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
                  controller: jamController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Jam',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  onChanged: (value) {},
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
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    dropdownColor: secondaryColor,
                    hint: Text(
                      'Pilih Lokasi',
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    value: _selectedLocationId,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocationId =
                            newValue; // Simpan ID lokasi yang dipilih
                      });
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem<String>(
                        value: location['id'],
                        child: Text(
                          location['tempat'],
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    }).toList(),
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
                    onTap: () async {
                      _addClass();
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
