import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/habit/habit_bloc.dart';
import 'package:habit_app/bloc/habit/habit_event.dart';
import 'package:habit_app/bloc/login/login_bloc.dart';
import 'package:habit_app/bloc/register/register_bloc.dart';
import 'package:habit_app/model/habit_model.dart';
import 'package:habit_app/repositories/habit_repositories.dart';
import 'package:habit_app/repositories/quote_repositories.dart';
import 'package:habit_app/screens/add_habit_screen.dart';
import 'package:habit_app/screens/habit_dashboard.dart';
import 'package:habit_app/screens/login_screen.dart';
import 'package:habit_app/screens/register_screen.dart';
import 'package:habit_app/screens/splash_screen.dart';
import 'package:habit_app/theme/habit_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HabitBloc(habitRepositories: HabitRepositories())
              ..add(Loadhabit()),
          ),
          BlocProvider(
            create: (_) => RegisterBloc(),
            child: const RegisterScreen(),
          ),
          BlocProvider(
            create: (_) => LoginBloc(),
            child: const LoginScreen(),
          ),
        ],
        child: MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          themeMode: ThemeMode.system,
          theme: HabitTheme.lightTheme,
          darkTheme: HabitTheme.darkTheme,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                );
              case '/home':
                return MaterialPageRoute(
                  builder: (context) => HabitDashboard(),
                );
              case '/add-habit':
                final habit = settings.arguments as HabitModel?;
                return MaterialPageRoute(
                  builder: (context) => AddEditHabitScreen(habit ?? null),
                );
              case '/login':
                return MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                );
              case '/register':
                return MaterialPageRoute(
                  builder: (context) => RegisterScreen(),
                );
              default:
                return MaterialPageRoute(
                  builder: (context) => const Scaffold(
                    body: Center(child: Text('Route not found')),
                  ),
                );
            }
          },
        ));
  }
}
