import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/src/common/providers.dart';
import 'package:no_fila/src/widgets/pages/login/login_siac_page.dart';

class ConnectSiac extends ConsumerWidget {
  const ConnectSiac({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: HomeBar(),
    );
  }
}

class ContentBar extends StatelessWidget {
  const ContentBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'NoFila',
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }
}

class HomeBar extends ConsumerWidget {
  const HomeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Header(),
            Row(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      "\n\nBem vindo ao !FILA.\nConecte-se ao SIAC para continuar:",
                      style: ref
                          .read(baseTextStyleProvider)
                          .copyWith(fontSize: 28, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle>(ref
                          .read(baseTextStyleProvider)
                          .copyWith(fontSize: 14))),
                  child: const Text('Conecte-se com o SIAC'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginSiacPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
            const ContentSection()
          ],
        ),
      ),
    );
  }
}

class ContentSection extends ConsumerStatefulWidget {
  const ContentSection({
    super.key,
  });

  @override
  ConsumerState<ContentSection> createState() => _ContentSectionState();
}

class _ContentSectionState extends ConsumerState<ContentSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
    );
  }
}

class Header extends ConsumerStatefulWidget {
  const Header({
    super.key,
  });

  @override
  ConsumerState<Header> createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: const Center(
          child: Image(image: AssetImage('images/logo.png'), height: 65)),
    );
  }
}
