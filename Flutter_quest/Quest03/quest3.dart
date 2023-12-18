import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool is_cat = true;

  void updateIsCat(bool value) {
    setState(() {
      is_cat = value;
    });
    print('$is_cat');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: MyRouterDelegate(),
      routeInformationParser: MyRouteInformationParser(),
    );
  }
}

class MyRoutePath {
  String? id;

  MyRoutePath.home() : id = null;

  MyRoutePath.detail(this.id);
}

class MyRouteInformationParser extends RouteInformationParser<MyRoutePath> {
  @override
  Future<MyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    if (uri.pathSegments.length >= 2) {
      var remaining = uri.pathSegments[1];
      return MyRoutePath.detail(remaining);
    } else {
      return MyRoutePath.home();
    }
  }

  @override
  RouteInformation restoreRouteInformation(MyRoutePath configuration) {
    if (configuration.id != null) {
      return RouteInformation(location: '/detail/${configuration.id}');
    } else {
      return const RouteInformation(location: '/');
    }
  }
}

class MyRouterDelegate extends RouterDelegate<MyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoutePath> {
  String? selectId;
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  MyRoutePath get currentConfiguration {
    if (selectId != null) {
      return MyRoutePath.detail(selectId);
    } else {
      return MyRoutePath.home();
    }
  }

  void goBackToHome() {
    selectId = null;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.findAncestorStateOfType<_MainAppState>();

    if (appState == null) {
      return const SizedBox(); // Return an empty widget or handle the error accordingly
    }

    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            child: HomeScreen(
                _handleOnPressed, (bool value) => appState.updateIsCat(value))),
        if (selectId != null)
          MaterialPage(
              child: DetailScreen(selectId,
                  onBack: goBackToHome,
                  updateCatStatus: (bool value) => appState.updateIsCat(value)))
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        selectId = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(MyRoutePath configuration) async {
    if (configuration.id != null) {
      selectId = configuration.id;
    }
  }

  void _handleOnPressed(String id) {
    selectId = id;
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  final ValueChanged<String> onPressed;
  final Function(bool) updateCatStatus;

  const HomeScreen(this.onPressed, this.updateCatStatus, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const FaIcon(FontAwesomeIcons.cat),
          centerTitle: true,
          title: const Text(
            'First Page',
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  onPressed('1');
                },
                child: const Text('Next'),
              ),
            ),
            const Align(
              alignment: Alignment(0.0, 0.75),
              child: Image(
                image: AssetImage('images/cat.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String? id;
  final VoidCallback onBack;
  final Function(bool) updateCatStatus;

  DetailScreen(this.id,
      {required this.onBack, required this.updateCatStatus, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const FaIcon(FontAwesomeIcons.dog),
          centerTitle: true,
          title: const Text(
            'First Page',
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  onBack();
                },
                child: const Text('Back'),
              ),
            ),
            const Align(
              alignment: Alignment(0.0, 0.75),
              child: Image(
                image: AssetImage('images/dog.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
