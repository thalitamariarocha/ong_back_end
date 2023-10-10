// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/animals/cad_animal_page.dart';
import 'package:flutter_application_1/pages/animals/list_animal_page.dart';
import 'package:flutter_application_1/pages/cad_ong/cad_ong_page.dart';
import 'package:flutter_application_1/pages/cad_voluntario/cad_Voluntario_page.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:flutter_application_1/pages/user_profile/user_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/services/animal/animal_services.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0; //variavel que vai calcular a posicao do index automatico
  AnimalServices animalServices = AnimalServices();
  teste() async {
    bool validador = await _isAdmin();
    return validador;
  }

  // _MainPageState();

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
                Column(
                  children: [
                    ListTile(
                      title: const Text("Aprovar Cadastro"),
                      // enabled: await _isAdmin(),
                      onTap: () async {
                        if (await _isAdmin() == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserProfilePage(),
                            ),
                          );
                        } else if (await _isAdmin() == false) {
                          animalServices.showErrorDialog(context,
                              'Permissão Negada! Você não é administrador.');
                        }
                      },
                    ),
                    ListTile(
                      title: const Text("Aprovar Adoção"),
                      //enabled:  await _isAdmin(),
                      onTap: () async {
                        if (await _isAdmin() == true) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserProfilePage(),
                            ),
                          );
                        } else if (await _isAdmin() == false) {
                          animalServices.showErrorDialog(context,
                              'Permissão Negada! Você não é administrador.');
                        }
                      },
                    ),
                  ],
                ),
                //--------------------------------fim acesso admin-------------------
                ListTile(
                  title: const Text("Animais Disponíveis"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListAnimalPage(),
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

  thalita09() async {
    //if (_isAdmin() == true) {
    // if (_isAdmin != null && isAdmin)
    return const ExpansionTile(
      title: Text("Aprovar"),
      children: [
        ListTile(
          title: const Text("Cadastro"),
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const UserProfilePage(),
          //     ),
          //   );
          // },
        ),
        ListTile(
          title: const Text("Adoção"),
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const UserProfilePage(),
          //     ),
          //   );
          // },
        ),
      ],
    );
  }
}

Future<bool> _isAdmin() async {
  // Obtém o usuário logado
  User user = FirebaseAuth.instance.currentUser!;

  if (user == null) {
    return false;
  }
// Obtém o id do usuário
  String uid = user.uid;

  // Procura o usuário no Firestore
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('voluntario')
      .where('id', isEqualTo: uid)
      .get();

  if (snapshot.docs.isEmpty) {
    return false;
  }

  Map<String, dynamic> userData =
      snapshot.docs.first.data() as Map<String, dynamic>;
  String tipoUsuario = userData['tipoUsuario'];
  if (tipoUsuario == 'Administrador') {
    return true;
  } else {
    return false;
  }
}
