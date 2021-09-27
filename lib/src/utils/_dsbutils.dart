import '../../dsbmobile_api.dart';
import '_substitution_plan.dart';

class DSBUtils {
  /// Get's a stream of all substitution plans from the given list of nodes. The [name]
  /// parameter is used to filter the returned data. If the entries title does not
  /// equal [name], it is not yielded.
  ///
  /// WARN: This might be a very specific for my use-case and will not work for
  /// everybody, but it's gonna be here anyway as a reference implementation for this.
  Stream<SubstitutionPlan> getAllSubstitutionPlans(List<DSBMobileNode> nodes,
      {required String name}) async* {
    for (final node in nodes) {
      for (final innerNode in node.children) {
        if (innerNode.root == null) continue;

        for (final child in innerNode.root!.children) {
          for (final plan in child.children) {
            yield SubstitutionPlan(entry: plan);
          }
        }
      }
    }
  }

  /// Get's a stream of all timetables. The [name] parameter is used to filter the returned data.
  /// If the entries title does not equal [name], it is not yielded.
  ///
  /// Adapted version of https://github.com/nerrixDE/DSBApi/blob/b8063e5388e59060ac0b4ada879a747a915a1d97/dsbapi/__init__.py#L144,
  /// not tested personally.
  Stream<Timetable> getAllTimetables(List<DSBMobileNode> nodes,
      {required String name}) async* {
    for (final node in nodes) {
      for (final innerNode in node.children) {
        if (innerNode.root == null) continue;

        for (final child in innerNode.root!.children) {
          if (child.title != name) continue;

          for (final table in child.children) {
            yield Timetable(entry: table);
          }
        }
      }
    }
  }
}
