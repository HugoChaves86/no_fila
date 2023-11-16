import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isloading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isloading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use') {
        throw AuthException('Este e-mail já está cadastrado.');
      } else if (err.code == 'invalid-email') {
        throw AuthException('Por favor, insira um e-mail válido.');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (err) {
      if (err.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw AuthException('E-mail ou senha incorreta. Tente novamente.');
      } else if (err.code == 'invalid-email') {
        throw AuthException('Por favor, insira um e-mail válido.');
      } else if (err.code == 'too-many-requests') {
        throw AuthException('E-mail ou senha incorreta. Tente novamente.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
