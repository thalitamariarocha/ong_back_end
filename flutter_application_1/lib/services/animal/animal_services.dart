import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:image_picker/image_picker.dart';

class AnimalServices {
  late String idParaImagem;
  Uint8List webImage = Uint8List(8);
  FirebaseStorage storage = FirebaseStorage.instance;
  Animal cadAnimal = Animal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _collectionRef => _firestore.collection('animal');

  //essa função abaixo é para a listagem dos animais

  DocumentReference get _firestoreRef =>
      _firestore.doc('animal/${cadAnimal.id}');

  Stream<QuerySnapshot> getAllAnimais() {
    return _collectionRef.snapshots();
  }

  //-------------------------------------------------------------------------------
//a partir daqui são funções para a excluir animais
  deleteCadastro(id) async {
    try {
      await FirebaseFirestore.instance.collection('animal').doc(id).delete();
      print('Dados excluídos com sucesso.');
    } catch (e) {
      print('Erro ao excluir os dados: $e');
    }
  }

  Future<bool> atualizaAnimal(
      String id,
      especie,
      sexo,
      porte,
      dtnascimento,
      nome,
      vacina,
      castrado,
      observacao,
      vinculoOng,
      dynamic imageFile,
      adotado) async {
    try {
      String url = "";

      //Quero descobrir se o tipo é string ou Uint8List
      var ehString = imageFile.runtimeType;
      if (ehString != String) {
        print('Dados atualizados com sucesso.');

        Reference ref = storage.ref().child('animal').child(id);
        UploadTask task = ref.putData(
          imageFile,
          SettableMetadata(
            contentType: 'image/jpg',
          ),
        );

        url = await (await task.whenComplete(() {})).ref.getDownloadURL();
      } else {
        url = imageFile;
      }

      cadAnimal.id = id;
      cadAnimal.especie = especie;
      cadAnimal.sexo = sexo;
      cadAnimal.porte = porte;
      cadAnimal.dtNascimento = dtnascimento;
      cadAnimal.nome = nome;
      cadAnimal.vacina = vacina;
      cadAnimal.castrado = castrado;
      cadAnimal.observacao = observacao;
      cadAnimal.image = url;
      cadAnimal.vinculoOng = selectedOng;
      cadAnimal.adotado = adotado;
      cadAnimal.toJson();
      await _firestoreRef.update(cadAnimal.toJson());

      // DocumentReference docRef = _collectionRef.doc(id);
      // await docRef.update({'image': url});

      print('imagem atualizada com sucesso.');

      return Future.value(true);
    } catch (e) {
      print('Erro ao atualizar os dados: $e');
      return Future.value(false);
    }
  }

  Future<void> loadDataFromFirebase(String id) async {
    try {
      final documentSnapshot =
          await FirebaseFirestore.instance.collection('animal').doc(id).get();
      cadAnimal.id = id;
      cadAnimal.especie = documentSnapshot['especie'];
      cadAnimal.sexo = documentSnapshot['sexo'];
      cadAnimal.porte = documentSnapshot['porte'];
      cadAnimal.dtNascimento = documentSnapshot['dtNascimento'];
      cadAnimal.nome = documentSnapshot['nome'];
      cadAnimal.vacina = documentSnapshot['vacina'];
      cadAnimal.castrado = documentSnapshot['castrado'];
      cadAnimal.observacao = documentSnapshot['observacao'];
      cadAnimal.vinculoOng = documentSnapshot['vinculoOng'];
      cadAnimal.adotado = documentSnapshot['adotado'];
      cadAnimal.image = documentSnapshot['image'];

      //return cadAnimal;
      //cadAnimal.toJson();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  //-------------------------------------------------------------------------------

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
    cadAnimal.adotado = "false";
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
          title: const Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                // Fechar o diálogo quando o botão "OK" for pressionado
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialogSReturn(BuildContext context, String message) {
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
}
