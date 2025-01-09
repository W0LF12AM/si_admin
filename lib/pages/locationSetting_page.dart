import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/card/locationCard.dart';

import 'package:si_admin/widget/dialogue/add/addLocationDialogue.dart';


import 'package:si_admin/widget/header/customHeaderWithoutSearch.dart';

class LocationsettingPage extends StatelessWidget {
  const LocationsettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Customheaderwithoutsearch(title: 'Location'),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                child: Container(
                  width: double.maxFinite,
                  height: MediaQuery.sizeOf(context).height * 0.06,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: Text(
                          'Tempat',
                          style: coursesStyle,
                        ),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Longitude', style: coursesStyle),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Latitude', style: coursesStyle),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Radius (m)', style: coursesStyle),
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('lokasi')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error : ${snapshot.error}'),
                            );
                          }
                          final locations = snapshot.data!.docs;

                          return Column(
                              children: locations.map((locationDoc) {
                            return Locationcard(
                                lokasiId: locationDoc.id,
                                tempat: locationDoc['tempat'],
                                longitude: locationDoc['longitude'].toString(),
                                latitude: locationDoc['latitude'].toString(),
                                radius: locationDoc['radius'].toString());
                          }).toList());
                        })
                  ],
                ),
              ))
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Addlocationdialogue();
              });
        },
        child: Icon(
          Icons.add,
          color: secondaryColor,
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
