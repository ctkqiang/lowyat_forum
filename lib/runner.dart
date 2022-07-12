import 'package:flutter/material.dart';
import 'package:lowyat_forum/views/lowyat_splash.dart';

class Runner extends StatefulWidget {
  const Runner({Key? key}) : super(key: key);

  @override
  State<Runner> createState() => _RunnerState();
}

class _RunnerState extends State<Runner> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lowyat Forum',
      debugShowCheckedModeBanner: false,
      home: LowyatSplash(),
    );
  }
}
