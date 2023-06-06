// import 'package:flutter/material.dart';
// import 'package:pakar_hati/models/model.dart';

// class GejalaScreen extends StatefulWidget {
//   const GejalaScreen({Key? key}) : super(key: key);

//   @override
//   _GejalaScreenState createState() => _GejalaScreenState();
// }

// class _GejalaScreenState extends State<GejalaScreen> {
//   final DiagnosaHati _diagnosaHati = DiagnosaHati(
//     gejala: [],
//     penyakit: [],
//   );

//   List<GejalaHati> _gejalaList = [];

//   @override
//   void initState() {
//     super.initState();
//     _gejalaList = _diagnosaHati.getAllGejala();
//   }

//   void _hitungCf() {
//     List<PenyakitCf> hasil = _diagnosaHati.getPenyakitSortedByCf();

//     // Tampilkan hasil di layar menggunakan AlertDialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Hasil Diagnosa'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: hasil.map((p) {
//               return Text('${p.namaPenyakit}: ${p.penyakitCf}');
//             }).toList(),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gejala'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _gejalaList.length,
//               itemBuilder: (context, index) {
//                 return CheckboxListTile(
//                   title: Text(_gejalaList[index].namaGejala),
//                   value: _gejalaList[index].isSelected,
//                   onChanged: (value) {
//                     setState(() {
//                       _gejalaList[index].isSelected = value!;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _hitungCf,
//             child: Text('Hitung CF'),
//           ),
//         ],
//       ),
//     );
//   }
// }
