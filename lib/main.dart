import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SC3040_App/viewModels/auth_viewmodel.dart';
import 'package:SC3040_App/views/homepage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: const ColorScheme.highContrastDark()),
        home: const HomePage(),
      ),
    );
  }
}
