import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';

class ListAnimalPage extends StatelessWidget {
  ListAnimalPage({super.key});

  final AnimalServices _animalServices = AnimalServices();
  final Animal animal = Animal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Animal>>(
        future: _animalServices.getAnimalsFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar os dados');
          } else {
            final animals = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: animals!.length,
                    itemBuilder: (context, index) {
                      final animal = animals[index];
                      return ListTile(
                        title: Text(animal.nome ?? 'Nome não disponível'),
                        leading: Image.network(
                            animal.image ?? 'imagem não disponível'),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
