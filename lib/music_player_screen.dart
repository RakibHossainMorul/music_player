import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:music_player/music_controller.dart";
import "package:music_player/music_player_data.dart";
import "package:rxdart/rxdart.dart";
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import "controller.dart";
import 'package:just_audio_background/just_audio_background.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;

  //Adding Audio source which could play in the app
  final _playList = ConcatenatingAudioSource(children: [
    AudioSource.uri(
      Uri.parse(
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'),
      tag: MediaItem(
        id: '1',
        artist: 'James',
        title: 'Song name',
        artUri: Uri.parse('https://picsum.photos/id/237/200/300'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'),
      tag: MediaItem(
        id: '2',
        artist: 'James',
        title: 'Song name',
        artUri: Uri.parse('https://picsum.photos/id/237/200/300'),
      ),
    ),
    AudioSource.uri(
      Uri.parse(
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3'),
      tag: MediaItem(
        id: '3',
        artist: 'James',
        title: 'Song name',
        artUri: Uri.parse('https://picsum.photos/id/237/200/300'),
      ),
    ),
  ]);

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playList);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new)), // IconButton

          centerTitle: true,
          title: const Text("Music Player App"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: _audioPlayer.sequenceStateStream,
                  builder: ((context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) {
                      return const SizedBox();
                    }
                    final data = state!.currentSource!.tag as MediaItem;
                    return MusicPlayerData(
                        imageURL: data.artUri.toString(),
                        title: data.title.toString(),
                        artist: data.artist.toString());
                  })),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: ((context, snapshot) {
                  final positionData = snapshot.data;
                  return ProgressBar(
                    barHeight: 8,
                    baseBarColor: Colors.grey[600],
                    bufferedBarColor: Colors.grey,
                    progressBarColor: Colors.red,
                    thumbColor: Colors.red,
                    timeLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    progress: positionData?.position ?? Duration.zero,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: positionData?.duration ?? Duration.zero,
                    onSeek: _audioPlayer.seek,
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(child: MusicController(audioPlayer: _audioPlayer)),
            ],
          ),
        ),
      ),
    );
  }
}
