import 'package:open_route_service/open_route_service.dart';

/// Enum for the type field of a [DirectionRouteSegmentStep].
enum StepType {
  /// Turn left.
  left(0, 'L'),

  /// Turn right.
  right(1, 'R'),

  /// Turn sharp left.
  sharpLeft(2, 'SHL'),

  /// Turn sharp right.
  sharpRight(3, 'SHR'),

  /// Turn slight left.
  slightLeft(4, 'SLL'),

  /// Turn slight right.
  slightRight(5, 'SLR'),

  /// Continue straight.
  straight(6, 'STR'),

  /// Enter a roundabout.
  enterRoundabout(7, '>RB'),

  /// Exit a roundabout.
  exitRoundabout(8, 'RB>'),

  /// Make a U-turn.
  uTurn(9, 'UTR'),

  /// Arrive at the destination.
  goal(10, 'ARR'),

  /// Start the route.
  depart(11, 'DEP'),

  /// Keep left.
  keepLeft(12, 'KL'),

  /// Keep right.
  keepRight(13, 'KR'),

  /// Unrecognized instruction type.
  unknown(-1, '?');

  const StepType(this.value, this.shorthand);

  /// The 0-indexed ORS instruction type value.
  final int value;

  /// The compact shorthand used in text directions.
  final String shorthand;

  /// Returns the [StepType] for an ORS step [value], or [unknown] if
  /// unrecognized.
  static StepType fromValue(int value) => values.firstWhere(
        (type) => type.value == value,
        orElse: () => unknown,
      );
}
