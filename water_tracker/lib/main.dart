import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = StorageService();
  await storage.load();
  runApp(
    ChangeNotifierProvider<StorageService>.value(
      value: storage,
      child: const WaterTrackerApp(),
    ),
  );
}

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hydrate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B9BD5),
          brightness: Brightness.light,
          primary: const Color(0xFF5B9BD5),
          secondary: const Color(0xFF7EC8E3),
        ),
        scaffoldBackgroundColor: const Color(0xFFE8F4FC),
        textTheme: GoogleFonts.manropeTextTheme(Theme.of(context).textTheme),
      ),
      home: const HomeScreen(),
    );
  }
}
