import 'package:flutter/foundation.dart';

class Transcaction {
  @required
  final String id;
  @required
  final String title;
  @required
  final double price;
  @required
  final DateTime date;
  Transcaction({this.id, this.title, this.price, this.date});
}
