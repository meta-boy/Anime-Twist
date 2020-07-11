// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:momentum/momentum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientDB extends MomentumService {
  SharedPreferences _sharedPreferences;

  Future<SharedPreferences> getByInstance() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  static Future<SharedPreferences> getByContext(BuildContext context) async {
    var service = Momentum.service<ClientDB>(context);
    service._sharedPreferences ??= await SharedPreferences.getInstance();
    return service._sharedPreferences;
  }
}
