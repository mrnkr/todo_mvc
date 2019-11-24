import 'package:meta/meta.dart';
import 'package:nanoid/non_secure/nanoid.dart';

@immutable
abstract class Identifiable {
  final String id;

  Identifiable({
    id,
  }) : id = id ?? nanoid();

  Identifiable.fromJson(Map data)
    : id = data['id'];
}
