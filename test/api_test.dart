import 'package:dsbmobile_api/dsbmobile_api.dart';
import 'package:test/test.dart';

void main() async {
  final username = '';
  final password = '';

  test('Test basic API', () async {
    final dsb = DSBMobile();
    dsb.login(username: username, password: password);
    final nodes = await dsb.get();
    nodes.forEach(print);
  });
}
