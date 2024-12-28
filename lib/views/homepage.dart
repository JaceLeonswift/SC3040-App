import 'package:flutter/material.dart';
import 'package:SC3040_App/widgets/appbar.dart';
import 'package:SC3040_App/views/firstviewpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return const Scaffold(
        body: Column(
          children: [
            Expanded(
              child: FirstViewPage(),
            )
          ],
        ),
      );
    });
  }
}
