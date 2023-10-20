import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserServices {
//obter instancia do firebase auth
  late String idParaImagem;
  Uint8List webImage = Uint8List(8);
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Adotante cadAdotante = Adotante();
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference get _collectionRef => _firestore.collection('adotante');

// registrar o usuario no firebase
  Future<bool> signUp(String email, String senha, nome, cpf, endereco,
      dtNascimento, telefone, renda, tipoMoradia) async {
    try {
      User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: senha))
          .user;

      cadAdotante.id = user!.uid;
      cadAdotante.nome = nome;
      cadAdotante.cpf = cpf;
      cadAdotante.endereco = endereco;
      cadAdotante.dtNascimento = dtNascimento;
      cadAdotante.telefone = telefone;
      cadAdotante.renda = renda;
      cadAdotante.tipoMoradia = tipoMoradia;
      cadAdotante.email = email;
      cadAdotante.senha = senha;
      //cadAdotante.image = "";

      await saveUser(user.uid);
      //await uploadImageToFirebase(context);
      //teste de imagem firebase
      uploadImageToFirebase(adotante: cadAdotante, imageFile: webImage);

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        debugPrint('email inválido');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('já existe cadastro com esse e-mail');
      } else {
        debugPrint(e.code);
      }
      return false;
    }
  }

  Future<void> saveUser(String id) async {
    try {
      String id = FirebaseAuth.instance.currentUser!.uid;
      final userDocRef = _firestore.collection('adotante').doc(id);

      if (!(await userDocRef.get()).exists) {
        // A coleção não existe, crie-a e insira os dados
        await userDocRef.set(cadAdotante.toJson());
      } else {
        // A coleção já existe, atualize os dados conforme necessário
        await userDocRef.update(cadAdotante.toJson());
      }

      print('Dados salvos com sucesso.');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      (await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password));

      String uuid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snapshot =
          await _firestore.collection('adotante').doc(uuid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        String aprovado = data['aprovado'];
        if (aprovado == "aprovado") {
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      } else {
        return Future.value(true);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        debugPrint('email inválido');
      } else if (e.code == 'user-not-found') {
        debugPrint('usuário não cadastrado');
      } else {
        debugPrint('erro de plataforma');
      }
      return false;
    }
  }

  Future<void> pickAndUploadImage() async {
    Image.memory(webImage);
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var imageSelected = await image.readAsBytes();
      webImage = imageSelected as Uint8List;
    } else {
      debugPrint('Nenhuma imagem selecionada.');
    }
  }

  Future<bool> uploadImageToFirebase({Adotante? adotante, imageFile}) async {
    try {
      final userDocRef = _firestore.collection('adotante').doc();
      String uuid = FirebaseAuth.instance.currentUser!.uid;
      Reference ref = storage.ref().child('adotante').child(userDocRef.id);
      UploadTask task = ref.putData(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpg',
        ),
      );
      String url = await (await task.whenComplete(() {})).ref.getDownloadURL();
      // DocumentReference docRef = _collectionRef.doc(userDocRef.id);
      await _collectionRef.doc(uuid).update({'image': url});
      print('Dados salvos com sucesso.');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }

    return Future.value(true);
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                // Fechar o diálogo quando o botão "OK" for pressionado
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucesso'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                // Fechar o diálogo quando o botão "OK" for pressionado
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> isAprovado() async {
    return Future.value(true);
  }

  //-------------------a patir daqui é o código para aprovar cadastro-------------------

  Stream<QuerySnapshot> getAllAdotante() {
    return _collectionRef.snapshots();
  }

  Future aprovarAdotante(id) async {
    //String uuid = FirebaseAuth.instance.currentUser!.uid;
    //String idAdotante = id;
    String aprovado = "aprovado";
    await _collectionRef.doc(id).update({'aprovado': aprovado});
  }

  Future reprovarAdotante(id) async {
    //String uuid = FirebaseAuth.instance.currentUser!.uid;
    //String idAdotante = id;
    String reprovado = "reprovado";
    await _collectionRef.doc(id).update({'aprovado': reprovado});
  }
}
