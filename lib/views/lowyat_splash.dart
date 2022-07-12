import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lowyat_forum/providers/lowyat_state.dart';
import 'package:lowyat_forum/views/lowyat_main_page.dart';
import 'package:provider/provider.dart';

class LowyatSplash extends StatefulWidget {
  const LowyatSplash({Key? key}) : super(key: key);

  @override
  State<LowyatSplash> createState() => _LowyatSplashState();
}

class _LowyatSplashState extends State<LowyatSplash> {
  @override
  void initState() {
    super.initState();

    late int splashDuration = super.context.read<LowyatState>().splashDuration!;

    Timer(Duration(seconds: splashDuration), () {
      Navigator.push(
        super.context,
        MaterialPageRoute(builder: (_) => const LowyatMainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(super.context).size.width / 1.5,
          height: MediaQuery.of(super.context).size.width / 1.5,
          child: Image.asset('assets/images/lowyat.png'),
        ),
      ),
    );
  }
}
