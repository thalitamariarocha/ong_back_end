// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/usuarios/voluntario.dart';
import 'package:flutter_application_1/pages/animals/cad_animal_page.dart';
import 'package:flutter_application_1/pages/animals/list_animal_page.dart';
import 'package:flutter_application_1/pages/animals/list_animal_page_adotante.dart';
import 'package:flutter_application_1/pages/aprovacao/aprov_adocao_page.dart';
import 'package:flutter_application_1/pages/aprovacao/aprov_cadastro.dart';
import 'package:flutter_application_1/pages/aprovacao/historico_adocao_page.dart';
import 'package:flutter_application_1/pages/aprovacao/historico_cadastro.dart';
import 'package:flutter_application_1/pages/cad_ong/cad_ong_page.dart';
import 'package:flutter_application_1/pages/cad_voluntario/cad_Voluntario_page.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:flutter_application_1/pages/user_profile/user_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';
import 'package:flutter_application_1/services/users/users_services.dart';
import 'package:flutter_application_1/services/voluntario/voluntario_services.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0; //variavel que vai calcular a posicao do index automatico
  AnimalServices animalServices = AnimalServices();

  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.asset('assets/images/Untitled.png'),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Text(
                      'Bem vindo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ExpansionTile(
                  title: const Text("Cadastrar"),
                  children: [
                    ListTile(
                      title: const Text("Voluntário"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CadVoluntarioPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text("Animal"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CadAnimalPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text("ONG"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CadOngPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                //--------------------------------acesso admin-------------------
                Consumer<UserServices>(
                  builder: (context, usersServices, child) {
                    return Visibility(
                      visible: usersServices.cadVoluntario.admin ? true : false,
                      child: Column(
                        children: [
                          ListTile(
                              title: const Text("Aprovar Cadastro"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AprovarCadastro(),
                                  ),
                                );
                              }),
                          ListTile(
                              title: const Text("Aprovar Adoção"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AprovarAdocao(),
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  },
                ),
                //--------------------------------fim acesso admin-------------------
                ListTile(
                    title: const Text("Histórico de Adoções"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoricoAdocao(),
                        ),
                      );
                    }),
                ListTile(
                    title: const Text("Histórico de Cadastro"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoricoCadastro(),
                        ),
                      );
                    }),
                ListTile(
                  title: const Text("Animais Cadastrados"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListAnimalPageInterno(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ), //aqui fica o menu lateral do lado esquerdo

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 210, 15),
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
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5, // Fator de escala da largura (0.0 - 1.0)
          heightFactor: 0.5, // Fator de escala da altura (0.0 - 1.0)
          alignment: Alignment.center, // Alinhamento da imagem
          child: Image.asset('assets/images/Untitled.png'),
        ),
      ),
    );
  }
}
