import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

// @GenerateMocks([PopularTVNotifier])
void main() {
  // late MockPopularTVNotifier notifier;

  // setUp(() {
  //   notifier = MockPopularTVNotifier();
  // });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<PopularTVNotifier>.value(
  //     value: notifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }

  // testWidgets('Page should display center progress bar when loading',
  //     (WidgetTester tester) async {
  //   when(notifier.state).thenReturn(RequestState.Loading);

  //   final progressBarFinder = find.byType(CircularProgressIndicator);
  //   final centerFinder = find.byType(Center);

  //   await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

  //   expect(centerFinder, findsOneWidget);
  //   expect(progressBarFinder, findsOneWidget);
  // });

  // testWidgets('Page should display ListView when data is loaded',
  //     (WidgetTester tester) async {
  //   when(notifier.state).thenReturn(RequestState.Loaded);
  //   when(notifier.tvList).thenReturn(<TV>[]);

  //   final listViewFinder = find.byType(ListView);

  //   await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

  //   expect(listViewFinder, findsOneWidget);
  // });

  // testWidgets('Page should display text with message when Error',
  //     (WidgetTester tester) async {
  //   when(notifier.state).thenReturn(RequestState.Error);
  //   when(notifier.message).thenReturn('Error message');

  //   final textFinder = find.byKey(Key('error_message'));

  //   await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

  //   expect(textFinder, findsOneWidget);
  // });
}
