import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthState {
  final User? user;
  final bool isloading;

  AuthState({this.user, this.isloading = true});
}

class AuthNotifier extends AsyncNotifier<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  FutureOr<AuthState> build() {
    _auth.authStateChanges().listen((User? user) {
      state = AsyncValue.data(AuthState(user: user, isloading: false));
    });
    return AuthState(user: _auth.currentUser, isloading: true);
  }

  void _getUser() {
    User? user = _auth.currentUser;
    state = AsyncValue.data(AuthState(user: user, isloading: false));
  }

  Future<void> registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (err.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está cadastrado.');
      }
    }
  }

  Future<void> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        throw AuthException('E-mail não encontrado. Cadastre-se.');
      } else if (err.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente.');
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _getUser();
  }
}
