import 'dart:convert';

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
  //File webImage2 = File('');

  FirebaseStorage storage = FirebaseStorage.instance;
  Animal cadAnimal = Animal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _collectionRef => _firestore.collection('animal');

  //essa função abaixo é para a listagem dos animais

  // Future<List<Animal>> getAnimals() async {
  //   List<Animal> animals = [];

  //   final QuerySnapshot snapshot = await _firestore.collection('animal').get();

  //   for (final DocumentSnapshot doc in snapshot.docs) {
  //     final String name = doc['nome'];
  //     final String imageName = doc.id;

  //     final Uint8List imageBytes = await _getImageBytes(imageName);

  //     animals.add(Animal(nome: name, image: imageBytes));
  //   }

  //   return animals;
  // }

  // Future<Uint8List> _getImageBytes(String imageName) async {
  //   final Reference ref = storage.ref().child(imageName);
  //   final FullMetadata metadata = await ref.getMetadata();
  //   final int size = metadata.sizeBytes;

  //   final Uint8List data = Uint8List(size);
  //   await ref.getData().then((value) {
  //     data.setAll(0, value);
  //   });

  //   return data;
  // }

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
    //webImage2 = File(image!.path);
    if (image != null) {
      var imageSelected = await image.readAsBytes();
      webImage = imageSelected;
    } else {
      debugPrint('Nenhuma imagem selecionada.');
    }
  }

  Future<bool> cadastrarAnimal(String especie, sexo, porte, dtnascimento, nome,
      vacina, castrado, observacao, vinculoOng, dynamic imageFile) async {
    cadAnimal.especie = especie;
    cadAnimal.sexo = sexo;
    cadAnimal.porte = porte;
    cadAnimal.dtNascimento = dtnascimento;
    cadAnimal.nome = nome;
    cadAnimal.vacina = vacina;
    cadAnimal.castrado = castrado;
    cadAnimal.observacao = observacao;
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

      Reference ref = storage.ref().child('animal').child(userDocRef.id);
      UploadTask task = ref.putData(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpg',
        ),
      );
      //SettableMetadata(contentType: 'image/jpeg');
      String url = await (await task.whenComplete(() {})).ref.getDownloadURL();
      DocumentReference docRef = _collectionRef.doc(userDocRef.id);
      await docRef.update({'image': url});

      //uploadImageToFirebase(animal: cadAnimal, imageFile: webImage);

      //   final Reference ref;
      //   //task = storage.ref().child(userDocRef.id).putData(webImage);
      //   ref = storage.ref().child('animal').child(userDocRef.id);
      //   UploadTask task;
      //    task = ref.child(userDocRef.id).putFile(
      //           imageFile,
      //           SettableMetadata(
      //             contentType: 'image/jpg',
      //             customMetadata: {
      //               'upload by': 'teste',
      //               'description': 'Informação de arquivo',
      //               'imageName': imageFile
      //             },
      //           ),
      //         );
      //   //SettableMetadata(contentType: 'image/jpeg');
      //   String url = await (await task.whenComplete(() {})).ref.getDownloadURL();
      //   DocumentReference docRef = _collectionRef.doc(users!.id);
      //   await docRef.update({'image': url});
      // } on FirebaseException catch (e) {
      //   if (e.code != 'OK') {
      //     debugPrint('Problemas ao gravar dados');
      //   } else if (e.code == 'ABORTED') {
      //     debugPrint('Inclusão de dados abortada');
      //   }
      //   return Future.value(false);
      // }

      print('Dados salvos com sucesso.');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
    return Future.value(true);
  }

  uploadImageToFirebase({required imageFile}) async {}

//   void updateImageVariable(Uint8List imageBytes) async {
//   // Codificar o Uint8List em uma representação de string (base64)
//   String imageBase64 = base64Encode(imageBytes);

//   // Referência ao documento onde você deseja atualizar a variável
//   DocumentReference docRef = FirebaseFirestore.instance.collection('animal').doc(userDocRef.id.id);

//   try {
//     // Atualizar a variável 'image' com a representação de string da imagem
//     await docRef.update(cadAnimal.toJsonimage(imageBase64));
//     print('Imagem atualizada no Firebase Firestore com sucesso.');
//   } catch (error) {
//     print('Erro ao atualizar a imagem no Firebase Firestore: $error');
//   }
// }

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
