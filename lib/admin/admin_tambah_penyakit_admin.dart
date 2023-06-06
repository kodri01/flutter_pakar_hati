// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:pakar_hati/models/model.dart';

// class TambahPenyakit extends StatefulWidget {
//   const TambahPenyakit({Key? key}) : super(key: key);

//   @override
//   _TambahPenyakitState createState() => _TambahPenyakitState();
// }

// class _TambahPenyakitState extends State<TambahPenyakit> {
//   final _formKey = GlobalKey<FormState>();
//   final _namaController = TextEditingController();
//   final _cfController = TextEditingController();
//   final List<String> _selectedGejala = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Tambah Penyakit'),
//         ),
//         body: Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 TextFormField(
//                   controller: _namaController,
//                   decoration: InputDecoration(
//                     labelText: 'Nama Penyakit',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Nama Penyakit harus diisi';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _cfController,
//                   decoration: InputDecoration(
//                     labelText: 'Tingkat Kepastian',
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Tingkat Kepastian harus diisi';
//                     }
//                     if (double.tryParse(value) == null) {
//                       return 'Tingkat Kepastian harus berupa angka';
//                     }
//                     if (double.parse(value) < 0 || double.parse(value) > 1) {
//                       return 'Tingkat Kepastian harus berada di antara 0 dan 1';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 const Text('Gejala'),
//                 StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                   stream: FirebaseFirestore.instance
//                       .collection('gejala_hati')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     List<GejalaHati> gejalaList = snapshot.data!.docs
//                         .map((gejala) => GejalaHati.fromFirestore(gejala))
//                         .toList();
//                     return Wrap(
//                       children: gejalaList.map((gejala) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: FilterChip(
//                             label: Text(gejala.namaGejala),
//                             selected:
//                                 _selectedGejala.contains(gejala.namaGejala),
//                             onSelected: (bool selected) {
//                               setState(() {
//                                 if (selected) {
//                                   _selectedGejala.add(gejala.namaGejala);
//                                 } else {
//                                   _selectedGejala.remove(gejala.namaGejala);
//                                 }
//                               });
//                             },
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       List<GejalaHati> selectedGejala = [];
//                       for (String nama in _selectedGejala) {
//                         var snapshot = await FirebaseFirestore.instance
//                             .collection('gejala_hati')
//                             .where('namaGejala', isEqualTo: nama)
//                             .limit(1)
//                             .get();
//                         if (snapshot.size > 0) {
//                           selectedGejala
//                               .add(GejalaHati.fromFirestore(snapshot.docs[0]));
//                         }
//                       }
//                       PenyakitHati penyakit = PenyakitHati(
//                         namaPenyakit: _namaController.text,
//                         gejala: selectedGejala,
//                         penyakitCf: double.parse(_cfController.text),
//                       );
//                       await FirebaseFirestore.instance
//                           .collection('penyakit_hati')
//                           .add(penyakit.toJson());

//                       Navigator.pop(context);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Penyakit berhasil ditambahkan'),
//                         ),
//                       );
//                     }
//                   },
//                   child: const Text('Tambah Penyakit'),
//                 ),
//               ],
//             )));
//   }
// }
