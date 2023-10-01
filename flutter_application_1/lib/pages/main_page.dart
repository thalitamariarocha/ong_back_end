import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/animals/cad_animal_page.dart';
import 'package:flutter_application_1/pages/animals/list_animal_page.dart';
import 'package:flutter_application_1/pages/cad_ong/cad_ong_page.dart';
import 'package:flutter_application_1/pages/cad_voluntario/cad_Voluntario_page.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:flutter_application_1/pages/user_profile/user_profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0; //variavel que vai calcular a posicao do index automatico

  @override
  Widget build(BuildContext context) {
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
                ListTile(
                  title: const Text("Aprovar"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfilePage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Animais"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListAnimalPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
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
