import 'package:go_router/go_router.dart';
import 'package:velocimetroplus/views/historico/screen_historico.dart';
import 'package:velocimetroplus/views/monitor/screen_monitor.dart';
import 'package:velocimetroplus/views/welcome/screen_welcome.dart';

final GoRouter appRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'welcome',
      builder: (context, state) => const ScreenWelcome(),
    ),
    GoRoute(
      path: '/monitoramento',
      name: 'monitoramento',
      builder: (context, state) => const ScreenMonitor(),
    ),
    GoRoute(
      path: '/historico',
      name: 'historico',
      builder: (context, state) => const ScreenHistorico(),
    ),
  ],
);
