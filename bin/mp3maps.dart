import 'dart:io';

import 'package:args/args.dart';
import 'package:mp3maps/mp3maps.dart';

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
    );
  return argParser;
}

Future<void> main(List<String> arguments) async {
  final argParser = _argParser();
  try {
    final results = argParser.parse(arguments);
    final apiKey = results['api-key'] as String;

    final mp3Maps = Mp3Maps(
      apiKey: apiKey,
      displayFromAddress: 'Home (Omaha, NE)',
      displayToAddress: 'CVS on U Street',
      fromLatitude: 41.296311,
      fromLongitude: -96.105027,
      toLatitude: 41.20210,
      toLongitude: -96.1374783,
    );

    final textDirections = await mp3Maps.getDirectionsAsText();
    print(textDirections);
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    stderr
      ..writeln(e.message)
      ..writeln()
      ..writeln(argParser.usage);
  }
}
