import 'dart:async';

import 'package:flutter/material.dart';

class BuilderPage extends StatefulWidget {
  const BuilderPage({Key? key}) : super(key: key);

  @override
  State<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  Timer? timer;
  PageController controller = PageController(
    // controller 선언
    initialPage: 0, // 몇번째 page 부터 시작할래
  );

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      int currentPage = controller.page!.toInt(); //현재 화면
      int nextPage = currentPage + 1; // 다음 화면

      if (nextPage > 4) {
        // page 끝에 도달시 첫화면으로 돌아감.
        nextPage = 0;
      }
      controller.animateToPage(nextPage, // 다음페이지로 넘겨.
          duration: Duration(milliseconds: 200), // 이동하는 속도
          curve: Curves.linear // 동일한 속도
          );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller, //controller 로 PageVIew 조정 가능
        children: [0, 1, 2, 3, 4]
            .map((e) => Image.asset(
                  'asset/img/image_$e.jpg',
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}
