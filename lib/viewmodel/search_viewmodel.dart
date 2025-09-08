import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/location_model.dart';
import '../service/location_service.dart';

class SearchViewModel extends ChangeNotifier {
  final LocationService _service = LocationService();
  Timer? _debounce;

  String _query = "";

  String get query => _query;

  List<LocationModel> _results = [];

  List<LocationModel> get results => _results;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void onQueryChanged(String value) {
    _query = value;

    // Cancel timer cũ
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(seconds: 1), () async {
      if (_query.trim().isEmpty) {
        _results = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      _isLoading = true;
      notifyListeners();

      try {
        final res = await _service.searchLocation(_query);
        _results = res;
      } catch (_) {
        _results = [];
      }

      _isLoading = false;
      notifyListeners();
    });
  }

  void clearQuery() {
    _query = "";
    _results = [];
    notifyListeners();
  }

  Future<void> openInGoogleMaps(String lat, String lon) async {
    final webUrl = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&destination=$lat,$lon",
    );
    try {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint(" Không mở được Google Maps: $e");
    }
  }
}
