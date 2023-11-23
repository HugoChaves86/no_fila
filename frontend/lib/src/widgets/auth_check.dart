import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/widgets/pages/login/connect_siac.dart';
import 'package:no_fila/src/widgets/pages/home_page.dart';
// import 'package:no_fila/pages/home_page.dart';
import 'package:no_fila/src/widgets/pages/login/login_siac_page.dart';
import 'package:no_fila/src/common/providers.dart';
import '../app/auth_service.dart';
import 'pages/login/login_page.dart';

class AuthCheck extends ConsumerWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<AuthState> authState = ref.watch(authServiceProvider);

    return authState.when(
        data: (authState) {
          if (authState.user == null) {
            return const LoginPage();
          } else {
            return const AuthSiacCheck();
          }
        },
        loading: () => loading(),
        error: (err, stack) => errorWidget(err, stack));
  }

  Widget loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget errorWidget(e, st) {
    return Scaffold(
      body: Center(
        child: Text('Erro: $e'),
      ),
    );
  }
}

class AuthSiacCheck extends ConsumerWidget {
  const AuthSiacCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool clicou = ref.watch(connectSiacProvider);
    return clicou ? const AuthSiacValidation() : const ConnectSiac();
  }
}

class AuthSiacValidation extends ConsumerWidget {
  const AuthSiacValidation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool validation = ref.watch(connectionValidation);
    return validation ? const HomePage() : const LoginSiacPage();
  }
}
