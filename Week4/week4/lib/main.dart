import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week4',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week4'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              MyFirstWidget(), // 첫번째 둥근 사각형
              SizedBox(height: 30), // 둥근 사각형 사이 (위아래) 여백
              MySecondWidget(), // 두번째 둥근 사각형
              SizedBox(height: 30), // 둥근 사각형 사이 여백
              MyThirdWidget(), // 세번째 둥근 사각형
            ],
          ),
        ),
      ),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  const MyFirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 너비
      height: 100, // 높이
      child: CustomPaint(
        painter: MyFirstPainter(),
      ),
    );
  }
}

// 일단 둥근 사각형 그려놓고 가장 좌측 둥근 부분과 지름이 같은 원을 그렸다가 겹치는 부분을 뺀 모양 만들기
class MyFirstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black; // 둥근 사각형의 색상

    final double radius = size.height / 2; // 반원의 반지름
    final double width = size.width; // 사각형의 가로 길이

    final double circleRadius = radius; // 원의 반지름

    final path = Path()
      ..moveTo(0, radius) // 좌측 상단에서 시작
      ..arcToPoint(Offset(radius, 0),
          radius: Radius.circular(radius)) // 좌측 상단의 반원
      ..lineTo(width - radius, 0) // 윗면 직선
      ..arcToPoint(Offset(width, radius),
          radius: Radius.circular(radius)) // 우측 상단의 반원
      ..lineTo(width, size.height - radius) // 우측면 직선
      ..arcToPoint(Offset(width - radius, size.height),
          radius: Radius.circular(radius)) // 우측 하단의 반원
      ..lineTo(radius, size.height) // 아랫면 직선
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius)); // 좌측 하단의 반원

    // 가장 왼쪽 둥근 부분과 지름이 딱 맞는 원 그림
    final circlePath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(radius, radius), radius: circleRadius));

    // 그린 원을 빼기 위해 사각형과 겹치는 부분을 제외한 부분을 남기는 ClipPath를 생성
    final clippedPath =
        Path.combine(PathOperation.difference, path, circlePath);

    canvas.drawPath(clippedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MySecondWidget extends StatelessWidget {
  const MySecondWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 너비
      height: 100, // 높이
      child: CustomPaint(
        painter: MySecondPainter(),
      ),
    );
  }
}

// 일단 둥근 사각형 그려놓고 양쪽 둥근 부분과 지름이 같은 원을 그렸다가 겹치는 부분을 뺀 모양 만들기
class MySecondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black; // 둥근 사각형의 색상

    final double radius = size.height / 2; // 반원의 반지름
    final double width = size.width; // 사각형의 가로 길이

    final double circleRadius = radius; // 원의 반지름

    final path = Path()
      ..moveTo(0, radius) // 좌측 상단에서 시작
      ..arcToPoint(Offset(radius, 0),
          radius: Radius.circular(radius)) // 좌측 상단의 반원
      ..lineTo(width - radius, 0) // 윗면 직선
      ..arcToPoint(Offset(width, radius),
          radius: Radius.circular(radius)) // 우측 상단의 반원
      ..lineTo(width, size.height - radius) // 우측면 직선
      ..arcToPoint(Offset(width - radius, size.height),
          radius: Radius.circular(radius)) // 우측 하단의 반원
      ..lineTo(radius, size.height) // 아랫면 직선
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius)); // 좌측 하단의 반원

    // 왼쪽 둥근 부분과 지름이 딱 맞는 원을 그림
    final circlePathLeft = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(radius, radius), radius: circleRadius));

    // 오른쪽 둥근 부분과 지름이 딱 맞는 원을 그림
    final circlePathRight = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(width - radius, radius), radius: circleRadius));

    // 원을 빼기 위해 사각형과 겹치는 부분을 제외한 부분을 남기는 ClipPath를 생성
    final clippedPath = Path.combine(PathOperation.difference, path,
        Path.combine(PathOperation.union, circlePathLeft, circlePathRight));

    canvas.drawPath(clippedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyThirdWidget extends StatelessWidget {
  const MyThirdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 너비
      height: 100, // 높이
      child: CustomPaint(
        painter: MyThirdPainter(),
      ),
    );
  }
}

// 위의 모양들에서 그냥 둥근 사각형만 그려놓기
class MyThirdPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black; // 둥근 사각형의 색상

    final double radius = size.height / 2; // 반원의 반지름
    final double width = size.width; // 사각형의 가로 길이

    final path = Path()
      ..moveTo(0, radius) // 좌측 상단에서 시작
      ..arcToPoint(Offset(radius, 0),
          radius: Radius.circular(radius)) // 좌측 상단의 반원
      ..lineTo(width - radius, 0) // 윗면 직선
      ..arcToPoint(Offset(width, radius),
          radius: Radius.circular(radius)) // 우측 상단의 반원
      ..lineTo(width, size.height - radius) // 우측면 직선
      ..arcToPoint(Offset(width - radius, size.height),
          radius: Radius.circular(radius)) // 우측 하단의 반원
      ..lineTo(radius, size.height) // 아랫면 직선
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius)); // 좌측 하단의 반원

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
