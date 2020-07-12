import 'dart:convert';
import 'dart:io';

main(List<String> args) {
  
  final config = {
    'secret_key': args[0]
  };

  final filename = 'lib/.env.dart';
  File(filename).writeAsString('const environment = ${json.encode(config)};');
}
