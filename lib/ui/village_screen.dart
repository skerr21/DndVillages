import 'package:flutter/material.dart';
import 'package:dnd_villages/models/village_config.dart';
import 'package:dnd_villages/ui/main_screen.dart';
import 'package:dnd_villages/models/person.dart';
import 'package:dnd_villages/models/village.dart';
import 'package:dnd_villages/services/village_service.dart';
import 'package:dnd_villages/models/shop.dart';
import 'package:dnd_villages/services/person_service.dart';

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
          final VillageConfig? config =
              ModalRoute.of(context)?.settings.arguments as VillageConfig?;
          final String climate = config?.climate ?? '';
          return VillageScreen(config: config!, climate: climate);
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/village') {
          final VillageConfig? config = settings.arguments as VillageConfig?;
          final String climate = config?.climate ?? '';
          return MaterialPageRoute(
            builder: (context) =>
                VillageScreen(config: config!, climate: climate),
          );
        }
        return null;
      },
    );
  }
}

class VillageScreen extends StatefulWidget {
  final VillageConfig config;
  final String climate;

  const VillageScreen({Key? key, required this.config, required this.climate})
      : super(key: key);

  @override
  _VillageScreenState createState() => _VillageScreenState();
}

class _VillageScreenState extends State<VillageScreen> {
  Set<Person> selectedPersons = {};

  final VillageService _villageService = VillageService();
  final PersonService _personService = PersonService();
  Village village = Village(name: '', shops: [], people: []);

  @override
  void initState() {
    super.initState();
    _generateVillage();
  }

  void _generateVillage() {
    village = _villageService.generateVillage(widget.config, widget.climate);
  }

  void _generateShopkeeperName(Person shopkeeper) {
    String generatedName = _personService.generatePerson(widget.climate).name;
    setState(() {
      shopkeeper.name = generatedName;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Person> sortedVillagers = village.people.toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Village Generator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Village Name: ${village.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Shops:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: village.shops.length,
              itemBuilder: (context, index) {
                Shop shop = village.shops[index];
                return ListTile(
                  title: Text(
                    '${shop.name} (${shop.type})',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Shopkeeper: ${shop.shopkeeper.name}, ${shop.shopkeeper.occupation}, ${shop.shopkeeper.age} years old',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _generateShopkeeperName(shop.shopkeeper);
                        },
                        child: Text('Generate Name'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Villagers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sortedVillagers.length,
              itemBuilder: (context, index) {
                Person person = sortedVillagers[index];
                return ListTile(
                  title: Text(
                    '${person.name}, ${person.occupation}, ${person.age} years old',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
