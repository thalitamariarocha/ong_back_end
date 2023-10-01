import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usuarios/voluntario.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VoluntarioServices {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Voluntario cadVoluntario = Voluntario();
  FirebaseStorage storage = FirebaseStorage.instance;

// registrar o usuario no firebase
  Future<bool> signUp(String email, String senha, nome, cpf, endereco,
      dtNascimento, telefone, renda, selectedProfile, selectedName) async {
    try {
      User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: senha))
          .user;

      cadVoluntario.id = user!.uid;
      cadVoluntario.nome = nome;
      cadVoluntario.cpf = cpf;
      cadVoluntario.endereco = endereco;
      cadVoluntario.dtNascimento = dtNascimento;
      cadVoluntario.telefone = telefone;
      cadVoluntario.tipoUsuario = selectedProfile;
      cadVoluntario.email = email;
      cadVoluntario.senha = senha;
      cadVoluntario.vinculoOng = selectedName;
      await saveUser(user.uid);

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
      final userDocRef = _firestore.collection('voluntario').doc(id);

      if (!(await userDocRef.get()).exists) {
        // A coleção não existe, crie-a e insira os dados
        await userDocRef.set(cadVoluntario.toJson());
      } else {
        // A coleção já existe, atualize os dados conforme necessário
        await userDocRef.update(cadVoluntario.toJson());
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

      return Future.value(true);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  late String selectedName = '';

  Future<List<String>> loadNamesFromFirebase() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ong').get();
    final List<String> names = querySnapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            documentSnapshot['nome'] as String)
        .toList();

    if (!names.isEmpty && selectedName.isEmpty) {
      selectedName = names[0];
    }
    return names;
  }
}
