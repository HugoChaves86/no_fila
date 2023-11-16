import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:no_fila/no_fila.dart';
import 'package:no_fila/services/auth_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // garantia de inicialização do Firebase antes do app

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        //Podemos adicionar mais providers aqui se necessário
      ],
      child: const NoFila(),
    ),
  );
}
