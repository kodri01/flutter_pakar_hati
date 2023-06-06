import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pakar_hati/admin/admin_aturan.dart';
import 'package:pakar_hati/models/model_pakar.dart';
import 'package:pakar_hati/providers/firestore_service.dart';
import 'package:pakar_hati/theme/color.dart';

class TambahAturan extends StatefulWidget {
  const TambahAturan({Key? key}) : super(key: key);

  @override
  _TambahAturanState createState() => _TambahAturanState();
}

class _TambahAturanState extends State<TambahAturan> {
  String selectedGejala = '';
  String selectedPenyakit = '';

  final _formKey = GlobalKey<FormState>();
  late String id;
  late String? idGejala = '';
  late String? idPenyakit = '';
  late double bobot;
  List<String> _daftarGejala = [];
  List<String> _daftarPenyakit = [];

  @override
  void initState() {
    super.initState();
    _ambilDaftarGejala();
    _ambilDaftarPenyakit();
  }

  Future<void> _ambilDaftarGejala() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('gejala').get();
    List<String> daftarGejala = [];
    snapshot.docs.forEach((doc) {
      daftarGejala.add(doc.id);
    });
    setState(() {
      _daftarGejala = daftarGejala;
    });
  }

  Future<void> _ambilDaftarPenyakit() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('penyakit').get();
    List<String> daftarPenyakit = [];
    snapshot.docs.forEach((doc) {
      daftarPenyakit.add(doc.id);
    });
    setState(() {
      _daftarPenyakit = daftarPenyakit;
    });
  }

  Future<String> _getPenyakitName(String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('penyakit').doc(id).get();
    return snapshot.get('namaPenyakit');
  }

  Future<String> _getGejalaName(String id) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('gejala').doc(id).get();
    return snapshot.get('namaGejala');
  }

  @override
  Widget build(BuildContext context) {
    var gejalaRef = FirebaseFirestore.instance.collection('gejala');
    var penyakitRef = FirebaseFirestore.instance.collection('penyakit');

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          iconTheme: const IconThemeData(color: secondaryTextColor),
          automaticallyImplyLeading: true,
          title: const Text(
            'Aturan Sistem',
            style: TextStyle(
                fontFamily: 'Poppins', color: secondaryTextColor, fontSize: 22),
          ),
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Generate unique ID for the new document
                  String newId =
                      FirebaseFirestore.instance.collection('aturan').doc().id;

                  // Save the new data to Firestore
                  await FirebaseFirestore.instance
                      .collection('aturan')
                      .doc(newId)
                      .set({
                    'gejalaId': selectedGejala,
                    'penyakitId': selectedPenyakit,
                    'bobot': bobot,
                  });

                  String gejalaName = await _getGejalaName(selectedGejala);
                  String penyakitName =
                      await _getPenyakitName(selectedPenyakit);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Success !!',
                          style: TextStyle(
                            color: Colors.green,
                          )),
                      content: Text(
                        'Aturan baru berhasil diperbarui!\n'
                        'Penyakit: $penyakitName\n'
                        'Gejala: $gejalaName',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AdminAturan(),
                                ),
                              );
                            },
                            child: Text('Oke'))
                      ],
                    ),
                  );
                }
              },
              child: const Icon(BoxIcons.bx_check),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: penyakitRef.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const CircularProgressIndicator();

                    var penyakitItems = snapshot.data!.docs
                        .map((doc) => DropdownMenuItem(
                              value: doc.id,
                              child: Text(doc.id),
                            ))
                        .toList();

                    return DropdownButtonFormField(
                      items: penyakitItems,
                      onChanged: (value) {
                        setState(() {
                          selectedPenyakit = value.toString();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Pilih penyakit',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                StreamBuilder<QuerySnapshot>(
                  stream: gejalaRef.snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const CircularProgressIndicator();

                    var gejalaItems = snapshot.data!.docs
                        .map((doc) => DropdownMenuItem(
                              value: doc.id,
                              child: Text(doc.id),
                            ))
                        .toList();

                    return DropdownButtonFormField(
                      items: gejalaItems,
                      onChanged: (value) {
                        setState(() {
                          selectedGejala = value.toString();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Pilih gejala',
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bobot harus diisi';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Bobot harus berupa angka';
                    }
                    if (double.parse(value) < 0 || double.parse(value) > 1) {
                      return 'Bobot harus berada di antara 0 dan 1';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      bobot = double.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Masukan Nilai Bobot',
                    hintText: 'Contoh: 0.8',
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
