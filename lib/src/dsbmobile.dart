import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '_dsbexception.dart';
import 'node.dart';

/// API entrypoint for all functionality for DSBMobile.
///
/// This only enables getting the data, it does not cache
/// or format any data itself
class DSBMobile {
  final Map<String, String> _args = {};

  DSBMobile();

  /// Login.
  ///
  /// [locale] should be any ISO 639-1 language code. If not
  /// specified, this will default to [Intl.defaultLocale]
  /// or just 'en'.
  ///
  /// Does not call any API directly, and is therefore not
  /// async.
  void login(
      {required String username, required String password, String? locale}) {
    _args.clear();
    _args.addAll({
      'UserId': username,
      'UserPw': password,
      'Language': locale ?? Intl.defaultLocale ?? 'en',
      'Device': 'Nexus 4',
      'AppId': Uuid().v4(),
      'AppVersion': '2.5.9',
      'OsVersion': '27 8.1.0',
      'PushId': '',
      'BundleId': 'de.heinekingmedia.dsbmobile',
    });
  }

  /// Get's a list of root nodes with various data from the DSB data server.
  ///
  /// May throw [DSBException] if [login] has not been called or if the server
  /// returned unreadable data.
  Future<List<DSBMobileNode>> get({DateTime? requestTime}) async {
    if (_args.isEmpty) throw DSBException();

    requestTime ??= DateTime.now();
    var date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(DateTime.now()) +
        '+0000'; // For some reason their API wants this.

    var argCopy = _args;
    argCopy.putIfAbsent('Date', () => date);
    argCopy.putIfAbsent('LastUpdate', () => date);

    final requestBody = <String, dynamic>{
      'req': {
        'DataType': 1,
        'Data': base64.encode(gzip.encode(utf8.encode(json.encode(argCopy)))),
      }
    };

    final response = await http.post(
      Uri.parse('https://www.dsbmobile.de/JsonHandler.ashx/GetData'),
      headers: {'content-type': 'application/json;charset=utf-8'},
      body: json.encode(requestBody),
    );
    dynamic d = json.decode(response.body)['d'];
    if (d == null) throw DSBException();
    final result = json.decode(utf8.decode(gzip.decode(base64.decode(d))))
        as Map<String, dynamic>;
    if (result.isEmpty || result['Resultcode'] != 0) throw DSBException();

    if (result['ResultMenuItems']! is Map) return [];
    return <DSBMobileNode>[
      ...result['ResultMenuItems'].map((f) => DSBMobileNode.parse(f))
    ];
  }
}
