import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers.dart';

class LoginSiacPage extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();
  final cpf = TextEditingController();
  final senha = TextEditingController();

  LoginSiacPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final loginSuccess = ref.watch(loginSiacProvider.notifier).state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login SIAC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '/images/logo.png',
                height: 100,
              ),
              Container(
                height: 300,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: cpf,
                      decoration: const InputDecoration(
                        labelText: 'Digite seu email',
                        icon: Icon(Icons.alternate_email_outlined),
                        iconColor: Colors.indigo,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o e-mail corretamente';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: senha,
                      obscureText: true,
                      enableSuggestions: false,
                      decoration: const InputDecoration(
                        labelText: 'Digite sua senha',
                        icon: Icon(Icons.lock_outline_rounded),
                        iconColor: Colors.indigo,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informa a sua senha';
                        } else if (value.length < 6) {
                          return 'Sua senha deve ter no mínimo 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _login(context, cpf.text, senha.text);
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Entrer'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context, String cpf, String senha) async {
    final dio = Dio();

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.get(
        'localhost:8000/docs',
        // options: Options(headers: headers),
        // data: {
        //   'cpf': cpf,
        //   'senha': senha,
        // },
      );

      print(response);
      // if (response.statusCode == 200) {
      //   // Aqui você pode adicionar lógica adicional para verificar se o login foi bem-sucedido no site
      //   print('Status da conexão: Funcionou!.');
      //   return true;
      // } else {
      //   return false;
      // }
    } catch (error) {
      // Lida com erros de requisição
      print(error);
      return false;
    }
  }
}
