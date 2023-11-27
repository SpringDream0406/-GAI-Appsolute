import 'package:flutter_test_project/globals/globals.dart';
import 'package:flutter_test_project/models/data_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/music_play_page/music_play_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

//상태코드 모두 주석처리
class AudioFile extends StatefulWidget {
  final PageController pageController;
  final List<Activity> userPlayed;
  final int selectedIndex;
  const AudioFile({
    required this.userPlayed,
    required this.pageController,
    required this.selectedIndex,
    super.key,
  });

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  late AudioPlayer musicPlayer;

  // 아이콘 초기화
  IconData playIcon = Icons.play_arrow;

  // 재생시간 초기화
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  // String path = "rr.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;

  // 넘기기 버튼에 들어가는것 (절대 지우지 말것)
  void _goToNext() {
    int currentPage = widget.pageController.page!.toInt();
    int totalPages = widget.userPlayed.length;

    if (currentPage < totalPages - 1) {
      widget.pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  // 뒤로가기 버튼에 들어가는것 (절대 지우지 말것)
  void _goToPrevious() {
    if (widget.pageController.page!.toInt() > 0) {
      widget.pageController.previousPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    }
  }

  // 재생버튼 (일시정지) 버튼에 들어가는것 (절대 지우지 말것.)
  void _goToPlayPause() async {
    setState(() {
      isPlaying = !isPlaying; // 상태를 먼저 변경
    });

    if (isPlaying) {
      // 재생 상태이면 play 호출
      await musicPlayer.play();
    } else {
      // 일시정지 상태이면 pause 호출
      await musicPlayer.pause();
    }
  }

  // 인잇  스테이트
  @override
  void initState() {
    super.initState();
    musicPlayer = AudioPlayer();

    // PageController의 리스너 설정
    widget.pageController.addListener(() {
      if (widget.pageController.page ==
          widget.pageController.page!.round().toDouble()) {
        // 페이지 인덱스가 변경될 때마다 _initAudioPlayer 호출
        _initAudioPlayer();
      }
    });

    // 슬라이드 바.
    musicPlayer.playerStateStream.listen((playerState) {
      setState(() {
        // 재생 여부
        isPlaying = playerState.playing;
      });
    });

    // 오디오 트랙의 길이
    musicPlayer.durationStream.listen((newDuration) {
      setState(() {
        duration = newDuration ?? Duration.zero;
      });
    });

    // 현재 재생 위치
    musicPlayer.positionStream.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   loadState();
    // });

    // 가장 중요한 것. 노래 재생 (절대 지우면 안됨)
    _initAudioPlayer(initialPage: true);
  }

  // 테스트용
  // Future<void> _initAudioPlayer() async {
  //   await musicPlayer.setAsset('assets/songs/32706177.mp3');
  // }

  //백업
  // Future<void> _initAudioPlayer() async {
  //   // 현재 페이지 인덱스를 정수로 변환
  //   int currentPageIndex = widget.pageController.page!.round();
  //   Activity currentSong = widget.userPlayed[currentPageIndex];
  //   String songPath = 'assets/songs/${currentSong.musicIndex.toString()}.mp3';
  //   await musicPlayer.setAsset(songPath);
  // }
  //setAsset <내장 파일 접근 함수>, setUrl < 외장파일 접근 함수 >

  Future<void> _initAudioPlayer({bool initialPage = false}) async {
    int currentPageIndex;
    if (initialPage) {
      // 초기 페이지 인덱스 사용
      currentPageIndex = widget.selectedIndex;
    } else {
      // 현재 페이지 컨트롤러 인덱스 사용
      currentPageIndex = widget.pageController.page!.round();
    }

    Activity currentSong = widget.userPlayed[currentPageIndex];
    String songPath = 'assets/songs/${currentSong.musicIndex.toString()}.mp3';
    await musicPlayer.setAsset(songPath);
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // super.didChangeAppLifecycleState(state);
  //   print('App Lifecycle State: $state');
  // }

  // 재생 시간 표시 (재생시간, 남은 시간)(절대 건들지 말것,)
  String formatTime(int seconds) {
    int minutes = Duration(seconds: seconds).inMinutes;
    int remainingSeconds = seconds - (minutes * 60);

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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
    // saveState();
    // 오디오 플레이어를 정리합니다.
    musicPlayer.dispose();
    super.dispose();
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
                  onPressed: () {
                    //shuffle_button
                  })),
          // 뒤로가기
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
                  onPressed: _goToPrevious)),
          // 플레이 정지버튼
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.black45),
            child: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 45,
                  color: Colors.white,
                ),
                onPressed: _goToPlayPause),
          ),
          // 앞으로 가기
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
                  onPressed: _goToNext)),
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
                  onPressed: () {
                    //loop button
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
              value: position.inSeconds.clamp(0, duration.inSeconds).toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                musicPlayer.seek(position);

                final newPosition = Duration(seconds: value.toInt());
                musicPlayer.seek(newPosition);
                // 상태 저장
                // saveState();
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
