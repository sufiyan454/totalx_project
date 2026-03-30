

import 'package:flutter/material.dart';
import 'package:totakx_project/models/user_model.dart';

class UserProvider extends ChangeNotifier {
   List<UserModel> _all = [];
  List<UserModel> _display = [];

  List<UserModel> get users => _display;

  int page = 0;
  int limit = 10;

  void addUser(UserModel user) {
    _all.add(user);
    refresh();
  }

  void refresh() {
    _display = [];
    page = 0;
    loadMore();
  }

  void loadMore() {
    int start = page * limit;
    if (start >= _all.length) return;

    int end = start + limit;

    _display.addAll(
      _all.sublist(start, end > _all.length ? _all.length : end),
    );

    page++;
    notifyListeners();
  }

  void search(String q) {
    _display = _all.where((u) {
      return u.name.toLowerCase().contains(q.toLowerCase()) ||
          u.phone.contains(q);
    }).toList();
    notifyListeners();
  }

  void sortOlder() {
    _all.sort((a, b) => b.age.compareTo(a.age));
    refresh();
  }

  void sortYounger() {
    _all.sort((a, b) => a.age.compareTo(b.age));
    refresh();
  }
}