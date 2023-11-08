import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/usuarios/adotante.dart';
import 'package:flutter_application_1/pages/aprovacao/details_adotante_page.dart';
import 'package:flutter_application_1/services/users/users_services.dart';

class HistoricoCadastro extends StatefulWidget {
  const HistoricoCadastro({super.key});

  @override
  State<HistoricoCadastro> createState() => _HistoricoCadastro();
}

class _HistoricoCadastro extends State<HistoricoCadastro> {
  UserServices adotanteServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
        fillOverscroll: true,
        hasScrollBody: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Histórico de Aprovação de Adotantes'),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 245, 210, 15),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Cadastros Reprovados",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                StreamBuilder(
                  stream: adotanteServices.getAllAdotante(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                docSnapshot["aprovado"] == "reprovado") {
                              String nome = docSnapshot['nome'];
                              String cpf = docSnapshot['cpf'];
                              String img = '';
                              try {
                                img = docSnapshot['image'].toString();
                              } catch (e) {
                                img = '';
                              }
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
                                                  Text("Nome: $nome"),
                                                  Text("CPF: $cpf"),
                                                ],
                                              ),
                                            ),
                                            // ElevatedButton(
                                            //   onPressed: () async {
                                            //     await redirectToPageWithParam(
                                            //         adotante, context);
                                            //   },
                                            //   child: const Text('detalhar'),
                                            // ),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Cadastros Aprovados",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: adotanteServices.getAllAdotante(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                docSnapshot["aprovado"] == "aprovado") {
                              String nome = docSnapshot['nome'];
                              String cpf = docSnapshot['cpf'];
                              String img = '';
                              try {
                                img = docSnapshot['image'].toString();
                              } catch (e) {
                                img = '';
                              }
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
                                                  Text("Nome: $nome"),
                                                  Text("CPF: $cpf"),
                                                ],
                                              ),
                                            ),
                                            // ElevatedButton(
                                            //   onPressed: () async {
                                            //     await redirectToPageWithParam(
                                            //         adotante, context);
                                            //   },
                                            //   child: const Text('detalhar'),
                                            // ),
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
        ),
      )
    ]);
  }
}
