import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timely/src/features/scheduler/presentation/scheduler.dart';
import 'package:timely/src/features/stopWatch/presentation/stopwatch.dart';
import 'package:timely/src/features/stopWatch/presentation/stopwatchController.dart';
import 'package:timely/src/features/timer/application/timerController.dart';
import 'package:timely/src/features/timer/presentation/timer.dart';
import 'package:timely/src/features/timer/presentation/timerTicker.dart';
import 'package:timely/src/features/worldClock/presentation/worldClockController.dart';
import 'package:timely/src/features/worldClock/presentation/worldclock.dart';
import 'package:timely/constant.dart';
import 'package:timely/src/features/scheduler/domain/scheduleModel.dart';
import 'package:timely/src/features/scheduler/presentation/scheduleDetail.dart';
import 'package:timely/src/features/worldClock/presentation/worldclockList.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();

  runApp(const Timely());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final schedulerNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/timer',
  routes: <RouteBase>[
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => UIShell(child: child),
        routes: [
          GoRoute(
            path: '/timer',
            name: "timer",
            builder: (BuildContext context, GoRouterState state) {
              return ChangeNotifierProvider(
                builder: (context, _) => const Timer(),
                create: (context) => TimerStates(),
              );
            },
          ),
          GoRoute(
            path: '/stopwatch',
            name: 'stopwatch',
            builder: (BuildContext context, GoRouterState state) {
              return ChangeNotifierProvider(
                create: (context) => StopWatchStates(),
                builder: (context, child) => const StopWatch(),
              );
            },
          ),
          ShellRoute(
              // path: '/worldclock',
              // name: 'worldclock',
              builder: (context, state, child) => ChangeNotifierProvider(
                    create: (context) => WorldClockStates(),
                    builder: (context, child1) => child,
                  ),
              routes: [
                GoRoute(
                    path: '/worldclock',
                    name: 'worldclock',
                    builder: (BuildContext context, GoRouterState state) {
                      return const Worldclock();
                    },
                    routes: [
                      GoRoute(
                        path: 'add-worldclock',
                        name: 'add-worldclock',
                        builder: (BuildContext context, GoRouterState state) {
                          return const WorldClockList();
                        },
                      ),
                    ]),
                // GoRoute(
                //   path: '/add-worldclock',
                //   name: 'add-worldclock',
                //   builder: (BuildContext context, GoRouterState state) {
                //     return const WorldClockList();
                //   },
                // ),
              ]),
          GoRoute(
              path: '/scheduler',
              name: 'scheduler',
              builder: (BuildContext context, GoRouterState state) {
                return const Scheduler();
              },
              routes: [
                GoRoute(
                  path: 'schedule-detail',
                  name: 'schedule-detail',
                  builder: (BuildContext context, GoRouterState state) {
                    return ScheduleDetail(
                      schedule:
                          ((state.extra as Map<String, dynamic>)['schedule'])
                              as ScheduleModel,
                      newschedule: ((state.extra
                          as Map<String, dynamic>)['new-schedule']) as bool,
                    );
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
    // GoRoute(
    //   path: '/schedule-detail',
    //   name: 'schedule-detail',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return ScheduleDetail(
    //       schedule: state.extra as ScheduleModel,
    //     );
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
    return Scaffold(
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
                return context.go('/timer');
            }
          },
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
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
        body: child);
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
