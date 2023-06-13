// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timely/Scheduler.dart';
import 'package:timely/Stopwatch.dart';
import 'package:timely/Timer.dart';
import 'package:timely/TimerTicker.dart';
import 'package:timely/Worldclock.dart';
import 'package:timely/addSchedule.dart';
import 'package:timely/constant.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => TimelyStates(),
    )
  ], child: const Timely()));
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final schedulerNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => UIShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: "timer",
            builder: (BuildContext context, GoRouterState state) {
              return Timer();
            },
          ),
          GoRoute(
            path: '/stopwatch',
            name: 'stopwatch',
            builder: (BuildContext context, GoRouterState state) {
              return StopWatch();
            },
          ),
          GoRoute(
            path: '/worldclock',
            name: 'worldclock',
            builder: (BuildContext context, GoRouterState state) {
              return Worldclock();
            },
          ),
          GoRoute(
              path: '/scheduler',
              name: 'scheduler',
              builder: (BuildContext context, GoRouterState state) {
                return Scheduler();
              },
              routes: [
                GoRoute(
                  path: 'add-schedule',
                  name: 'add-schedule',
                  builder: (BuildContext context, GoRouterState state) {
                    return AddSchedule();
                  },
                ),
              ]),
        ]),
    // GoRoute(
    //   path: '/add-schedule',
    //   name: 'add-schedule',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return AddSchedule();
    //   },
    // ),
    GoRoute(
      path: '/ticker',
      name: 'ticker',
      builder: (BuildContext context, GoRouterState state) {
        return TimerTicker(
          time: state.extra as int,
        );
      },
    ),
  ],
);

class Timely extends StatelessWidget {
  const Timely({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      darkTheme: Themes.darkTheme, // standard dark theme
      routerConfig: _router,
      theme: Themes.lightTheme,
      themeMode: ThemeMode.system,
    );
  }
}

class UIShell extends StatelessWidget {
  const UIShell({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
          backgroundColor: theme.primaryColor,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: theme.primaryColor,
            currentIndex: calculateSelectedIndex(context),
            onTap: (index) {
              switch (index) {
                case 1:
                  return context.goNamed('stopwatch');
                case 2:
                  return context.goNamed('worldclock');
                case 3:
                  return context.goNamed('scheduler');
                default:
                  return context.go('/');
              }
            },
            showSelectedLabels: true,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(label: "Timer", icon: Icon(Icons.timer)),
              BottomNavigationBarItem(
                  label: "Stopwatch", icon: Icon(Icons.timer_10_select_sharp)),
              BottomNavigationBarItem(
                  label: "World Clock", icon: Icon(Icons.public)),
              BottomNavigationBarItem(
                  label: "Scheduler", icon: Icon(Icons.event_note)),
            ],
            elevation: 0,
          ),
          body: child),
    );
  }

  int calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith('/stopwatch')) {
      return 1;
    }
    if (location.startsWith('/worldclock')) {
      return 2;
    }
    if (location.startsWith('/scheduler')) {
      return 3;
    }

    return 0;
  }
}
