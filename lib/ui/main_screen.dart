// ui/main_screen.dart

import 'package:flutter/material.dart';
import 'package:dnd_villages/models/village_config.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> _sizes = ['Small', 'Medium', 'Large'];
  final List<String> _climates = [
    'Temperate',
    'Tropical',
    'Arctic',
    'Desert',
    'Urban',
    'Coastal',
    'Mountain',
    'Forest'
  ];

  String _selectedSize = 'Medium';
  String _selectedClimate = 'Temperate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Village Configuration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedSize,
              items: _sizes.map((size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text(size),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSize = value!;
                });
              },
            ),
            DropdownButton<String>(
              value: _selectedClimate,
              items: _climates.map((climate) {
                return DropdownMenuItem<String>(
                  value: climate,
                  child: Text(climate),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedClimate = value!;
                });
              },
            ),
            ElevatedButton(
              child: const Text('Generate Village'),
              onPressed: () {
                int size;
                switch (_selectedSize) {
                  case 'Small':
                    size = 25;
                    break;
                  case 'Medium':
                    size = 50;
                    break;
                  case 'Large':
                    size = 100;
                    break;
                  default:
                    size = 50;
                }
                String climate = _selectedClimate;

                Navigator.pushNamed(
                  context,
                  '/village',
                  arguments: VillageConfig(
                    size: size,
                    climate: climate,
                    alignment: 'Neutral', // Adjust this as necessary
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
