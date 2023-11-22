import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_fila/pages/connect_siac.dart';
import 'package:no_fila/widgets/auth_check.dart';
import 'services/auth_service.dart';

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
