import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const FirebaseConfig = FirebaseOptions(
      apiKey: "AIzaSyDSkj-s2DPTcorTkWl42U_4F1UqtOadNZE",
      appId: "1:301576777279:web:6a0d5cf45ca6a4405e128a",
      messagingSenderId: "301576777279",
      projectId: "miaudota-back");
  //if (kIsWeb) {
  await Firebase.initializeApp(
    name: "miaudota-back-2",
    options: FirebaseConfig,
  );
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 245, 210, 15)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
