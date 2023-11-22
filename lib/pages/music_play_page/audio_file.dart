import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/music_play_page/music_play_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


//상태코드 모두 주석처리
class AudioFile extends StatefulWidget {
  final AudioPlayer musicPlayer;
  const AudioFile({super.key, required this.musicPlayer});

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  late AudioPlayer musicPlayer;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  // String path = "rr.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;


  @override
  void initState() {
    super.initState();
    musicPlayer = AudioPlayer();
    _initAudioPlayer();
    // musicPlayer.onPlayerStateChanged.listen((state) {
    //   setState(() {
    //     // isPlaying = state == PlayerState.playing;
    //   });
    // });

    // musicPlayer.onDurationChanged.listen((nuwDuration) {
    //   setState(() {
    //     duration = nuwDuration;
    //   });
    // });

    // musicPlayer.onPositionChanged.listen((newPosition) {
    //   setState(() {
    //     position = newPosition;
    //   });
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadState();
    });
  }

  IconData playIcon = Icons.play_arrow;
  List<IconData> _icons = [
    Icons.play_arrow,
    Icons.pause,
  ];

  Future<void> _initAudioPlayer() async {
    await musicPlayer.setUrl(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // super.didChangeAppLifecycleState(state);
  //   print('App Lifecycle State: $state');
  // }

  // 재생중인 시간, 남은 재생시간
  String formatTime(int seconds) {
    int minutes = Duration(seconds: seconds).inMinutes;
    int remainingSeconds = seconds - (minutes * 60);

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString()
        .padLeft(2, '0')}';
  }

  Future<void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_position', position.inSeconds);
    // await prefs.setString('last_path', path);
    // 재생 상태도 저장 합니다.
    await prefs.setBool('is_playing', isPlaying);
  }

  Future<void> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPosition = prefs.getInt('last_position') ?? 0;
    final savedPath = prefs.getString('last_path') ?? 'default_path.mp3';
    // 재생 상태를 로드 합니다.
    final savedIsPlaying = prefs.getBool('is_playing') ?? false;
    // 로드된 정보를 기반으로 오디오 플레이어 설정
    setState(() {
      position = Duration(seconds: savedPosition);
      // path = savedPath;
      // 재생 상태를 설정합니다.
      isPlaying = savedIsPlaying;
    });
    // await musicPlayer.setSource(AssetSource(savedPath));

    // await musicPlayer.setSource(UrlSource(savedPath)); 웹url

    if (isPlaying) {
      // musicPlayer.play(UrlSource(savedPath));
      musicPlayer.seek(Duration(seconds: savedPosition));
    }
  }



  @override
  void dispose() {
    // 현재 상태를 저장합니다.
    saveState();
    // 오디오 플레이어를 정리합니다.
    musicPlayer.dispose();
    super.dispose();
  }

  Widget btnStart() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.black45),
      child: IconButton(
          icon: Icon(
            isPlaying == false ? _icons[0] : _icons[1],
            size: 45,
            color: Colors.white,
          ),
          onPressed: () async {
            if (isPlaying == false) {
              await musicPlayer.play();
              setState(() {
                isPlaying = true;
              });
            } else if (isPlaying == true) {
             await musicPlayer.pause();
              setState(() {
                isPlaying = false;
              });
            }
          }),
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent),
              child: IconButton(
                  icon: Icon(
                    Icons.swap_horiz_outlined,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {  //shuffle_button



                  })),
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent),
              child: IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {  // skip_to_prevous


                  })),
          btnStart(),
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent),
              child: IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {  // skip button


                  })),
          Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent),
              child: IconButton(
                  icon: Icon(
                    Icons.loop,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {  //loop button


                  })),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Slider(
              activeColor: Colors.black54,
              inactiveColor: Colors.black38,
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                musicPlayer.seek(position);
                // musicPlayer.resume();

                final newPosition = Duration(seconds: value.toInt());
                musicPlayer.seek(newPosition);
                // 상태 저장
                saveState();
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "  " + formatTime(position.inSeconds),
                style: TextStyle(fontSize: 18),
              ),
              Text(
                formatTime((duration - position).inSeconds) + "  ",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          loadAsset(),
        ],
      ),
    );
  }
}
