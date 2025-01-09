import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_admin/const/default.dart';

class Addscheduledialogue extends StatefulWidget {
  const Addscheduledialogue({super.key});

  @override
  State<Addscheduledialogue> createState() => _AddscheduledialogueState();
}

class _AddscheduledialogueState extends State<Addscheduledialogue> {
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController jamController = TextEditingController();
  final TextEditingController tempatController = TextEditingController();

  String? _selectedLokasiId;
  List<Map<String, dynamic>> _lokasis = [];

  Future<void> _fetchLokasi() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('lokasi').get();

    setState(() {
      _lokasis = snapshot.docs.map((doc) {
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

  void addJadwal() async {
    if (_selectedLokasiId != null) {
      DocumentSnapshot lokasiDoc = await FirebaseFirestore.instance
          .collection('lokasi')
          .doc(_selectedLokasiId)
          .get();

      if (lokasiDoc.exists) {
        String tempat = lokasiDoc['tempat'];

        await FirebaseFirestore.instance.collection('jadwal').add({
          'semester': semesterController.text,
          'kelas': kelasController.text,
          'jam': jamController.text,
          'tempat': tempat
        });
      }
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _fetchLokasi();
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
                'Add Schedule',
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
                height: MediaQuery.sizeOf(context).height * 0.05,
                child: TextField(
                  controller: semesterController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Semester',
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
                height: MediaQuery.sizeOf(context).height * 0.05,
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
                height: MediaQuery.sizeOf(context).height * 0.05,
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
                  height: MediaQuery.sizeOf(context).height * 0.05,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton(
                      underline: SizedBox(),
                      dropdownColor: secondaryColor,
                      hint: Text(
                        'Pilih Lokasi',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      value: _selectedLokasiId,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLokasiId = newValue;
                        });
                      },
                      items: _lokasis.map((lokasi) {
                        return DropdownMenuItem<String>(
                            value: lokasi['id'],
                            child: Text(
                              lokasi['tempat'],
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ));
                      }).toList(),
                    ),
                  )
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
                      addJadwal();
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
