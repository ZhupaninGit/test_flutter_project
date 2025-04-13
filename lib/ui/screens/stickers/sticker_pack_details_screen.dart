import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/data/models/sticker_pack.dart';
import 'package:test_project/ui/screens/stickers/stickers_view_model.dart';

class StickerPackDetailsScreen extends StatelessWidget {
  final StickerPack stickerPack;
  const StickerPackDetailsScreen({super.key, required this.stickerPack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderSection(stickerPack: stickerPack),
            const SizedBox(height: 12),
            const Text(
              "За правилами Viber, стікерпак може містити до 24 стікерів, але в Telegram та Однокласники кількість стікерів може бути більше!",
              style: TextStyle(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _StickersGrid(stickerPack: stickerPack),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final StickerPack stickerPack;
  const _HeaderSection({required this.stickerPack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _BannerImage(url: stickerPack.bannerPhotoUrl),
        const SizedBox(width: 12),
        Expanded(child: _StickerPackInfo(stickerPack: stickerPack)),
      ],
    );
  }
}

class _BannerImage extends StatelessWidget {
  final String url;
  const _BannerImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Stack(
          children: [
            Image.network(
              url,
              width: 120,
              height: 230,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Column(
                children: const [
                  _InfoIconRow(icon: Icons.remove_red_eye, value: "12"),
                  _InfoIconRow(icon: Icons.cloud_download, value: "55"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoIconRow extends StatelessWidget {
  final IconData icon;
  final String value;
  const _InfoIconRow({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(value, style: const TextStyle(color: Colors.white)),
        const SizedBox(width: 5),
        Icon(icon, color: Colors.white, size: 16),
      ],
    );
  }
}

class _StickerPackInfo extends StatelessWidget {
  final StickerPack stickerPack;
  const _StickerPackInfo({required this.stickerPack});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Назва стікерпака",
          style: TextStyle(color: Colors.white70, fontSize: 8),
        ),
        Text(
          stickerPack.name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 4)],
          ),
        ),
        const Text(
          "Автор стікерпака",
          style: TextStyle(color: Colors.white70, fontSize: 9),
        ),
        Text(
          stickerPack.author,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 4)],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            5,
            (index) => const Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(Icons.star_border_outlined,
                  color: Colors.amber, size: 22),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            _PlatformButton(
              label: "Viber",
              background: Colors.white,
              textColor: const Color.fromARGB(255, 208, 0, 255),
            ),
            _PlatformButton(
              label: "Telegram",
              background: Colors.blue,
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}

class _PlatformButton extends StatelessWidget {
  final String label;
  final Color background;
  final Color textColor;
  const _PlatformButton({
    required this.label,
    required this.background,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: textColor,
        ),
        child: Text(label),
      ),
    );
  }
}

class _StickersGrid extends StatelessWidget {
  final StickerPack stickerPack;
  const _StickersGrid({required this.stickerPack});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: stickerPack.stickersUrl.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _dialogBuilder(context, stickerPack.stickersUrl[index],
                stickerPack.name, stickerPack.author);
          },
          child: Image.network(
            stickerPack.stickersUrl[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Future<void> _dialogBuilder(
    BuildContext context,
    String url,
    String stickersName,
    String author,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: _AlertDialogContent(url, stickersName, author),
        );
      },
    );
  }
}

class _AlertDialogContent extends StatelessWidget {
  final String url;
  final String stickersName;
  final String author;

  const _AlertDialogContent(this.url, this.stickersName, this.author);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Image.network(url),
        const SizedBox(height: 12),
        Text(
          "Cтікер з набору: $stickersName",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Ви можете завантажити цей стікер собі на ваш пристрій і використовувати в будь-яких цілях, але не забудьте вказати автора цього стікерпака: $author!",
          style: const TextStyle(color: Colors.black45),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: () {
              context
                  .read<StickersViewModel>()
                  .onDownloadImageButtonPress(context, url);
            },
            child: const Text("ЗАВАНТАЖИТИ"),
          ),
        ),
      ],
    );
  }
}
