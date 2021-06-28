import 'package:moor/moor.dart';

class SearchRequests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
}
