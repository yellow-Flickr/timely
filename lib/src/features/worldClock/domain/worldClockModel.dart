class WorldClock {
    WorldClock({
        required this.countries,
    });

    final List<Country> countries;

    WorldClock copyWith({
        List<Country>? countries,
    }) {
        return WorldClock(
            countries: countries ?? this.countries,
        );
    }

    factory WorldClock.fromJson(Map<String, dynamic> json){ 
        return WorldClock(
            countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
        );
    }

}

class Country {
    Country({
        required this.name,
        required this.timezoneOffset,
        required this.latlong,
    });

    final String name;
    final double timezoneOffset;
    final String latlong;

    Country copyWith({
        String? name,
        double? timezoneOffset,
        String? latlong,
    }) {
        return Country(
            name: name ?? this.name,
            timezoneOffset: timezoneOffset ?? this.timezoneOffset,
            latlong: latlong ?? this.latlong,
        );
    }

    factory Country.fromJson(Map<String, dynamic> json){ 
        return Country(
            name: json["name"] ?? "",
            timezoneOffset: json["timezone_offset"] ?? 0.0,
            latlong: json["latlong"] ?? "",
        );
    }

}
