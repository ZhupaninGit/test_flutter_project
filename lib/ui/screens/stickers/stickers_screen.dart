import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/data/models/sticker_pack.dart';
import 'package:test_project/ui/screens/stickers/sticker_pack_details_screen.dart';
import 'package:test_project/ui/screens/stickers/stickers_view_model.dart';

class StickersScreen extends StatelessWidget {
  const StickersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stickerPacks = context.watch<StickersViewModel>().stickerPacks;

    return SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle("Найпопулярніші Стікерпаки"),
          SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: stickerPacks.length,
              itemBuilder: (context, index) => _StickerCard(
                stickerPack: stickerPacks[index],
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 16),
          _sectionTitle("Нові стікерпаки"),
          SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: stickerPacks.length,
              itemBuilder: (context, index) => _StickerCard(
                stickerPack: stickerPacks[index],
              ),
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 16),
          _sectionTitle("Категорії Стікерпаків"),
          SizedBox(height: 8),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            shrinkWrap: true,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
            children: List.generate(30, (index) => _CategoryCard("Аніме")),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.amber,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          shadows: [
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 1.0,
              color: Colors.black54,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _StickerCard extends StatelessWidget {
  final StickerPack stickerPack;
  const _StickerCard({required this.stickerPack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => StickerPackDetailsScreen(
              stickerPack: stickerPack,
            ),
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                stickerPack.bannerPhotoUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return const Center(
                    child: Icon(Icons.error),
                  );
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    stickerPack.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  const _CategoryCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF9E1FFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Icon(
            Icons.sunny,
            size: 48,
            color: Colors.white,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
