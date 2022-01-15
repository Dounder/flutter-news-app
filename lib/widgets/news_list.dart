import 'package:flutter/material.dart';
import 'package:news_app/models/models.dart';
import 'package:news_app/theme/dark_theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int i) {
        return _News(news: news[i], index: i);
      },
    );
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;

  const _News({Key? key, required this.news, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _TopBarCard(news: news, index: index),
          _CardTitle(news: news),
          _CardImg(news: news),
          _CardBody(news: news),
          const _CardBtns(),
          const SizedBox(height: 20),
          const Divider()
        ],
      ),
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article news;
  final int index;

  const _TopBarCard({
    Key? key,
    required this.news,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}. ',
            style: TextStyle(color: myTheme.colorScheme.secondary),
          ),
          Text(
            '${news.source.name}. ',
            style: TextStyle(color: myTheme.colorScheme.secondary),
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article news;

  const _CardTitle({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Text(
        news.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CardImg extends StatelessWidget {
  final Article news;

  const _CardImg({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: news.urlToImage != null
            ? FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(news.urlToImage!))
            : const Image(image: AssetImage('assets/no-image.png')),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article news;

  const _CardBody({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(news.description ?? ''),
    );
  }
}

class _CardBtns extends StatelessWidget {
  const _CardBtns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: () {},
          child: const Icon(Icons.star_border_outlined),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: myTheme.colorScheme.secondary,
        ),
        const SizedBox(width: 10),
        MaterialButton(
          onPressed: () {},
          child: const Icon(Icons.more),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.indigo,
        ),
      ],
    );
  }
}
