import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/adocao/adocao.dart';
import 'package:flutter_application_1/models/animal/animal.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/services/adocao/adocao_services.dart';

class AprovarAdocao extends StatefulWidget {
  const AprovarAdocao({super.key});

  @override
  State<AprovarAdocao> createState() => _AprovarAdocaoState();
}

class _AprovarAdocaoState extends State<AprovarAdocao> {
  //AnimalServices animalServices = AnimalServices();
  //UserServices adotanteServices = UserServices();
  AdocaoServices adocaoServices = AdocaoServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprovação de Adoção'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 245, 210, 15),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ícone de voltar
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            ); // Voltar para a página anterior
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 3, 2, 0),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Adoções Pendentes",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            StreamBuilder(
              stream: adocaoServices.getAllAdocao(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Dados indisponíveis no momento',
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
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        DocumentSnapshot docSnapshot =
                            snapshot.data!.docs[index];

                        // Verificar se o campo 'nome' e 'cpf' existe no documento antes de acessá-los
                        if (docSnapshot.data() != null &&
                            docSnapshot["status"] == "pendente") {
                          String dtAdocao = docSnapshot['dataDeAdocao'];
                          String nome = docSnapshot['adotante']['nome'];

                          Animal animal = Animal(
                              id: docSnapshot['animal']['id'],
                              nome: docSnapshot['animal']['nome'],
                              especie: docSnapshot['animal']['especie'],
                              // dtNascimento:
                              //     docSnapshot['animal']['dtNascimento'],
                              sexo: docSnapshot['animal']['sexo'],
                              porte: docSnapshot['animal']['porte'],
                              castrado: docSnapshot['animal']['castrado']);

                          Adotante adotante = Adotante(
                              id: docSnapshot['adotante']['id'],
                              nome: docSnapshot['adotante']['nome'],
                              cpf: docSnapshot['adotante']['cpf'],
                              email: docSnapshot['adotante']['email'],
                              telefone: docSnapshot['adotante']['telefone'],
                              endereco: docSnapshot['adotante']['endereco'],
                              renda: docSnapshot['adotante']['renda'],
                              tipoMoradia: docSnapshot['adotante']
                                  ['tipoMoradia']);

                          Adocao adocao = Adocao(
                              id: docSnapshot['id'],
                              status: docSnapshot['status'],
                              dataDeAdocao: docSnapshot['dataDeAdocao'],
                              animal: animal,
                              adotante: adotante);

                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              top: 10,
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Data: $dtAdocao"),
                                              Text("Adotante: $nome"),
                                              //Text("Animal: ${adocao.animal}"),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            // await redirectToPageWithParam(
                                            //     adocao, context);
                                          },
                                          child: const Text('detalhar'),
                                        ),
                                      ],
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
      ),
    );
  }

  // redirectToPageWithParam(Adocao adocao, BuildContext context) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => AdotanteDetailPage(
  //         adotante: adotante,
  //       ),
  //     ),
  //   );
  // }
}
