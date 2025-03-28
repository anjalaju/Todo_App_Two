import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/screens/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          displaySmall: TextStyle(
            color: const Color.fromARGB(255, 231, 210, 210),
            fontSize: 15,
          ),
          displayMedium: TextStyle(color: Colors.white, fontSize: 20),
        ),
        scaffoldBackgroundColor: Color(0xff0E1D3E),
      ),
      home: SplashPage(),
    );
  }
}
