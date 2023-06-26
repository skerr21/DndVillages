import 'package:dnd_villages/models/person.dart';

class Shop {
  final String name;
  final String climate;
  final Person shopkeeper;
  final String type;

  Shop({required this.name, required this.climate, required this.shopkeeper, required this.type});
}
