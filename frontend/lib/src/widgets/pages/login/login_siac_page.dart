import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/common/exceptions.dart';
import 'package:no_fila/src/common/providers.dart';

class LoginSiacPage extends ConsumerStatefulWidget {
  const LoginSiacPage({super.key});

  @override
  ConsumerState<LoginSiacPage> createState() => _LoginSiacPageState();
}

class _LoginSiacPageState extends ConsumerState<LoginSiacPage> {
  final formKey = GlobalKey<FormState>();
  final cpf = TextEditingController();
  final senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Login SIAC",
                      style: ref
                          .read(baseTextStyleProvider)
                          .copyWith(fontSize: 28, fontWeight: FontWeight.w500)),
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
                          labelText: 'Digite seu cpf',
                          icon: Icon(Icons.start),
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
                            _login(cpf.text, senha.text);
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.login),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Entrar'),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Atualizar'),
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
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.indigo,
        child: const Align(
          alignment: Alignment.bottomCenter,
          child: ContentBar(),
        ),
      ),
    );
  }

  _login(String cpf, String senha) async {
    final scaffoldContext = ScaffoldMessenger.of(context);
    try {
      await ref.read(siacServiceProvider.notifier).loginSiac(cpf, senha);
    } on AuthException catch (e) {
      scaffoldContext.showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    }
  }
}

class ContentBar extends StatelessWidget {
  const ContentBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Login SIAC',
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }
}
