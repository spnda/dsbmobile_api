import '../../dsbmobile_api.dart';

/// Represents a single substitution plan entry in the DSB database.
class SubstitutionPlan {
  final DSBMobileEntry _entry;

  const SubstitutionPlan({required DSBMobileEntry entry}) : _entry = entry;

  DSBMobileEntry get entry => _entry;

  String get title => _entry.title;

  String? get htmlUrl => _entry.detail;

  String? get previewImageUrl => _entry.previewImage;
}
