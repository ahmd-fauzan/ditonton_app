import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/tv_datasource/tv_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVLocalDataSourceImpl dataSource;
  late MockTvDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockTvDatabaseHelper();
    dataSource = TVLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVWatchlist(testTVTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistTV(testTVTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVWatchlist(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistTV(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    final tId = 1;

    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVWatchlist(testTVTable))
          .thenAnswer((_) async => tId);
      // act
      final result = await dataSource.removeWatchlistTV(testTVTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVWatchlist(testTVTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistTV(testTVTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Detail By Id', () {
    final tId = 1;

    test('should return TV Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTVById(tId))
          .thenAnswer((_) async => testTVMap);
      // act
      final result = await dataSource.getByIdTV(tId);
      // assert
      expect(result, testTVTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getByIdTV(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist TV', () {
    test('should return list of TVTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getTVWatchlist())
          .thenAnswer((_) async => [testTVMap]);
      // act
      final result = await dataSource.getWatchlistTV();
      // assert
      expect(result, [testTVTable]);
    });
  });
}
