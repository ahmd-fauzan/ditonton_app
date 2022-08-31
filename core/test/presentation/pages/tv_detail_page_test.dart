import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv_entities/tv.dart';
import 'package:core/presentation/pages/tv_series_page/tv_detail_page.dart';
import 'package:core/presentation/provider/tv_series_provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TVDetailNotifier])
void main() {
  late MockTVDetailNotifier notifier;

  setUp(() {
    notifier = MockTVDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TVDetailNotifier>.value(
      value: notifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(notifier.state).thenReturn(RequestState.Loaded);
    when(notifier.tvDetail).thenReturn(testTVDetail);
    when(notifier.recommendationState).thenReturn(RequestState.Loaded);
    when(notifier.tvRecommendations).thenReturn(<TV>[]);
    when(notifier.isAddedtoWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(notifier.state).thenReturn(RequestState.Loaded);
    when(notifier.tvDetail).thenReturn(testTVDetail);
    when(notifier.recommendationState).thenReturn(RequestState.Loaded);
    when(notifier.tvRecommendations).thenReturn(<TV>[]);
    when(notifier.isAddedtoWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(notifier.state).thenReturn(RequestState.Loaded);
    when(notifier.tvDetail).thenReturn(testTVDetail);
    when(notifier.recommendationState).thenReturn(RequestState.Loaded);
    when(notifier.tvRecommendations).thenReturn(<TV>[]);
    when(notifier.isAddedtoWatchlist).thenReturn(false);
    when(notifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(notifier.state).thenReturn(RequestState.Loaded);
    when(notifier.tvDetail).thenReturn(testTVDetail);
    when(notifier.recommendationState).thenReturn(RequestState.Loaded);
    when(notifier.tvRecommendations).thenReturn(<TV>[]);
    when(notifier.isAddedtoWatchlist).thenReturn(false);
    when(notifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
