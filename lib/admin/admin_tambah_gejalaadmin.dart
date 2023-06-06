import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddGejala extends StatefulWidget {
  const AddGejala({Key? key}) : super(key: key);

  @override
  _AddGejalaState createState() => _AddGejalaState();
}

class _AddGejalaState extends State<AddGejala> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaGejalaController = TextEditingController();
  final TextEditingController _gejalaCfController = TextEditingController();

  @override
  void dispose() {
    _namaGejalaController.dispose();
    _gejalaCfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Gejala'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaGejalaController,
                decoration: InputDecoration(labelText: 'Nama Gejala'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Gejala harus diisi';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gejalaCfController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Gejala CF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Gejala CF harus diisi';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Gejala CF harus berupa angka';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Simpan data ke Firestore
                    await FirebaseFirestore.instance
                        .collection('gejala_hati')
                        .add({
                      'namaGejala': _namaGejalaController.text,
                      'gejalaCf': double.parse(_gejalaCfController.text),
                    });
                    // Kembali ke halaman sebelumnya
                    Navigator.pop(context);
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
