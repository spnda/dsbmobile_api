class DSBMobileEntry {
  /// The index of this entry in the parent list.
  int index;

  /// Possibly the content type of this entry.
  int conType;

  /// Possibly the priority of this entry.
  int prio;

  /// The UUID of this entry.
  String id;

  /// The date that this entry was published.
  String date;

  /// The title of this entry.
  String title;

  /// A optional description of this entry.
  String? detail;

  /// Link to a image preview of this entry.
  String? _preview;

  List<DSBMobileEntry> children = [];

  DSBMobileEntry._()
      : index = 0,
        conType = 0,
        prio = 0,
        id = '',
        date = '',
        title = '';

  factory DSBMobileEntry.parse(Map<String, dynamic> json) {
    final entry = DSBMobileEntry._();
    entry.index = json['Index'];
    entry.conType = json['ConType'];
    entry.prio = json['Prio'];
    entry.title = json['Title'];
    entry.detail = json['Detail'];
    entry._preview = json['Preview'];
    for (final child in (json['Childs'] ?? [])) {
      entry.children.add(DSBMobileEntry.parse(child));
    }
    return entry;
  }

  /// Gets this news items release time as a DateTime object.
  /// Throws a [FormatException] if the date string cannot be parsed
  DateTime get getDateTime => DateTime.parse(date);

  String get previewImage => 'https://dsbmobile.de/data/$_preview';
}
