import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/models/models.dart';

const _baseUrl = 'newsapi.org';
const _apiKey = 'a6f0ca77a5ac4ff6b6ae7e6107f3511b';
const _country = 'us';

class NewsService extends ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  bool _isLoading = true;

  List<CategoryModel> categories = [
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertainment'),
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.volleyballBall, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();

    for (var element in categories) {
      categoryArticles[element.name] = [];
    }

    getArticlesByCategory(_selectedCategory);
  }

  bool get isLoading => _isLoading;

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String val) {
    _selectedCategory = val;
    _isLoading = true;
    getArticlesByCategory(val);
    notifyListeners();
  }

  List<Article>? get getSelectedCategoryArticles =>
      categoryArticles[selectedCategory];

  getTopHeadlines() async {
    final uri = Uri.https(
      _baseUrl,
      '/v2/top-headlines',
      {'country': _country, 'apiKey': _apiKey},
    );
    // const url = '$_baseUrl/top-headlines?apiKey=$_apiKey&country=us';

    final resp = await http.get(uri);
    final newsResponse = NewsResponse.fromJson(resp.body);

    headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return categoryArticles[category];
    }

    final uri = Uri.https(
      _baseUrl,
      '/v2/top-headlines',
      {'country': _country, 'apiKey': _apiKey, 'category': category},
    );

    final resp = await http.get(uri);
    final newsResponse = NewsResponse.fromJson(resp.body);

    categoryArticles[category]?.addAll(newsResponse.articles);

    _isLoading = false;
    notifyListeners();
  }
}
