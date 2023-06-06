import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/admin/admin_navbar.dart';
import 'package:pakar_hati/admin/admin_tambah_gejalaadmin.dart';
import 'package:pakar_hati/admin/admin_tambah_gejala.dart';
import 'package:pakar_hati/models/model_pakar.dart';
import 'package:pakar_hati/theme/color.dart';

class AdminGejala extends StatefulWidget {
  const AdminGejala({super.key, this.gejala});
  final Gejala? gejala;

  @override
  State<AdminGejala> createState() => _AdminGejalaState();
}

class _AdminGejalaState extends State<AdminGejala> {
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
                  return const AdminNavBar();
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
          actions: [
            IconButton(
              icon: const Icon(FontAwesome.plus),
              tooltip: 'Tambah gejala',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const AddGejala();
                  },
                ));
              },
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream:
              firestore.collection('gejala').orderBy('namaGejala').snapshots(),
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
                        child: Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                onPressed: (context) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: const Text(
                                              'Peringatan!!',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Text(
                                                'Anda yakin akan menghapus Gejala (${gejala[index].namaGejala}) ??'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Batal'),
                                                child: const Text('Batal'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await firestore
                                                      .collection('gejala')
                                                      .doc(id)
                                                      .delete();
                                                  Navigator.pop(context, 'Ya');
                                                },
                                                child: const Text('Ya'),
                                              ),
                                            ],
                                          ));
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: backgroundColor,
                                icon: BoxIcons.bxs_trash,
                                label: 'Delete',
                              ),
                              // SlidableAction(
                              //   onPressed: (context) {
                              //     Navigator.push(context, MaterialPageRoute(
                              //       builder: (context) {
                              //         return GejalaHati(
                              //           gejala: gejala[index],
                              //           id: id,
                              //         );
                              //       },
                              //     ));
                              //   },
                              //   backgroundColor: thirdColor,
                              //   foregroundColor: backgroundColor,
                              //   icon: BoxIcons.bxs_pencil,
                              //   label: 'Edit',
                              // ),
                            ],
                          ),
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
