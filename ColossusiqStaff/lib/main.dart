import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'screens/auth/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    // Ensure system status bar is visible on mobile
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const StaffApp());
}

typedef StudentPortalApp = StaffApp;

class StaffApp extends StatelessWidget {
  const StaffApp({super.key});

  EdgeInsets _clampInsets(EdgeInsets insets) {
    return EdgeInsets.fromLTRB(
      insets.left < 0 ? 0.0 : insets.left,
      insets.top < 0 ? 0.0 : insets.top,
      insets.right < 0 ? 0.0 : insets.right,
      insets.bottom < 0 ? 0.0 : insets.bottom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StaffApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            viewInsets: _clampInsets(mediaQueryData.viewInsets),
            padding: _clampInsets(mediaQueryData.padding),
            viewPadding: _clampInsets(mediaQueryData.viewPadding),
          ),
          child: child ?? const SizedBox(),
        );
      },
      home: const SplashScreen(),
    );
  }
}
