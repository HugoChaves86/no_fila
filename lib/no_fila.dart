import 'package:flutter/material.dart';
import 'package:no_fila/widgets/auth_check.dart';

class NoFila extends StatelessWidget {
  const NoFila({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '!Fila',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const AuthCheck(),
    );
  }
}
