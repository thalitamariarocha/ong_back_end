import 'package:flutter/material.dart';
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
                ListTile(
                  title: Text("Cadastrar"),
                  onTap: () {
                    ExpansionTile(
                      title: const Text("Cadastrar"),
                      children: [
                        ListTile(
                          title: const Text("Adotante"),
                          onTap: () {},
                        ),
                        ListTile(
                          title: const Text("Animal"),
                          onTap: () {},
                        ),
                      ],
                    );
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserProfilePage(),
                      ),
                    );
                  },
                  title: const Text("Perfil de Usuário"),
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
            color: Colors.white,
          ),
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text("sair"),
              ),
            ],
          )
        ],
        //  initialRoute: '/',
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
