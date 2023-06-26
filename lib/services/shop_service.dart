import 'package:dnd_villages/models/shop.dart';
import 'package:dnd_villages/models/person.dart';
import 'dart:math';


class ShopService {
  final Random _random = Random();

  List<String> shopTypes = [
    'Blacksmith',
    'Bakery',
    'Carpenter',
    'General Store',
    'Jeweler',
    'Tavern',
    'Tailor',
    'Apothecary',
    'Magic Shop',
    'Bookstore',
  ];

  Map<String, List<String>> shopClimates = {
    'Blacksmith': ['Temperate', 'Cold'],
    'Bakery': ['Temperate'],
    'Carpenter': ['Temperate'],
    'General Store': ['Temperate'],
    'Jeweler': ['Temperate'],
    'Tavern': ['Temperate'],
    'Tailor': ['Temperate'],
    'Apothecary': ['Temperate'],
    'Magic Shop': ['Temperate'],
    'Bookstore': ['Temperate'],
  };

  Shop generateShop(String climate, List<Person> people) {
    String shopType = _getRandomShopType();
    String shopClimate = _getRandomShopClimate(shopType);

    Person shopkeeper = _getRandomShopkeeper(people, shopType);

    return Shop(
      name: '',
      type: shopType,
      climate: shopClimate,
      shopkeeper: shopkeeper,
    );
  }

  String _getRandomShopType() {
    int index = _random.nextInt(shopTypes.length);
    return shopTypes[index];
  }

  String _getRandomShopClimate(String shopType) {
    List<String> climates = shopClimates[shopType]!;
    int index = _random.nextInt(climates.length);
    return climates[index];
  }

Person _getRandomShopkeeper(List<Person> people, String shopType) {
  List<Person> eligibleShopkeepers = people
      .where((person) => person.occupation == shopType)
      .toList();

  if (eligibleShopkeepers.isEmpty) {
    // Generate a new villager as the shopkeeper with the desired occupation
    Person shopkeeper = _generateShopkeeper(shopType);
    return shopkeeper;
  }

  int index = _random.nextInt(eligibleShopkeepers.length);
  return eligibleShopkeepers[index];
}

Person _generateShopkeeper(String occupation) {
  // Generate a new villager with the desired occupation
  return Person(
    name: "New Shopkeeper",
    occupation: occupation,
    age: _random.nextInt(40) + 18, // Age between 18 and 57
    climate: 'Temperate',
    
  );
}

}
