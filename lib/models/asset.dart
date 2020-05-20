
import 'package:equatable/equatable.dart';
import 'package:flutter_example/utils/json_helper.dart';

class Asset extends Equatable {
  final String reference;
  final String name;

  Asset(this.reference, this.name);

  static Asset fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    String assetReference = JsonHelper.asString(json["assetReference"]);
    String name = JsonHelper.asString(json["name"]);
    return Asset(assetReference, name);
  }

  @override
  List<Object> get props => [reference, name];

}
