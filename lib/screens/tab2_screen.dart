import 'package:flutter/material.dart';
import 'package:news_app/models/models.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/theme/dark_theme.dart';
import 'package:news_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _CategoryList(),
            if (!service.isLoading)
              Expanded(
                  child: NewsList(news: service.getSelectedCategoryArticles!)),
            if (service.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 85,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int i) {
          final cName = categories[i].name;

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _CategoryBtn(category: categories[i]),
                const SizedBox(height: 5),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryBtn extends StatelessWidget {
  final CategoryModel category;

  const _CategoryBtn({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);

    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: newsService.selectedCategory == category.name
              ? myTheme.colorScheme.secondary
              : Colors.white,
        ),
        child: Icon(
          category.icon,
          color: newsService.selectedCategory == category.name
              ? Colors.white
              : Colors.black54,
        ),
      ),
    );
  }
}
