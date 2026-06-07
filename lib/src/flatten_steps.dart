import 'package:open_route_service/open_route_service.dart';

/// Flatten a list of steps.
class FlattenSteps {
  /// Creates a new [FlattenSteps].
  FlattenSteps({
    required this.steps,
  });

  /// The steps to flatten.
  final List<DirectionRouteSegmentStep> steps;

  /// Return the flattened the steps.
  List<DirectionRouteSegmentStep> flatten() {
    final result = <DirectionRouteSegmentStep>[];

    for (final step in steps) {
      if (result.isEmpty || step.name == '-') {
        result.add(step);
        continue;
      }

      if (result.last.name == step.name) {
        final mergedStep = DirectionRouteSegmentStep(
          distance: result.last.distance + step.distance,
          duration: result.last.duration + step.duration,
          type: result.last.type,
          instruction: result.last.instruction,
          name: result.last.name,
          wayPoints: result.last.wayPoints,
        );

        result
          ..removeLast()
          ..add(mergedStep);

        continue;
      }

      result.add(step);
    }

    return result;
  }
}
