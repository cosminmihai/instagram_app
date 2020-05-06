import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> with SingleTickerProviderStateMixin {
  TabController tabController;
  CameraController cameraController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    initCamera();
    super.initState();
  }

  Future<void> initCamera() async {
    final List<CameraDescription> cameras = await availableCameras();

    final CameraDescription camera =
        cameras.firstWhere((CameraDescription element) => element.lensDirection == CameraLensDirection.back);

    final CameraController cameraController = CameraController(camera, ResolutionPreset.medium);
    await cameraController.initialize();

    setState(() => this.cameraController = cameraController);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Photo',
        ),
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              if (cameraController != null)
                Container(
                  height: MediaQuery.of(context).size.width + 28.0,
                  width: MediaQuery.of(context).size.width,
                  child: Transform.scale(
                    scale: cameraController.value.aspectRatio / size.aspectRatio,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: cameraController.value.aspectRatio,
                        child: CameraPreview(cameraController),
                      ),
                    ),
                  ),
                ),
              Container(
                alignment: AlignmentDirectional.bottomStart,
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
                child: IconButton(
                  icon: Icon(
                    Icons.flash_off,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
          Flexible(
            child: Container(
              color: Colors.black,
              alignment: AlignmentDirectional.center,
              constraints: const BoxConstraints.expand(),
              child: GestureDetector(
                onTap: () async {
                  final Directory directory = await getApplicationDocumentsDirectory();
                  final String path = '${directory.path}/images/${Uuid().v4()}.png';
                  print(path);
                  await cameraController.takePicture(path);
                },
                child: Container(
                  width: 96.0,
                  height: 96.0,
                  alignment: AlignmentDirectional.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white70,
                  ),
                  child: Container(
                    width: 64.0,
                    height: 64.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.black,
          child: TabBar(
            indicatorColor: Colors.transparent,
            controller: tabController,
            tabs: const <Widget>[
              Tab(text: 'Library'),
              Tab(text: 'Photo'),
              Tab(text: 'Video'),
            ],
          ),
        ),
      ),
    );
  }
}
