import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tv_series/data/datasources/db/tv_database_helper.dart';
import 'package:tv_series/data/datasources/tv_datasource/tv_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_datasource/tv_remote_data_source.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

@GenerateMocks([
  TVRepository,
  TVRemoteDataSource,
  TVLocalDataSource,
  TvDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
