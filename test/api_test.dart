import 'package:dsbmobile_api/dsbmobile_api.dart';
import 'package:test/test.dart';

void main() async {
  final username = '';
  final password = '';

  test('Test basic API', () async {
    final dsb = DSBMobile();
    dsb.login(username: username, password: password, locale: 'de');
    final nodes = await dsb.get();
    nodes.forEach(print);
  });

  test('Test DSBUtils', () async {
    final dsb = DSBMobile();
    dsb.login(username: username, password: password, locale: 'de');
    final nodes = await dsb.get();
    final plans = dsb.utils.getAllSubstitutionPlans(nodes, name: 'Pläne');

    /// Check if the plans have valid URLs.
    await for (final plan in plans) {
      expect(plan.htmlUrl, isNotNull);
      expect(plan.previewImageUrl, isNotNull);
    }
    expect(await plans.length, equals(2)); // Our plans have exactly 2 entries.

    /// I, myself, only have access to a DSB that does not include Timetables.
    /// Therefore, I cannot test this and will expect it to be empty.
    final timetables = dsb.utils.getAllTimetables(nodes, name: 'Timetables');
    expect(timetables, isEmpty);
  });
}
