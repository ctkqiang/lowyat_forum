import 'package:flutter/material.dart';
import 'package:lowyat_forum/providers/lowyat_state.dart';
import 'package:lowyat_forum/runner.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    runApp(
      MultiProvider(
        key: const Key('multiple_providers'),
        providers: [
          ChangeNotifierProvider(create: (_) => LowyatState()),
        ],
        child: const Runner(key: Key('mainApp')),
      ),
    );
  } catch (_) {
    /// Onstart [Error] Handling
    ErrorWidget.builder = (details) {
      return MaterialApp(
        key: const Key('error_widget'),
        home: Center(child: Text(details.exception.toString())),
      );
    };
  }
}
