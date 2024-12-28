import 'package:SC3040_App/services/DatabaseService.dart';
import 'package:flutter/material.dart';
import 'package:openapi/api.dart';

class FiltersViewModel extends ChangeNotifier {
  final api_instance = ShowsApi();
  final genre_api = GenresApi();
  final TextEditingController showNameController = TextEditingController();
  List<Genre>? _genres;
  List<ShowType> _selectedShowTypes = [];
  List<String> _selectedCatalogs = [];
  List<String> _selectedGenres = [];
  RangeValues _yearRange = const RangeValues(2000, 2023);
  RangeValues _ratingRange = const RangeValues(60, 90);
  String?
      _orderBy; //rating, original_title, release_date, popularity_alltime, popularity_1year, popularity_1month, popularity_1week
  OrderDirection _orderDirection = OrderDirection.desc; //asc
  String _country = 'sg';
  SearchResult? _result;
  ShowType? _showType;
  final List<String> _serviceTypes = [
    'netflix',
    'prime',
    'disney',
    'apple',
    'mubi',
    'curiosity',
    'hotstar',
    'zee5'
  ];
  // String? _successMessage;
  String? _errorMessage;

  //getter methods
  List<ShowType> get selectedShowTypes => _selectedShowTypes;
  List<String> get selectedCatalogs => _selectedCatalogs;
  List<String> get selectedGenres => _selectedGenres;
  RangeValues get yearRange => _yearRange;
  RangeValues get ratingRange => _ratingRange;
  String? get orderBy => _orderBy;
  String get orderDirection => _orderDirection.value;
  String get country => _country;
  String? get errorMessage => _errorMessage;
  SearchResult? get result => _result;
  ShowType? get showType => _showType;
  List<Genre>? get genres => _genres;
  List<String> get serviceTypes => _serviceTypes;

  // String? get successMessage => _successMessage;

  void updateShowTypes(ShowType type, bool selected) {
    if (selected) {
      _selectedShowTypes.add(type);
    } else {
      _selectedShowTypes.remove(type);
    }

    if (_selectedShowTypes.length == 1) {
      _showType = _selectedShowTypes[0];
    } else {
      _showType = null;
    }
    notifyListeners();
  }

  void updateCatalogs(String catalog, bool selected) {
    if (selected) {
      _selectedCatalogs.add(catalog);
    } else {
      _selectedCatalogs.remove(catalog);
    }
    notifyListeners();
  }

  void updateGenres(String genre, bool selected) {
    if (selected) {
      _selectedGenres.add(genre);
    } else {
      _selectedGenres.remove(genre);
    }
    notifyListeners();
  }

  void updateYearRange(RangeValues values) {
    _yearRange = values;
    notifyListeners();
  }

  void updateRatingRange(RangeValues values) {
    _ratingRange = values;
    notifyListeners();
  }

  void updateOrderBy(String value) {
    _orderBy = value;
    notifyListeners();
  }

  void updateOrderDirection(String value) async {
    if (value == 'asc') {
      _orderDirection = OrderDirection.asc;
    } else {
      _orderDirection = OrderDirection.desc;
    }
    notifyListeners();
  }

  Future<bool> performFilter() async {
    try {
      _result = await api_instance.searchShowsByFilters(
        _country,
        catalogs: _selectedCatalogs,
        showType: showType,
        genres: _selectedGenres,
        genresRelation: 'or',
        yearMin: yearRange.start.toInt(),
        yearMax: yearRange.end.toInt(),
        ratingMin: ratingRange.start.toInt(),
        ratingMax: ratingRange.end.toInt(),
        keyword: showNameController.text,
        orderBy: _orderBy,
        orderDirection: _orderDirection,
      );
      return true;
    } catch (e) {
      _errorMessage = "Unable to access database";
      return false;
    } finally {
      notifyListeners();
    }
  }

  void clearFilter() {
    showNameController.clear();
    _selectedShowTypes = [];
    _selectedGenres = [];
    _yearRange = const RangeValues(2000, 2023);
    _ratingRange = const RangeValues(60, 90);
    _orderBy = null;
    _orderDirection = OrderDirection.desc;
    _showType = null;
    _result = null;
    _selectedCatalogs = [];
    _showType = null;
  }

  Future<dynamic>? nextPage() async {
    if (_result?.hasMore == false) {
      return;
    }
    try {
      _result = await api_instance.searchShowsByFilters(_country,
          catalogs: _selectedCatalogs,
          showType: showType,
          genres: _selectedGenres,
          genresRelation: 'or',
          yearMin: yearRange.start.toInt(),
          yearMax: yearRange.end.toInt(),
          ratingMin: ratingRange.start.toInt(),
          ratingMax: ratingRange.end.toInt(),
          keyword: showNameController.text,
          orderBy: _orderBy,
          orderDirection: _orderDirection,
          cursor: _result?.nextCursor);

      return true;
    } catch (e) {
      _errorMessage = "Unable to access database";
      return false;
    } finally {
      notifyListeners();
    }
  }

  Future<List<Genre>?> getGenres() async {
    try {
      _genres = await genre_api.getGenres();
    } catch (e) {
      _errorMessage = "Unable to access Database";
    } finally {
      notifyListeners();
    }
    return _genres;
  }
}
