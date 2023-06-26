import 'package:dnd_villages/models/village.dart';
import 'package:dnd_villages/models/person.dart';
import 'package:dnd_villages/models/shop.dart';
import 'package:dnd_villages/models/village_config.dart';
import 'package:dnd_villages/services/person_service.dart';
import 'package:dnd_villages/services/shop_service.dart';
import 'dart:math';

class VillageService {
  final PersonService _personService = PersonService();
  final ShopService _shopService = ShopService();
  final Random _random = Random();

  Village generateVillage(VillageConfig config, String climate) {
    List<Person> people = List.generate(
      config.size,
      (index) => _personService.generatePerson(climate),
    );

    List<Shop> shops = List.generate(
      config.size ~/ 10, // one shop for every 10 people
      (index) => _generateShop(climate, people),
    );

    String name = _generateVillageName();

    return Village(
      name: name,
      people: people,
      shops: shops,
    );
  }

  Shop _generateShop(String climate, List<Person> people) {
    return _shopService.generateShop(climate, people);
  }

  String _generateVillageName() {
    List<String> adjectives = [
      'Green',
      'Happy',
      'Peaceful',
      'Quiet',
      'Serene',
      'Tranquil',
    ];
    List<String> nouns = [
      'Meadow',
      'Grove',
      'Hollow',
      'Vale',
      'Hill',
      'Cove',
    ];

    String adjective = adjectives[_random.nextInt(adjectives.length)];
    String noun = nouns[_random.nextInt(nouns.length)];
    return '$adjective $noun';
  }
}
