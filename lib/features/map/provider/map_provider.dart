import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:ota_test/features/map/model/search_result.dart';

enum MapSearchState { idle, loading, loaded, error }

class MapProvider extends ChangeNotifier {
  // Default center: India
  LatLng _center = const LatLng(20.5937, 78.9629);
  double _zoom = 5.0;

  List<SearchResult> _searchResults = [];
  SearchResult? _selectedResult;
  MapSearchState _searchState = MapSearchState.idle;
  String? _errorMessage;

  LatLng get center => _center;
  double get zoom => _zoom;
  List<SearchResult> get searchResults => _searchResults;
  SearchResult? get selectedResult => _selectedResult;
  MapSearchState get searchState => _searchState;
  String? get errorMessage => _errorMessage;

  Future<void> searchLocation(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      _searchState = MapSearchState.idle;
      notifyListeners();
      return;
    }

    _searchState = MapSearchState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
        'q': query,
        'format': 'json',
        'limit': '5',
      });

      final response = await http.get(
        uri,
        headers: {'User-Agent': 'ota_test_flutter_app'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _searchResults =
            data.map((e) => SearchResult.fromJson(e)).toList();
        _searchState = MapSearchState.loaded;
      } else {
        _errorMessage = 'Search failed (${response.statusCode})';
        _searchState = MapSearchState.error;
      }
    } catch (e) {
      _errorMessage = 'No internet connection';
      _searchState = MapSearchState.error;
    }

    notifyListeners();
  }

  void selectResult(SearchResult result) {
    _selectedResult = result;
    _center = LatLng(result.lat, result.lon);
    _zoom = 14.0;
    _searchResults = [];
    _searchState = MapSearchState.idle;
    notifyListeners();
  }

  void clearSearch() {
    _searchResults = [];
    _searchState = MapSearchState.idle;
    _errorMessage = null;
    notifyListeners();
  }
}
