import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MeusAjustes extends ConsumerWidget {
  const MeusAjustes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: const Text(
        "Página de Ajustes",
      ),
    );
  }
}
