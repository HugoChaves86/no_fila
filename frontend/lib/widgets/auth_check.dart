import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/pages/connect_siac.dart';
// import 'package:no_fila/pages/home_page.dart';
import 'package:no_fila/pages/login_siac_page.dart';
import 'package:no_fila/providers.dart';
import '../services/auth_service.dart';
import '../pages/login_page.dart';

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
    final bool isConnected = ref.watch(connectSiacProvider);
    return isConnected ? const LoginSiacPage() : const ConnectSiac();
  }
}
