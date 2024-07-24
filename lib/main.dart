import 'package:atmoseye/bloc/whether_bloc_bloc.dart';
import 'package:atmoseye/views/home_screen.dart';
import 'package:atmoseye/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _determinePosition(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snap.hasData) {
            return BlocProvider<WhetherBlocBloc>(
              create: (context) => WhetherBlocBloc()..add(
                FetchWether(snap.data as Position),
              ),
              child: const HomeScreen(),
            );
          } else if (snap.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snap.error.toString()),
              ),
            );
          } else {
            return const SplashScreen();  
          }
        },
      ),
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
