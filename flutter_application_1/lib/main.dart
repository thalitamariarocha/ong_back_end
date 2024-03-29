import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/main_home.dart';
import 'package:flutter_application_1/services/users/users_services.dart';
import 'package:provider/provider.dart';

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
  //  HttpServer.bindSecure(
  //   InternetAddress.anyIPv4,
  //   443, // Port for HTTPS (default is 443)
  //   SecurityContext()
  //     ..useCertificateChain('mycert.pem')
  //     ..usePrivateKey('mykey.pem'),
  // ).then((server) {
  //   server.listen((HttpRequest request) {
  //     request.response.write('Hello, world!');
  //     request.response.close();
  //   });
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserServices>(create: (_) => UserServices()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 245, 210, 15)),
          useMaterial3: true,
        ),
        home: const MainHome(),
      ),
    );
  }
}



//flutter run -d chrome --web-browser-flag "--disable-web-security"glo