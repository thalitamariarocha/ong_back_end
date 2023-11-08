import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';

import 'package:flutter_application_1/services/animal/animal_services.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<MainHome> {
  TextEditingController editingController = TextEditingController();
  AnimalServices animalServices = AnimalServices();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          fillOverscroll: true,
          hasScrollBody: true,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 245, 210, 15),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Color.fromRGBO(238, 164, 5, 1),
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: const Text('Gostou? cadastre-se e Adote!'),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    //width: 100,
                    child: Image.asset('assets/images/Untitled.png'),
                  ),
                  // Image.asset('assets/images/Untitled.png'),

                  const Text(
                      "Bem Vindo ao Mi AuDota! Veja os animais disponíveis para adoção!"),
                  const SizedBox(
                    height: 15,
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
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
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
                            itemBuilder: ((context, index) {
                              DocumentSnapshot docSnapshot =
                                  snapshot.data!.docs[index];

                              if (docSnapshot.data() != null &&
                                  docSnapshot["adotado"] == "false") {
                                String nome = docSnapshot['nome'];
                                String especie = docSnapshot['especie'];
                                String img = '';
                                try {
                                  img = docSnapshot['image'].toString();
                                } catch (e) {
                                  img = '';
                                }

                                Animal animal = Animal(
                                  id: docSnapshot['id'],
                                  especie: especie,
                                  sexo: docSnapshot['sexo'],
                                  porte: docSnapshot['porte'],
                                  dtNascimento: docSnapshot['dtNascimento'],
                                  nome: nome,
                                  vacina: docSnapshot['vacina'],
                                  castrado: docSnapshot['castrado'],
                                  observacao: docSnapshot['observacao'],
                                  image: img,
                                  vinculoOng: docSnapshot['vinculoOng'],
                                  adotado: docSnapshot['adotado'],
                                );

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
                                            child: Row(
                                              //mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 80,
                                                  width: 100,
                                                  child: Image.network(
                                                    docSnapshot['image'],
                                                    width: 200,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      print(
                                                          'Erro ao carregar imagem: $exception');
                                                      return const CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.cyanAccent,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.red),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 50,
                                                ),
                                                SizedBox(
                                                  width: 216,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        docSnapshot['nome'],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 238, 164, 5)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
