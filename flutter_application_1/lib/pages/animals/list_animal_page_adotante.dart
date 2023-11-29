import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'package:flutter_application_1/pages/animals/details_animal_page_adotante.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';

//lista só para o adotante

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
        automaticallyImplyLeading: false, //para não aparecer a seta de voltar
        backgroundColor: const Color.fromARGB(255, 245, 210, 15),
        title: const Text("Animais Cadastrados"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: const Text("sair"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
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
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.red),
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
                                        ),
                                        Spacer(),
                                        Container(
                                          //visible: false,
                                          // alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              alignment: Alignment.centerRight,

                                              //primary: Colors.green,
                                              //shape: LinearBorder.bottom(),
                                            ),
                                            onPressed: () async {
                                              // onTap: () async {
                                              await redirectToPageWithParam(
                                                  animal, context);
                                              //},
                                            },
                                            child: const Text('quero adotar'),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Os campos 'nome' e/ou 'cpf' não existem no documento, trate esse caso
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
    );
  }

  redirectToPageWithParam(Animal animal, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsAnimalPage(
          animal: animal,
        ),
      ),
    );
  }
}
