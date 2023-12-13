class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VideoPlayerController controller;
  late Stream<Duration?> stream;


  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/jordan.mp4')
      ..initialize().then((_) => setState(() {
        stream = Stream.periodic(const Duration(seconds: 1),(computationCount) => controller.value.position);
      }));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: controller.value.isInitialized
            ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
              const SizedBox(height: 50),

              StreamBuilder<Duration?>(
                stream: stream,
                builder: (context, snapshot) {
                  return Text(snapshot.data!.inSeconds.toString());
                } ,
              ),
            ],
          ),
        )
            : const SizedBox(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.value.isPlaying) {
            setState(() {
              controller.pause();
            });
          } else {
            setState(() {
              controller.play();
            });
          }
        },
        child:
        Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
