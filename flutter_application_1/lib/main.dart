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
    if (kIsWeb) {
      await Firebase.initializeApp(name: "miaudota-back", options: FirebaseConfig,);
    } else {
     await Firebase.initializeApp();
    }
    
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

