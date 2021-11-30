import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ThreeData with ChangeNotifier {
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errormsg = '';


  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errormsg => _errormsg;

  Future<void> get fetchCardata async {
    final response = await get(Uri.parse(
        'https://shubh760.github.io/jsonhost/online-json-editor.JSON%20(2).json'));
    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body);
        _error = false;
      } catch (e) {
        _error = true;
        _errormsg = e.toString();
        _map = {};
      }
      notifyListeners();
    } else {
      _error = true;
      _errormsg = 'Error: could be your internet connection';
      _map = {};
    }
    notifyListeners();
  }

  void initialvalue() {
    _error = false;
    _errormsg = '';
    _map = {};
    notifyListeners();
  }
}
