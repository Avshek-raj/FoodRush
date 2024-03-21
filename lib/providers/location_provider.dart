import 'dart:math';


class LocationProvider {
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371.0; // Radius of the Earth in kilometers

    // Convert latitude and longitude from degrees to radians
    final latRad1 = radians(lat1);
    final lonRad1 = radians(lon1);
    final latRad2 = radians(lat2);
    final lonRad2 = radians(lon2);
    // Calculate differences in latitude and longitude
    final dLat = latRad2 - latRad1;
    final dLon = lonRad2 - lonRad1;

    // Haversine formula
    final a = pow(sin(dLat / 2), 2) +
        cos(latRad1) * cos(latRad2) * pow(sin(dLon / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate distance in kilometers
    final distance = earthRadius * c;
    return distance;
  }

  double radians(double degrees) {
    return degrees * (pi / 180);
  }

}
