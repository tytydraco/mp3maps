import 'package:open_route_service/open_route_service.dart';

/// Double formatting tools for [OpenRouteService].
extension DoubleFormattingTools on double {
  /// Return the value as a formatted duration string.
  String toDurationString() {
    if (this < 60) {
      final secondsRounded = round();
      return '$secondsRounded s';
    } else {
      final minutesRounded = (this / 60).round();
      return '$minutesRounded min';
    }
  }

  /// Return the value as meters converted into feet.
  double metersToFeet() {
    return this * 3.280839895;
  }

  /// Convert meters to imperial distance (ft, mi).
  String toImperialDistance() {
    final feet = metersToFeet();
    if (feet > 5280) {
      final miles = feet / 5280;
      final mileString = miles.toStringAsFixed(1);
      return '$mileString mi';
    }

    final feetRounded = feet.round();
    return '$feetRounded ft';
  }
}

/// [ORSProfile] formatting tools for [OpenRouteService].
extension ModeFormattingTools on ORSProfile {
  /// Return the mode name as a pretty string.
  String prettyName() {
    if (this == ORSProfile.cyclingRoad) return 'Biking';
    if (this == ORSProfile.drivingCar) return 'Driving';
    
    return 'Walking';
  }
}
