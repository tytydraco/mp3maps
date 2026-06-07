import 'package:mp3maps/src/flatten_steps.dart';
import 'package:mp3maps/src/formatting_tools.dart';
import 'package:open_route_service/open_route_service.dart';

/// Mapping tools for MP3 players.
class Mp3Maps {
  /// Creates a new [Mp3Maps].
  Mp3Maps({
    required this.apiKey,
    required this.displayFromAddress,
    required this.displayToAddress,
    required this.fromLatitude,
    required this.fromLongitude,
    required this.toLatitude,
    required this.toLongitude,
    this.profile = ORSProfile.footWalking,
  });

  /// The Open Route Services API key.
  final String apiKey;

  /// The display name for the origin address.
  final String displayFromAddress;

  /// The display name for the destination address.
  final String displayToAddress;

  /// The origin latitude.
  final double fromLatitude;

  /// The origin longitude.
  final double fromLongitude;

  /// The destination latitude.
  final double toLatitude;

  /// The destination longitude.
  final double toLongitude;

  /// The profile to use.
  final ORSProfile profile;

  /// Open Route Service.
  late final ors = OpenRouteService(apiKey: apiKey);

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
    final directionString = _compactDirection(step.type);
    final distanceFtString = step.distance.toImperialDistance();
    return '[$directionString] ${step.name} in $distanceFtString';
  }

  /// Generate a full text output for text directions.
  String _generateFinalText(
    String fromAddress,
    String toAddress,
    List<DirectionRouteSegmentStep> steps,
  ) {
    final flattenedSteps = FlattenSteps(steps: steps).flatten();
    final stepsFormatted = flattenedSteps
        .map(_compactTextInstruction)
        .join('\n');

    return '''
FROM: $fromAddress
TO: $toAddress
MODE: ${profile.prettyName()}

$stepsFormatted''';
  }

  /// Return directions as text instructions.
  Future<String> generate() async {
    final result = await ors.directionsMultiRouteDataPost(
      coordinates: [
        ORSCoordinate(latitude: fromLatitude, longitude: fromLongitude),
        ORSCoordinate(latitude: toLatitude, longitude: toLongitude),
      ],
      profileOverride: profile,
      roundaboutExits: true,
    );

    final route = result.first;
    final segment = route.segments.first;
    final steps = segment.steps;

    return _generateFinalText(displayFromAddress, displayToAddress, steps);
  }
}
