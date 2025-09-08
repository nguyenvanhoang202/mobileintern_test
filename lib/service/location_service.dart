import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/location_model.dart';

class LocationService {
  final String apiKey = "pk.b4ba69f43d1c654ba12558234c345e57";

  Future<List<LocationModel>> searchLocation(String query) async {
    final url = Uri.parse(
        "https://us1.locationiq.com/v1/search.php"
            "?key=$apiKey"
            "&q=$query"
            "&format=json"
            "&accept-language=vi"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => LocationModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch location");
    }
  }
}