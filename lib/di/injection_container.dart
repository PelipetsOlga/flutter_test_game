import 'package:get_it/get_it.dart';
import '../data/repo/repository_impl.dart';
import '../domain/repo/team_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Register Repository
  getIt.registerLazySingleton<TeamRepository>(
    () => RepositoryImpl(),
  );
}

// Helper method to get repository instance
TeamRepository get teamRepository => getIt<TeamRepository>(); 