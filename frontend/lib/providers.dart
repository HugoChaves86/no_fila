// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_fila/pages/connect_siac.dart';
import 'services/auth_service.dart';
// import 'package:dio/dio.dart';

// Define os global providers do app

final baseTextStyleProvider = StateProvider(
  (ref) => GoogleFonts.outfit(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  ),
);

final authServiceProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

final connectSiacProvider = StateNotifierProvider<ConnectSiacNotifier, bool>(
  (ref) => ConnectSiacNotifier(),
);

//Provider criado apenas para direcionamento para a HomePage
//após a validação da conexão com o SIAC, via classe "AuthCheck"
final connectionValidation =
    StateNotifierProvider<ConnectionValidationNotifier, bool>(
  (ref) => ConnectionValidationNotifier(),
);

final loginSiacProvider = StateProvider<bool>((ref) => false);
