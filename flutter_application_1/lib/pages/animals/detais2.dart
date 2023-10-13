// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/animal/animal.dart';

// class AnimalDetailPage extends StatefulWidget {
//   final Animal animal;

//   const AnimalDetailPage({Key? key, required this.animal}) : super(key: key);

//   @override
//   State<AnimalDetailPage> createState() => _AnimalDetailPageState();
// }

// class _AnimalDetailPageState extends State<AnimalDetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.animal.nome),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Imagem do animal
//           Image.network(widget.animal.image),

//           // Texto com as informações do animal
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Nome:",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(widget.animal.nome),
//                 Text(
//                   "Espécie:",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(widget.animal.especie),
//                 Text(
//                   "Raça:",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(widget.animal.raca),
//                 Text(
//                   "Idade:",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(widget.animal.idade),
//                 Text(
//                   "Sexo:",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Text(widget.animal.sexo),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
