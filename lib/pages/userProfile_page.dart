import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/card/userProfileCard.dart';
import 'package:si_admin/widget/header/customHeader.dart';

class UserprofilePage extends StatefulWidget {
  const UserprofilePage({super.key});

  @override
  State<UserprofilePage> createState() => _UserprofilePageState();
}

class _UserprofilePageState extends State<UserprofilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> users = [];
  String queryPencarian = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();
    setState(() {
      users = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredUsers = users.where((user) {
      return user['name']
              .toLowerCase()
              .contains(queryPencarian.toLowerCase()) ||
          user['npm'].toLowerCase().contains(queryPencarian.toLowerCase()) ||
          user['class'].toLowerCase().contains(queryPencarian.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Customheader(
                title: 'Users Profile',
                pencarian: (query) {
                  setState(() {
                    queryPencarian = query;
                  });
                },
              ),
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
                          'Nama',
                          style: coursesStyle,
                        ),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Npm', style: coursesStyle),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Kelas', style: coursesStyle),
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
                    children: filteredUsers.map((user) {
                  return Userprofilecard(
                      nama: user['name'] ?? 'No Name',
                      npm: user['npm'] ?? 'No NPM',
                      kelas: user['class'] ?? 'No Classes');
                }).toList()),
              ))
            ],
          ))
        ],
      ),
    );
  }
}
