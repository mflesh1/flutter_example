import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JsonHelper {

  static String asString(dynamic value) {
    if (value == null) {
      return null;
    }
    return value.toString();
  }

  static bool asBool(dynamic value) {
    if (value == null) {
      return false;
    }
    if (value is String) {
      return value.toString() == "true";
    }
    if (value is bool) {
      return value;
    }
    return false;
  }

  static int asInt(dynamic value) {

    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static double asDouble(dynamic value) {

    if (value == null) {
      return null;
    }
    if (value is double) {
      return value;
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  static DateTime asDateTime(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      String asString = value.toString();
      return DateTime.parse(asString);
    } on FormatException catch (_) {
      return null;
    }
  }

  static TimeOfDay asTimeOfDay(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      String asString = value.toString();
      DateTime dateTime =  DateFormat.Hms().parse(asString);
      return TimeOfDay.fromDateTime(dateTime);
    } on FormatException catch (_) {
      return null;
    }
  }

}