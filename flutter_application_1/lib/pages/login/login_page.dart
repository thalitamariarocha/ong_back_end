import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/login/signup_page.dart';
import 'package:flutter_application_1/pages/main_page.dart';
import 'package:flutter_application_1/services/users/users_services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 50, left: 50),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              "assets/images/Untitled.png",
              //C:\Users\Thalita\Documents\VSCode\ong_back_end\flutter_application_1\assets\images\Untitled.png
              //height: 300,
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                labelText: "email",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: _password,
              decoration: InputDecoration(
                labelText: "senha",
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 10.0,
              ),
              alignment: Alignment.bottomRight,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: LinearBorder.bottom(),
                  ),
                  onPressed: () async {
                    if (await _userServices.signIn(
                        _email.text, _password.text)) {
                  
                    //  bool isAdmin = await _isAdmin();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ));
                    }
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    }, //todo esse ontap é o link para quando clicar, direcionar p/ pagina de registro (signup)
                    child: const Text(
                      "ainda não tem conta? registre-se",
                      style: TextStyle(color: Color.fromARGB(255, 61, 6, 112)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> userData =
          snapshot.docs.first.data() as Map<String, dynamic>;
      String tipoUsuario = userData['tipoUsuario'];
      if (tipoUsuario == 'Administrador') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }





}
