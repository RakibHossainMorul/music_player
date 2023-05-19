import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicController extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const MusicController({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shuffle_rounded),
          iconSize: 30,
          color: const Color(0xFFA7A9AC),
        ),
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          icon: const Icon(Icons.skip_previous_rounded),
          iconSize: 60,
          color: Colors.white,
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (!(playing ?? false)) {
              return IconButton(
                onPressed: audioPlayer.play,
                iconSize: 80,
                color: Colors.white,
                icon: const Icon(Icons.play_arrow_rounded),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                onPressed: audioPlayer.pause,
                iconSize: 80,
                color: Colors.white,
                icon: const Icon(Icons.pause_rounded),
              );
            }
            // IconButton
            return IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              iconSize: 80,
              color: Colors.white,
            );
          },
        ),
        IconButton(
          onPressed: audioPlayer.seekToNext,
          icon: const Icon(Icons.skip_next_rounded),
          iconSize: 60,
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.repeat_rounded),
          iconSize: 30,
          color: const Color(0xFFA7A9AC),
        ),
      ],
    );
  }
}
