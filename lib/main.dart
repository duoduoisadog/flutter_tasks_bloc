import 'package:flutter/material.dart';
import 'package:bloc_demo/blocs/bloc_exports.dart';
import 'package:bloc_demo/screens/tabs_screen.dart';
import 'package:bloc_demo/services/app_router.dart';
import 'package:bloc_demo/services/app_theme.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  // HydratedBloc缓存
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TasksBloc(),
        ),
        BlocProvider(
          create: (context) => SwitchBloc(),
        ),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.switchValue
                ? AppThemes.appThemeDate[AppTheme.darkTheme]
                : AppThemes.appThemeDate[AppTheme.lightTheme],
            home: const TabsScreen(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
