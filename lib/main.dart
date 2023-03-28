import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:super_heroes/src/app/features/characters/controller/character_controller.dart';
import 'package:super_heroes/src/app/features/characters/view/search_view.dart';
import 'package:super_heroes/src/data/services/characters_service.dart';
import 'package:super_heroes/src/data/services/characters_service_impl.dart';
import 'package:super_heroes/src/domain/repositories/repositories.dart';
import 'package:super_heroes/src/domain/use_cases/use_cases.dart';
import 'package:super_heroes/src/infra/http/http_client.dart';
import 'package:super_heroes/src/infra/http/http_client_dio.dart';

import 'src/data/repositories/characters_remote_repository.dart';
import 'src/domain/use_cases/get_characters/get_characters_use_case_impl.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  final injector = GetIt.instance;
  setup(injector);
  runApp(MyApp(injector: injector));
}

void setup(injector) {
  injector.registerSingleton<HttpClient>(HttpClientDio());
  injector.registerSingleton<CharactersService>(
    CharactersServiceImpl(injector.get<HttpClient>()),
  );
  injector.registerSingleton<CharactersRepository>(
    CharactersRemoteRepository(injector.get<CharactersService>()),
  );
  injector.registerSingleton<GetCharactersUseCase>(
    GetCharactersUseCaseImpl(
      injector.get<CharactersRepository>(),
    ),
  );
  injector.registerSingleton<CharacterController>(CharacterController(
    getCharactersUseCase: injector.get<GetCharactersUseCase>(),
  ));
}

class MyApp extends StatelessWidget {
  final GetIt injector;
  const MyApp({super.key, required this.injector});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => injector.get<CharacterController>(),
        )
      ],
      child: MaterialApp(
        title: 'Super Heroeees',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SearchView(),
      ),
    );
  }
}
