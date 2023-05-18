import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MusicPlayerData extends StatelessWidget {
  final String imageURL;
  final String title;
  final String artist;
  const MusicPlayerData(
      {super.key,
      required this.imageURL,
      required this.title,
      required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
                offset: Offset(2, 4),
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageURL,
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          artist,
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
