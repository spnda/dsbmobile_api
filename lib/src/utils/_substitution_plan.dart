import '../../dsbmobile_api.dart';

/// Represents a single substitution plan entry in the DSB database.
class SubstitutionPlan {
  final String _title;
  final DSBMobileEntry _entry;

  const SubstitutionPlan({required DSBMobileEntry entry, required String title}) : _entry = entry, _title = title;

  DSBMobileEntry get entry => _entry;

  String get title => _title;

  String? get htmlUrl => _entry.detail;

  String? get previewImageUrl => _entry.previewImage;
}
