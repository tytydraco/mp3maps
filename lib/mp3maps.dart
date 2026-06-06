import 'package:mp3maps/src/text/gen_final_text.dart';
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

  /// Return directions as text instructions.
  Future<String> getDirectionsAsText() async {
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

    return generateFinalText(displayFromAddress, displayToAddress, steps);
  }
}
