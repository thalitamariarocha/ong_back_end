// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/animal/animal.dart';
// import 'package:flutter_application_1/services/animal/animal_services.dart';

// class DetailsAnimalPage extends StatefulWidget {
//   final String animalId;
//   AnimalServices animalServices = AnimalServices();

//   //DetailsAnimalPage({required this.animalId});
//   DetailsAnimalPage({required this.animalId});
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   CollectionReference get _collectionRef => _firestore.collection('animal');
//   late final Map<String, dynamic> animalData;
  
  
//  // DocumentSnapshot docSnapshot = animalServices.getAllAnimais().doc(animalId);

//   @override
//   _DetailsAnimalPageState createState() => _DetailsAnimalPageState();
// }

// class _DetailsAnimalPageState extends State<DetailsAnimalPage> {
//   //late final Map<String, dynamic> animalData;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detalhes do Animal'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               animalData['image'].toString(),
//               errorBuilder: (BuildContext context, Object exception,
//                   StackTrace? stackTrace) {
//                 return CircularProgressIndicator();
//               },
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Nome: ${animalData['nome']}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Espécie: ${animalData['especie']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Sexo: ${animalData['sexo']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Porte: ${animalData['porte']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Data de Nascimento: ${animalData['dtNascimento']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Vacina: ${animalData['vacina']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Castrado: ${animalData['castrado']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               'Observação: ${animalData['observacao']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               'ONG responsável pelo animal: ${animalData['vinculoOng']}',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
