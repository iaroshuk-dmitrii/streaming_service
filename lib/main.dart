import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_service/repositories/local_storage_client.dart';
import 'package:streaming_service/ui/navigation.dart';
import 'package:streaming_service/ui/theme.dart';
import 'package:streaming_service/ui/widgets/player_widget/player_widget_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageClient.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final mainNavigation = MainNavigation();

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

  @override
  void dispose() async {
    LocalStorageClient.close();
    super.dispose();
  }
}
