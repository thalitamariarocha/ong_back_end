import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:intl/intl.dart';

class UserServices {
//obter instancia do firebase auth

  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Adotante cadAdotante = Adotante();

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

      // await FirebaseFirestore.instance.collection('adotante').doc(id).set({ });
      //se der certo, apagar esse trecho

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

  //metodo p persistir no firebase original
  // saveUser(id) async {
  //   String id = FirebaseAuth.instance.currentUser!.uid;
  //   await _firestore.collection('adotante').doc(id).set(cadAdotante!.toJson());
  // }

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

  //metodo converter dtNascimento para formato data
  // Converterdata(data) {
  //   onChanged:
  //   (String value) {
  //     // Converte a string da caixa de texto em uma data
  //     DateTime data = DateFormat('dd/MM/yyyy').parse(value);

  //     // Converte a data para o formato ISO 8601
  //     String dataFirestore = DateFormat('yyyy-MM-dd').format(data);
  //   };
  // }
}
