import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_admin/const/default.dart';

class DeleteConfirmationDialogue extends StatelessWidget {
  DeleteConfirmationDialogue({super.key, required this.delete});

  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 600,
        height: 300,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 500,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondaryColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.sizeOf(context).height * 0.025),
                  child: Column(
                    children: [
                      Text(
                        'Hapus Data',
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: mainColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.sizeOf(context).width * 0.05),
                        child: Divider(
                          thickness: 4,
                          color: mainColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Apakah kamu yakin ingin \nmenghapus data ini ?',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              delete();
                            },
                            child: Container(
                              width: 120,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: mainColor, width: 3)),
                              child: Center(
                                child: Text('Hapus',
                                    style: confrirmDeletDialogeStyle),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.005,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 120,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text('Batal',
                                    style: cancelDeleteDialogueStyle),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 5,
                left: 25,
                child: Container(
                  decoration: BoxDecoration(
                      color: secondaryColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.cancel,
                    size: 60,
                  ),
                )
                // SvgPicture.asset(
                //   'assets/cancel dialog icon.svg',
                //   width: 60,
                //   height: 60,
                //)
                )
          ],
        ),
      ),

      // widget.deleteEntity;
    );
  }
}
