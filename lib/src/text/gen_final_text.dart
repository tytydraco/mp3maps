import 'package:mp3maps/src/flatten/flatten_steps.dart';
import 'package:mp3maps/src/formatting/formatting_tools.dart';
import 'package:open_route_service/open_route_service.dart';

String _compactDirection(int type) {
  switch (type) {
    case 0:
      return 'L';
    case 1:
      return 'R';
    case 2:
      return 'SHL';
    case 3:
      return 'SHR';
    case 4:
      return 'SLL';
    case 5:
      return 'SLR';
    case 6:
      return 'STR';
    case 7:
      return '>RB';
    case 8:
      return 'RB>';
    case 9:
      return 'UTR';
    case 10:
      return 'ARR';
    case 11:
      return 'DEP';
    case 12:
      return 'KL';
    case 13:
      return 'KR';
    default:
      return '?';
  }
}

/// Reduce directions into compact instructions.
String _compactTextInstruction(DirectionRouteSegmentStep step) {
  final directionString = _compactDirection(step.type).padLeft(3);
  final distanceFtString = step.distance.toImperialDistance();

  return '[$directionString] ${step.name} in $distanceFtString';
}

/// Generate a full text output for text directions.
String generateFinalText(
  String fromAddress,
  String toAddress,
  List<DirectionRouteSegmentStep> steps,
) {
  final flattenedSteps = FlattenSteps(steps: steps).flatten();
  // final flattenedSteps = _flattenSteps(steps);
  final stepsFormatted = flattenedSteps
      .where((step) => [10, 11].contains(step.type) || step.name != '-')
      .map(_compactTextInstruction)
      .join('\n');

  return '''
FROM: $fromAddress
TO: $toAddress
---------------

$stepsFormatted''';
}
