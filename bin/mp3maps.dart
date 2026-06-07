import 'dart:io';

import 'package:args/args.dart';
import 'package:mp3maps/mp3maps.dart';
import 'package:open_route_service/open_route_service.dart';

ArgParser _argParser() {
  final argParser = ArgParser();
  argParser
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
      callback: (value) {
        if (value) stdout.writeln(argParser.usage);
      },
    )
    ..addOption(
      'api-key',
      abbr: 'k',
      help: 'The Open Route Services API key.',
      mandatory: true,
    )
    ..addOption(
      'from-latitude',
      help: 'The origin latitude',
      mandatory: true,
    )
    ..addOption(
      'from-longitude',
      help: 'The origin longitude',
      mandatory: true,
    )
    ..addOption(
      'to-latitude',
      help: 'The destination latitude',
      mandatory: true,
    )
    ..addOption(
      'to-longitude',
      help: 'The destination longitude',
      mandatory: true,
    )
    ..addOption(
      'mode',
      abbr: 'm',
      help: 'The mode of transportation.',
      defaultsTo: 'walking',
      allowed: ['walking', 'biking', 'driving'],
    )
    ..addOption(
      'output',
      abbr: 'o',
      help: 'The output file path.',
      defaultsTo: 'directions.txt',
    );
  return argParser;
}

Future<void> main(List<String> arguments) async {
  final argParser = _argParser();
  try {
    final results = argParser.parse(arguments);
    final apiKey = results['api-key'] as String;
    final fromLatitude = double.parse(results['from-latitude'] as String);
    final fromLongitude = double.parse(results['from-longitude'] as String);
    final toLatitude = double.parse(results['to-latitude'] as String);
    final toLongitude = double.parse(results['to-longitude'] as String);
    final mode = results['mode'] as String;
    final output = results['output'] as String;

    var profile = ORSProfile.footWalking;
    switch (mode) {
      case 'walking':
        profile = ORSProfile.footWalking;
      case 'biking':
        profile = ORSProfile.cyclingRoad;
      case 'driving':
        profile = ORSProfile.drivingCar;
    }

    final mp3Maps = Mp3Maps(
      apiKey: apiKey,
      displayFromAddress: 'Home (Omaha, NE)',
      displayToAddress: 'CVS on U Street',
      fromLatitude: fromLatitude,
      fromLongitude: fromLongitude,
      toLatitude: toLatitude,
      toLongitude: toLongitude,
      profile: profile,
    );

    final textDirections = await mp3Maps.getDirectionsAsText();

    final outputFile = File(output);
    await outputFile.writeAsString(textDirections);
  } on Object catch (e) {
    stderr
      ..writeln(e.toString())
      ..writeln()
      ..writeln(argParser.usage);
  }
}
