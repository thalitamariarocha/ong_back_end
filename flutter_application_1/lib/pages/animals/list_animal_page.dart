//import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ListAnimalPage extends StatelessWidget {
  ListAnimalPage({super.key, required this.imageUrl});

  final AnimalServices _animalServices = AnimalServices();
  final Animal animal = Animal();
  final firestore = FirebaseFirestore.instance;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Animal>>(
      future: fetchProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Animal>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Nenhum produto encontrado.'));
        } else {
          final animals = snapshot.data;
          return ListView.builder(
            itemCount: animals!.length,
            itemBuilder: (context, index) {
              final animal = animals[index];
              return ListTile(
                title: Text(animal.nome ?? ''),
                leading: Image.network(animal.image ?? ''),
              );
            },
          );
        }
      },
    );
  }

  // body: GridView(
  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount: 2,
  //     childAspectRatio: 1.5,
  //   ),
  //   children: [
  //     FutureBuilder<List<Animal>>(
  //       future: _getAnimals(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return const Center(
  //             child: Text('Ocorreu um erro ao carregar os animais.'),
  //           );
  //         }

  //         if (snapshot.connectionState == ConnectionState.done) {
  //           final animals = snapshot.data;

  //           return ListView.builder(
  //             itemCount: animals!.length,
  //             itemBuilder: (context, index) {
  //               final animal = animals[index];

  //               return Card(
  //                 child: Column(
  //                   children: [
  //                     Expanded(
  //                       child: Image.memory(animal.image!),
  //                     ),
  //                     Text(animal.nome!),
  //                   ],
  //                 ),
  //               );
  //             },
  //           );
  //         }

  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       },
  //     ),
  //   ],
  // ),

  Future<List<Animal>> fetchProducts() async {
    //final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('animal').get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Animal(
        nome: data['nome'] as String,
        image: data['image'],
      );
    }).toList();
  }

  // Future<List<Animal>> _getAnimals() async {
  //   // Cria uma instância do `CollectionReference` para a coleção de animais no Firestore.
  //   final animalsRef = FirebaseFirestore.instance.collection('animal');

  //   // Recupera todos os documentos da coleção.
  //   final animals = await animalsRef.get();

  //   // Cria uma lista de futuros de animais.
  //   List<Animal> animalsList = [];
  //   //List<Future<Animal>> animalFutures = [];

  //   //for (var element in animals.docs) {
  //   animals.docs.forEach((element) async {
  //     final animalData = element.data();
  //     final name = animalData['nome'];
  //     final image = animalData['image'];
  //     final animal = Animal(
  //       nome: name,
  //       image: image as Uint8List?,
  //     );

  //     //  animalsList.add(animal);
  //   });

  //   // Aguarda a conclusão de todos os futuros.
  //   //List<Animal> animalsList = await Future.wait(animalFutures);

  //   // // Carrega a imagem do Firestore.
  //   // await animal.loadImage();

  //   // Adiciona o animal à lista.
  //   // animalsList.add(animal);
  //   //});

  //   return animalsList;
  // }
}
