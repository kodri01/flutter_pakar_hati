import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/models/model_pakar.dart';
import 'package:pakar_hati/pages/navbar.dart';
import 'package:pakar_hati/theme/color.dart';

class PageGejala extends StatefulWidget {
  const PageGejala({super.key, this.gejala});
  final Gejala? gejala;

  @override
  State<PageGejala> createState() => _PageGejalaState();
}

class _PageGejalaState extends State<PageGejala> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const NavBar();
                },
              ));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: backgroundColor,
          iconTheme: const IconThemeData(color: secondaryTextColor),
          title: const Text(
            "Daftar Gejala",
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 22, color: secondaryTextColor),
          ),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('gejala')
              .orderBy('namaGejala', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var gejala = snapshot.data!.docs
                  .map((gejala) => Gejala.fromFirestore(gejala))
                  .toList();

              return ListView.builder(
                itemCount: gejala.length,
                itemBuilder: (context, index) {
                  var id = snapshot.data!.docs[index].id;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: shadowColor,
                                  offset: Offset(0, 5),
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: ListTile(
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return AdminDetailPenyakit(
                                  //       penyakit: penyakit[index],
                                  //       id: id,
                                  //     );
                                  //   },
                                  // ));
                                },
                                leading: const Icon(
                                  BoxIcons.bxs_heart,
                                  color: primaryTextColor,
                                  size: 35,
                                ),
                                title: Text(
                                  gejala[index].namaGejala,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: primaryTextColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  BoxIcons.bx_right_arrow,
                                  color: primaryTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
