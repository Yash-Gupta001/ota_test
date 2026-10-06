import 'package:flutter/material.dart';

class PageTwoProvider extends ChangeNotifier {
  final List<String> _items = List.generate(100, (i) => 'Item ${i + 1}');

  List<String> get items => _items;

  String itemDescription(int index) => 'Description for item ${index + 1}';
}
