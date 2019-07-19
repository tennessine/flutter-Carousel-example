import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentIndex,
      keepPage: false,
      viewportFraction: 0.5,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            controller: controller,
            itemBuilder: (BuildContext context, int index) => _buildItem(index),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs()) * .5).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            width: Curves.easeOut.transform(value) * 250,
            height: Curves.easeOut.transform(value) * 300,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        color: index % 2 == 0 ? Colors.blue: Colors.red,
      ),
    );
  }
}
