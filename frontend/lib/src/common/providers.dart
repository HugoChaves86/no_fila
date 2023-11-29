import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_fila/src/app/siac_service.dart';
import 'package:no_fila/src/app/auth_service.dart';

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

final userEmailProvider = StateProvider<String>((ref) => '');

final siacServiceProvider = AsyncNotifierProvider<SiacNotifier, SiacState>(
  () => SiacNotifier(),
);
