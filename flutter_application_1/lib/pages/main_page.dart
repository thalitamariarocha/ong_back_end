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
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const Text("teste@gmail.com"),
                ],
              ),
            ),
             Column(
              children: [
                const ListTile(
                  title: Text("pedidos"),
                ),
                const ListTile(
                  title: Text("Carrinho de Compra"),
                ),
                const Divider(
                  height: 2,
                ),
                ListTile(
                  onTap: (){
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
        backgroundColor: const Color(0xFF610FAD),
        title: const Center(
          child: Text(
            "web-back",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("pedidos")),
              const PopupMenuItem(value: 2, child: Text("carrinho")),
            ],
          )
        ],

        // leading: IconButton(
        //   color: Colors.white,
        //   onPressed: (){
        //     showDialog(context: context, builder: (BuildContext context){
        //       return const AlertDialog(
        //         title: Text("Mensagem de Alerta"),
        //         content: Text("mensagem de uso de um alerta ao usuário"),
        //       );
        //     },
        //     );
        //   },
        //   icon: Icon(Icons.list),
        //   ),
        //ESSE COMENTADO É O BOTAO DO LADO ESQUERDO COMO IMAGEM GRÁFICA, QUE SUBSTITUI O DRAWER.------------------
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap:
            onTapped, //ontap serve para ver em que posição a pessoa selecionou

        items: const [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'pedidos',
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: 'carrinho',
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            label: 'perfil',
            icon: Icon(Icons.person),
          ),
        ],

        selectedItemColor: const Color(0xFF610FAD),
        unselectedItemColor: Color.fromARGB(255, 194, 170, 216),
        //  backgroundColor: Color(0xFF610FAD),
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
