import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/adocao/adocao.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:flutter_application_1/pages/main_page.dart';

class AdocaoServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _collectionRef => _firestore.collection('animal_adocao');
  CollectionReference get _collectionAnimal => _firestore.collection('animal');
  CollectionReference get _collectionAdotante =>
      _firestore.collection('adotante');

  Future<bool> propostaAdocao(animalId, adotanteId) async {
    try {
      Animal animal = Animal();
      Adotante adotante = Adotante();

      DocumentReference docRef =
          FirebaseFirestore.instance.collection('animal_adocao').doc();
      await _collectionAnimal.doc(animalId).get().then((value) => {
            animal.id = value.id,
            animal.nome = value.get('nome'),
            animal.especie = value.get('especie'),
            animal.sexo = value.get('sexo'),
            animal.porte = value.get('porte'),
            animal.vinculoOng = value.get('vinculoOng'),
            animal.observacao = value.get('observacao'),
          });
      await _collectionAdotante.doc(adotanteId).get().then((value) => {
            adotante.id = value.id,
            adotante.nome = value.get('nome'),
            adotante.cpf = value.get('cpf'),
            adotante.email = value.get('email'),
            adotante.telefone = value.get('telefone'),
            adotante.endereco = value.get('endereco'),
            adotante.renda = value.get('renda'),
            adotante.tipoMoradia = value.get('tipoMoradia'),
          });
      String data = DateTime.now().toString();

      Adocao cadAdocao = Adocao(
          animal: animal,
          adotante: adotante,
          status: 'pendente',
          dataDeAdocao: data);

      await docRef.set(cadAdocao.toJson());

      cadAdocao.id = docRef.id;

      await docRef.update(cadAdocao.toJsonid());

      print('Dados salvos com sucesso.');
      return Future.value(true);
    } catch (e) {
      print('Erro ao salvar os dados: $e');
      return Future.value(false);
    }
  }



   Stream<QuerySnapshot> getAllAdocao() {
    
    return _collectionRef.snapshots();
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
}

