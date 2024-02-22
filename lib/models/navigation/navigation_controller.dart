import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:presensi_mobile_app/views/pages/dashboard/home_page.dart';
import 'package:presensi_mobile_app/views/pages/presensi/presensi_riwayat_page.dart';

import '../../views/component/navigation/component_navigation.dart';
import '../../views/pages/auth/login_page.dart';
import '../../views/pages/auth/register_page.dart';


class NavigationController {
  NavigationController._();

  static String initR =
      '/SplashPage'; //Halaman pertama ketika aplikasi dijalankan

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorDashboard =
  GlobalKey<NavigatorState>(debugLabel: 'shellDashboard');
  static final _rootNavigatorProject =
  GlobalKey<NavigatorState>(debugLabel: 'shellProject');

  static final GoRouter router = GoRouter(
    initialLocation: initR,
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
      GoRoute(
        path: '/RegisterPage',
        name: 'RegisterPage',
        builder: (context, state) {
          return RegisterPage(
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
            navigatorKey: _rootNavigatorDashboard,
            routes: [
              GoRoute(
                path: '/DashboardPage',
                name: 'DashboardPage',
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
            navigatorKey: _rootNavigatorProject,
            routes: [
              GoRoute(
                path: '/ProjectListdPage',
                name: 'ProjectListdPage',
                builder: (context, state) {
                  return RiwayatPresensiPage(
                    key: state.pageKey,
                  );
                },
                // routes: [
                //   GoRoute(path: 'AbsensiPage',
                //       name: 'AbsensiPage',
                //       builder: (context, state) {
                //         return ProjectAbsensi(
                //           key: state.pageKey,
                //         );
                //       })
                // ]
              ),
            ],
          ),
        ],
      )
    ],
  );
}
