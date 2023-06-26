import 'package:flutter/material.dart';
import 'package:dnd_villages/models/village_config.dart';
import 'package:dnd_villages/ui/main_screen.dart';
import 'package:dnd_villages/ui/village_screen.dart';

void main() {
  runApp(const DndVillagesApp());
}

class DndVillagesApp extends StatelessWidget {
  const DndVillagesApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D&D Villages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/village': (context) {
          final VillageConfig? config = ModalRoute.of(context)?.settings.arguments as VillageConfig?;
          final String climate = config?.climate ?? '';
          return VillageScreen(config: config!, climate: climate);
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/village') {
          final VillageConfig? config = settings.arguments as VillageConfig?;
          final String climate = config?.climate ?? '';
          return MaterialPageRoute(
            builder: (context) => VillageScreen(config: config!, climate: climate),
          );
        }
        return null;
      },
    );
  }
}
