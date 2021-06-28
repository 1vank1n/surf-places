import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/data/database/tables/search_request.dart';

part 'database.g.dart';

@UseMoor(tables: [SearchRequests])
class AppDB extends _$AppDB {
  AppDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // SearchRequests
  Future<List<SearchRequest>> get allSearchRequestEntities => select(searchRequests).get();
  Future<List<String>> allSearchRequestStrings() async {
    final searchRequests = await allSearchRequestEntities;
    return searchRequests.map((sr) => sr.title).toList();
  }

  Future<int> saveSearchRequest(SearchRequestsCompanion searchRequest) {
    return into(searchRequests).insert(searchRequest);
  }

  Future<int> deleteSearchRequest(int searchRequestId) {
    return (delete(searchRequests)..where((tbl) => tbl.id.equals(searchRequestId))).go();
  }

  Future<int> clearSearchRequest() {
    return delete(searchRequests).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final file = File(join(dbPath.path, 'places.sql'));
    return VmDatabase(file);
  });
}
