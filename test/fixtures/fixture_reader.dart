import 'dart:convert';
import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

// Add this method to read JSON fixtures
Map<String, dynamic> jsonFixture(String name) {
  final jsonString = fixture(name);
  return jsonDecode(jsonString);
}
