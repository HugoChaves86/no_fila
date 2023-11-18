import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MinhaGrade extends ConsumerWidget {
  const MinhaGrade({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Center(
        child: Text(
          "Componentes Curriculares",
        ),
      ),
    );
  }
}
