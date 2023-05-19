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
            child: Image.asset(
              'assets/image1.png',
              height: 350,
              width: 350,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.white,
                      )),
                ],
              ),
              Text(
                artist,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
