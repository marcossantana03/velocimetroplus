import 'package:workmanager/workmanager.dart';
import '../services/teste_velocidade_service.dart';

const String testeVelocidadeTask = "testeVelocidadePeriodicTask";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == testeVelocidadeTask) {
      await TesteDeVelocidadeService.testeEGravaHistorico();
    }
    return Future.value(true);
  });
}

void agendarTesteDeVelocidade() {
  Workmanager().registerPeriodicTask(
    "1",
    testeVelocidadeTask,
    frequency: const Duration(minutes: 15),
    initialDelay: const Duration(seconds: 10),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
}