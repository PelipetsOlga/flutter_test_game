import 'package:get_it/get_it.dart';
import '../data/repo/repository_impl.dart';
import '../domain/repo/team_repository.dart';
import '../ui/screens/add_new/add_game_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton<TeamRepository>(
    () => RepositoryImpl(),
  );

  // BLoCs
  sl.registerFactory<AddGameBloc>(
    () => AddGameBloc(sl()),
  );
}

// Helper method to get repository instance
TeamRepository get teamRepository => sl<TeamRepository>(); 