import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/ui/navigation.dart';
import 'package:streaming_service/ui/theme.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final mainNavigation = MainNavigation();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayerWidgetModel(),
      child: MaterialApp(
        theme: AppTheme.dark,
        initialRoute: mainNavigation.initialRoute,
        routes: mainNavigation.routes,
        onGenerateRoute: mainNavigation.onGenerateRoute,
      ),
    );
  }
}
