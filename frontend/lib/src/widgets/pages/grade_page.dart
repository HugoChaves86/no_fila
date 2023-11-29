import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/common/providers.dart';
import 'package:no_fila/src/data/grade/grades.dart';

class MinhaGrade extends ConsumerWidget {
  const MinhaGrade({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curso = ref.read(userDataProvider).usuarioSiac?.curso;

    final cursoMap = {
      "Ciência da Computação": gradeCienciaDaComputacao,
      "Sistemas de Informação": gradeSistemasDeInformacao,
      "Licenciadura da Computação": gradeLicenciaturaDaComputacao,
    };

    final grade = cursoMap[curso];

    double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = (screenWidth > 600) ? 6 : 1;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      shrinkWrap: true,
      itemCount: grade?.length,
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).colorScheme.primary,
          margin: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Semestre: ${grade![index]['semestre']}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Código: ${grade[index]['código']}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Nome: ${grade[index]['nome']}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Natureza: ${grade[index]['natureza']}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
