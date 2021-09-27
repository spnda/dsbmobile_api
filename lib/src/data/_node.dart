import '_entry.dart';

class DSBMobileNode {
  /// The index of this entry in the parent list.
  int index;

  int newCount;

  /// Link to the icon of this node.
  String? iconLink;

  /// The title of this node.
  String title;

  /// The method that created this node.
  String? methodName;

  bool saveLastState;

  DSBMobileEntry? root;
  List<DSBMobileNode> children = [];

  DSBMobileNode._()
      : index = 0,
        newCount = 0,
        title = '',
        saveLastState = false;

  factory DSBMobileNode.parse(Map<String, dynamic> json) {
    final node = DSBMobileNode._();
    node.index = json['Index'];
    node.iconLink = json['IconLink'];
    node.title = json['Title'];
    node.methodName = json['MethodName'];
    node.newCount = json['NewCount'];
    node.saveLastState = json['SaveLastState'];
    if (json['Root'] != null) {
      node.root = DSBMobileEntry.parse(json['Root']);
    }
    for (final entry in (json['Childs'] ?? [])) {
      node.children.add(DSBMobileNode.parse(entry));
    }

    return node;
  }
}
