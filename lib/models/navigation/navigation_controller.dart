import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:presensi_mobile_app/views/pages/dashboard/home_page.dart';
import 'package:presensi_mobile_app/views/pages/presensi/presensi_riwayat_page.dart';
import 'package:presensi_mobile_app/views/pages/profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/component/navigation/component_navigation.dart';
import '../../views/pages/auth/login_page.dart';

class NavigationController {
  NavigationController._();

  static String initR =
      '/LoginPage';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome =
  GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _rootNavigatorRiwayat =
  GlobalKey<NavigatorState>(debugLabel: 'shellRiwayat');
  static final _rootNavigatorProfile =
  GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  static final GoRouter router = GoRouter(
    initialLocation: initR,
    redirect: (BuildContext context, GoRouterState state) async {
      final loggedIn = await checkIfLoggedIn();
      final loggingIn = state.matchedLocation == '/LoginPage';

      if (!loggedIn && !loggingIn) return '/LoginPage';
      if (loggedIn && loggingIn) return '/HomePage';

      // Tidak ada redirect yang diperlukan
      return null;
    },
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/LoginPage',
        name: 'LoginPage',
        builder: (context, state) {
          return LoginPage(
            key: state.pageKey,
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: '/HomePage',
                name: 'HomePage',
                builder: (context, state) {
                  return HomePage(
                    key: state.pageKey,
                  );
                },
                // routes:
              )
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorRiwayat,
            routes: [
              GoRoute(
                path: '/RiwayatPresensiPage',
                name: 'RiwayatPresensiPage',
                builder: (context, state) {
                  return RiwayatPresensiPage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorProfile,
            routes: [
              GoRoute(
                path: '/ProfilePage',
                name: 'ProfilePage',
                builder: (context, state) {
                  return ProfilePage(
                    key: state.pageKey,
                  );
                },
              )
            ],
          ),
        ],
      )
    ],
  );
  static Future<bool> checkIfLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
