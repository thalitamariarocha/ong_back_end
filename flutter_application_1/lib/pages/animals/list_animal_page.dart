import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/animals/details_animal_page.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';

class ListAnimalPage extends StatefulWidget {
  const ListAnimalPage({Key? key}) : super(key: key);

  @override
  State<ListAnimalPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ListAnimalPage> {
  TextEditingController editingController = TextEditingController();
  AnimalServices animalServices = AnimalServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animais Cadastrados"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: editingController,
          //     decoration: const InputDecoration(
          //       labelText: "Buscar",
          //       hintText: "Filtra por nome do produto",
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(8.0),
          //         ),
          //       ),
          //     ),
          //     onChanged: (name) {},
          //   ),
          // ),
          const SizedBox(
            height: 25,
          ),
          StreamBuilder(
            stream: animalServices.getAllAnimais(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Dados indisponíveis no momento',
                    style: TextStyle(color: Colors.brown, fontSize: 20),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 238, 164, 5)),
                  ),
                );
              }
              //verificar a existência de dados
              else if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    //itemCount: (snapshot.data!.docs.length / 2).ceil(),
                    itemBuilder: ((context, index) {
                      DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 5,
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()

                                          // DetailsAnimalPage(
                                          //   animalId: docSnapshot.id,
                                          // ),
                                          ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Image.network(
                                          docSnapshot['image'],
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            print(
                                                'Erro ao carregar imagem: $exception');
                                            return const CircularProgressIndicator(
                                              backgroundColor:
                                                  Colors.cyanAccent,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.red),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 216,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              docSnapshot['nome'],
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              docSnapshot['especie'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //),
                                      ),
                                      // ElevatedButton(
                                      //   style: ElevatedButton.styleFrom(
                                      //     alignment: Alignment.centerRight,

                                      //     //shape: LinearBorder.bottom(),
                                      //   ),
                                      //   onPressed: () async {
                                      //     // await ;
                                      //   },
                                      //   child: const Text('quero adotar'),
                                      // ),
                                      // IconButton(
                                      //   iconSize: 18,
                                      //   onPressed: () {},
                                      //   icon: const Icon(Icons.edit),
                                      // ),
                                      // IconButton(
                                      //   iconSize: 18,
                                      //   onPressed: () async {
                                      //     bool ok = await animalServices.delete();
                                      //     if (ok && mounted) {
                                      //       ScaffoldMessenger.of(context)
                                      //           .showSnackBar(
                                      //         const SnackBar(
                                      //           content: Text(
                                      //               'Produto deletado com sucesso.'),
                                      //         ),
                                      //       );
                                      //     }
                                      //   },
                                      //   icon: const Icon(Icons.delete),
                                      // )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }
              return const Center(
                // child: Text(
                //   'Dados indisponíveis no momento',
                //   style: TextStyle(color: Colors.brown, fontSize: 20),
                // ),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 238, 164, 5)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
