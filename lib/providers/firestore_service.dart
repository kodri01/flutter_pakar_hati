import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pakar_hati/models/model_pakar.dart';
// import 'package:pakar_hati/models/model_pakar.dart';
import 'package:pakar_hati/providers/database_service.dart';
// import 'package:console_menu/console_menu.dart';

class FirestoreService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //login

  Future loginWhitEmailPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register
  Future registerWhitEmailPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatabaseService(uid: user.uid).saveUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Login with Google

  Future loginwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      User user = (await firebaseAuth.signInWithCredential(credential)).user!;
      if (user != null) {
        await DatabaseService(uid: user.uid).saveUserGoogle(user);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await firebaseAuth.signOut();
  }
}

class SistemPakar {
  //Function untuk Gejala
  Future<void> addGejala(Gejala gejala) async {
    String id =
        'G${(await FirebaseFirestore.instance.collection('gejala').get()).docs.length.toString().padLeft(3, '0')}';
    gejala.id = id;
    await FirebaseFirestore.instance
        .collection('gejala')
        .doc(id)
        .set(gejala.toJson());
  }

  Future<List<Gejala>> getGejala() async {
    List<Gejala> gejalaList = [];

    // get collection reference
    var collection = FirebaseFirestore.instance.collection('gejala');

    // listen for real-time updates
    await collection.snapshots().forEach((snapshot) {
      snapshot.docs.forEach((doc) {
        Gejala gejala = Gejala.fromFirestore(doc);
        gejala.id = doc.id;
        gejalaList.add(gejala);
      });
    });

    return gejalaList;
  }

  Future<void> editGejala(Gejala gejala, String id) async {
    await FirebaseFirestore.instance
        .collection('gejala')
        .doc(id)
        .update(gejala.toJson());
  }

//Function untuk Penyakit
  Future<void> addPenyakit(Penyakit penyakit) async {
    String id =
        'P${(await FirebaseFirestore.instance.collection('penyakit').get()).docs.length.toString().padLeft(3, '0')}';
    penyakit.id = id;
    await FirebaseFirestore.instance
        .collection('penyakit')
        .doc(id)
        .set(penyakit.toJson());
  }

  Future<List<Penyakit>> getPenyakit() async {
    List<Penyakit> penyakitList = [];

    // get collection reference
    var collection = FirebaseFirestore.instance.collection('penyakit');

    // get documents from collection
    var documents = await collection.get();

    // convert documents to penyakitList
    documents.docs.forEach((doc) {
      Penyakit penyakit = Penyakit.fromFirestore(doc);
      penyakit.id = doc.id;
      penyakitList.add(penyakit);
    });

    return penyakitList;
  }

  Future<void> editPenyakit(Penyakit penyakit, String id) async {
    await FirebaseFirestore.instance
        .collection('penyakit')
        .doc(id)
        .update(penyakit.toJson());
  }

//Function untuk Aturan
  Future<void> addAturan(Aturan aturan) async {
    await FirebaseFirestore.instance.collection('aturan').add(aturan.toJson());
  }

  //get Aturan lis

  Future<List<Aturan>> getAturan() async {
    List<Aturan> aturanList = [];

    // get collection reference
    var collection = FirebaseFirestore.instance.collection('aturan');

    // get documents from collection
    var documents = await collection.get();

    // convert documents to penyakitList
    documents.docs.forEach((doc) {
      Aturan aturan = Aturan.fromFirestore(doc);
      aturan.id = doc.id;
      aturanList.add(aturan);
    });

    return aturanList;
  }
}
