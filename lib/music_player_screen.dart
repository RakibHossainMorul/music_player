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
  bool _dropDownClick = true;
  //Adding dropdown button

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
          backgroundColor: const Color(0xFF101223),
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new_rounded)), // IconButton

          centerTitle: true,
          title: const Text("Playing Music"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
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
                        baseBarColor: const Color(0xFF494254),
                        bufferedBarColor: const Color(0xFF5A5A5A),
                        progressBarColor: const Color(0xFF5A5A5A),
                        thumbColor: Colors.white,
                        timeLabelTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        progress: positionData?.position ?? Duration.zero,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: _audioPlayer.seek,
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(child: MusicController(audioPlayer: _audioPlayer)),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Episode",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _dropDownClick = !_dropDownClick;
                      });
                    },
                    icon: _dropDownClick
                        ? const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                    iconSize: 60,
                  ),
                  //Adding dropdown button
                  _dropDownClick
                      ? const SizedBox()
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: Image.asset('assets/demo_image.png'),
                              title: const Text(
                                "Episode Name Here",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                "Writer: Writer Name Here",
                                style: TextStyle(color: Color(0xFFA7A9AC)),
                              ),
                              trailing: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/demo_image.png'),
                              title: const Text(
                                "Episode Name Here",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                "Writer: Writer Name Here",
                                style: TextStyle(color: Color(0xFFA7A9AC)),
                              ),
                              trailing: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/demo_image.png'),
                              title: const Text(
                                "Episode Name Here",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                "Writer: Writer Name Here",
                                style: TextStyle(color: Color(0xFFA7A9AC)),
                              ),
                              trailing: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/demo_image.png'),
                              title: const Text(
                                "Episode Name Here",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                "Writer: Writer Name Here",
                                style: TextStyle(color: Color(0xFFA7A9AC)),
                              ),
                              trailing: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/demo_image.png'),
                              title: const Text(
                                "Episode Name Here",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                "Writer: Writer Name Here",
                                style: TextStyle(color: Color(0xFFA7A9AC)),
                              ),
                              trailing: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/demo_image.png'),
                              title: const Text(
                                "Episode Name Here",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                "Writer: Writer Name Here",
                                style: TextStyle(color: Color(0xFFA7A9AC)),
                              ),
                              trailing: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/demo_image.png'),
                              title: const Text(
                                "Episode Name Here",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                "Writer: Writer Name Here",
                                style: TextStyle(color: Color(0xFFA7A9AC)),
                              ),
                              trailing: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                              leading: Image.asset('assets/demo_image.png'),
                              title: const Text(
                                "Episode Name Here",
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                "Writer: Writer Name Here",
                                style: TextStyle(color: Color(0xFFA7A9AC)),
                              ),
                              trailing: const Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
