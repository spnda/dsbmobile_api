import '../../dsbmobile_api.dart';

/// Represents a single timetable entry in the DSB database.
///
/// Currently is missing many features, as I cannot test any timetable
/// related functionality myself.
class Timetable {
  final DSBMobileEntry _entry;

  const Timetable({required DSBMobileEntry entry}) : _entry = entry;

  DSBMobileEntry get entry => _entry;

  String? get previewImageUrl => _entry.previewImage;
}
