import 'dart:async';

import 'package:flutter/material.dart';

class BuilderPage extends StatefulWidget {
  const BuilderPage({Key? key}) : super(key: key);

  @override
  State<BuilderPage> createState() => _BuilderPageState();
}

class _BuilderPageState extends State<BuilderPage> {
  int currentPage = 0;
  Timer? timer;
  final PageController _pageController = PageController(initialPage: 0);
  LinePainter _linePainter = LinePainter(0);

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _linePainter = LinePainter(_pageController.page!);
      });
    });

    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < 4) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(microseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView.builder(
              pageSnapping: true,
              controller: _pageController,
              itemCount: 5,
              onPageChanged: (value) {},
              itemBuilder: (context, index) {
                return PageViewTest(number: index);
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.87,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: MediaQuery.of(context).size.height * 0.12,
            child: CustomPaint(
              painter: _linePainter,
            ),
          ),
        ],
      ),
    );
  }
}

class PageViewTest extends StatelessWidget {
  const PageViewTest({Key? key, required this.number}) : super(key: key);
  final int number;

  @override
  Widget build(BuildContext context) {
    List<Color> colorList = [
      Colors.redAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.black,
      Colors.amber
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: colorList[number],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final double page;

  LinePainter(this.page);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;
    canvas.drawLine(
        const Offset(0, 2), const Offset(330, 2), paint..strokeWidth = 2.0);
    canvas.drawLine(
        Offset(25 * page * 2.5, 0), Offset(25 * page * 2.5 + 80, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as LinePainter).page != page;
  }
}
