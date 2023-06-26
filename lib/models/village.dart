import 'package:dnd_villages/models/person.dart';
import 'package:dnd_villages/models/shop.dart';

class Village {
  final String name;
  final List<Person> people;
  final List<Shop> shops;

  Village({
    required this.name,
    required this.people,
    required this.shops,
  });

  Person? get shopkeeper {
    for (Shop shop in shops) {
      return shop.shopkeeper;
    }
    return null;
  }
}
