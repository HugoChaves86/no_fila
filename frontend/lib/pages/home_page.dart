import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_fila/providers.dart';
import 'ajustes_page.dart';
import 'grade_page.dart';
import 'profile_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: const <Widget>[
        HomeBar(),
        MinhaGrade(),
        MeusAjustes(),
        MeuPerfil(),
      ]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(
          () => selectedIndex = index,
        ),
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home_max), label: 'Início'),
          NavigationDestination(
              icon: Icon(Icons.calendar_view_month_rounded),
              label: 'Grade Curricular'),
          NavigationDestination(
              icon: Icon(Icons.archive_outlined), label: 'Ajustes'),
          NavigationDestination(
              icon: Icon(Icons.person_2_outlined), label: 'Perfil'),
        ],
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
          children: [
            const Header(),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("\nBem vindo,",
                      style: ref
                          .read(baseTextStyleProvider)
                          .copyWith(fontSize: 28, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "[Nome_do_usuário]",
                  style: ref.read(baseTextStyleProvider).copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.waving_hand, color: Colors.yellow[800])),
              ],
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
      child: Column(
        children: [
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              leading: const Icon(
                Icons.calendar_today_rounded,
                size: 50,
                color: Colors.white,
              ),
              title: const Text("Componentes Curriculares"),
              contentPadding: const EdgeInsets.all(20.0),
              titleTextStyle: ref.read(baseTextStyleProvider).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              subtitle: const Text(
                "Visualize os componentes curriculares inscritos",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              onTap: () {
                // TODO
                // Chamar componente grade
              },
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              leading: const Icon(
                Icons.archive_outlined,
                size: 50,
                color: Colors.white,
              ),
              title: const Text("Solicitações de Ajustes de Matrícula"),
              contentPadding: const EdgeInsets.all(20.0),
              titleTextStyle: ref.read(baseTextStyleProvider).copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              subtitle: Text(
                  "Crie e acompanhe suas solicitações de ajuste assíncrono",
                  style: ref
                      .read(baseTextStyleProvider)
                      .copyWith(fontSize: 14, color: Colors.white)),
              onTap: () {
                // TODO
                // Chamar componente ajustes
              },
            ),
          ),
        ],
      ),
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 30,
                child: Icon(
                  Icons.person,
                  size: 32,
                ),
              ),
            ),
          ),
          Image(image: AssetImage('images/logo.png'), height: 40),
        ],
      ),
    );
  }
}
