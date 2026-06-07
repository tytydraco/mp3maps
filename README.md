# mp3maps

Mapping tools for MP3 players.

# Requirements

- Dart SDK
- Open Route Services API key.

# Usage

`dart bin/mp3maps.dart <args>`

```
-h, --help                          Print this usage information.
-k, --api-key (mandatory)           The Open Route Services API key.
    --from-name (mandatory)         The plain text origin location name.
    --to-name (mandatory)           The plain text destination location name.
    --from-latitude (mandatory)     The origin latitude
    --from-longitude (mandatory)    The origin longitude
    --to-latitude (mandatory)       The destination latitude
    --to-longitude (mandatory)      The destination longitude
-m, --mode                          The mode of transportation.
                                    [walking (default), biking, driving]
-r, --[no-]roundtrip                Generate directions for the route back to the origin.
-o, --output                        The output file path.
                                    (defaults to "directions.txt")
```