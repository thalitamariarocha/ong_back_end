import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AnimalServices {
  late String idParaImagem;
  Uint8List webImage = Uint8List(8);
  FirebaseStorage storage = FirebaseStorage.instance;
  Animal cadAnimal = Animal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //essa função abaixo é para a listagem dos animais
  Future<List<Animal>> getAnimalsFromFirestore() async {
    List<Animal> animals = [];
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('animal').get();

    for (final DocumentSnapshot doc in snapshot.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final animal = Animal(
        nome: data['nome'],
        image: data['image'],
      );
      animals.add(animal);
    }
    return animals;
  }

  //a partir daqui são funções para o cadastro de animais

  late String selectedOng = '';

  Future<List<String>> loadNamesFromFirebase() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ong').get();
    final List<String> names = querySnapshot.docs
        .map((QueryDocumentSnapshot documentSnapshot) =>
            documentSnapshot['nome'] as String)
        .toList();

    if (!names.isEmpty && selectedOng.isEmpty) {
      selectedOng = names[0];
    }
    return names;
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

  Future<bool> cadastrarAnimal(String especie, sexo, porte, dtnascimento, nome,
      vacina, castrado, observacao, vinculoOng) async {
    cadAnimal.especie = especie;
    cadAnimal.sexo = sexo;
    cadAnimal.porte = porte;
    cadAnimal.dtNascimento = dtnascimento;
    cadAnimal.nome = nome;
    cadAnimal.vacina = vacina;
    cadAnimal.castrado = castrado;
    cadAnimal.observacao = observacao;
    //cadAnimal.image = webImage;
    cadAnimal.vinculoOng = selectedOng;
    cadAnimal.toJson();

    try {
      //String id = FirebaseAuth.instance.currentUser!.uid;
      final userDocRef = _firestore.collection('animal').doc();

      if (!(await userDocRef.get()).exists) {
        // A coleção não existe, crie-a e insira os dados
        await userDocRef.set(cadAnimal.toJson());
      } else {
        //cadOng.id = userDocRef.id;
        // A coleção já existe, atualize os dados conforme necessário
        await userDocRef.update(cadAnimal.toJson());
      }

      cadAnimal.id = userDocRef.id;

      await userDocRef.update(cadAnimal.toJsonid());

      //uploadImageToFirebase(animal: cadAnimal, imageFile: webImage);

      final UploadTask task;
      task = storage.ref().child(userDocRef.id).putData(webImage);
      SettableMetadata(contentType: 'image/jpeg');

      print('Dados salvos com sucesso.');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
    return Future.value(true);
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
}
