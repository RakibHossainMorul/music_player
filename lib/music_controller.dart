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
          iconSize: 50,
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
                iconSize: 70,
                color: Colors.white,
                icon: Image.asset('assets/play_button.png'),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                onPressed: audioPlayer.pause,
                iconSize: 70,
                color: Colors.white,
                icon: const Icon(Icons.pause_rounded),
              );
            }
            // IconButton onPressed cannot be null, so disable the button if
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
          iconSize: 50,
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
