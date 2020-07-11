import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final config = {
    'secret_key': Platform.environment['ANIME_TWIST_SECRET'],
  };

  final filename = 'lib/.env.dart';
  File(filename).writeAsString('const environment = ${json.encode(config)};');
}