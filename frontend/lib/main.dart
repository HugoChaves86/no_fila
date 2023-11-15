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

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.blueGrey,
//         body: Center(
//           child: LoginScreen(),
//         ),
//       ),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text(
//             '!Fila',
//             style: TextStyle(
//               color: Colors.amber,
//               fontSize: 24.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 20.0),
//           TextFormField(
//             decoration: const InputDecoration(
//                 labelText: 'Login',
//                 labelStyle: TextStyle(color: Colors.amber),
//                 prefixIcon: Icon(Icons.person),
//                 prefixIconColor: Colors.amber),
//           ),
//           const SizedBox(height: 20.0),
//           TextFormField(
//             obscureText: true,
//             decoration: const InputDecoration(
//               labelText: 'Senha',
//               labelStyle: TextStyle(color: Colors.amber),
//               prefixIcon: Icon(Icons.lock),
//               prefixIconColor: Colors.amber,
//             ),
//           ),
//           const SizedBox(height: 20.0),
//           ElevatedButton(
//             onPressed: () {
//               // Adicionar aqui a lógica de autenticação
//             },
//             style: ButtonStyle(
//                 textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
//               color: Colors.amber,
//               fontSize: 16.0,
//             ))),
//             child: const Text('Login'),
//           ),
//           const SizedBox(height: 10.0),
//           const Text(
//             'Por favor, utilize seu login e senha para fazer login.',
//             style: TextStyle(fontSize: 14.0, color: Colors.amber),
//           ),
//         ],
//       ),
//     );
//   }
// }
