import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/event_repository.dart';
import 'repository/vote_repository.dart';
import 'screens/home/home_screen.dart';
import 'cubits/event/event_cubit.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Provide FirebaseService
        RepositoryProvider(
          create: (context) => FirebaseService(),
        ),
        // Provide EventRepository
        RepositoryProvider(
          create: (context) => EventRepository(
            context.read<FirebaseService>(),
          ),
        ),
        // Provide VoteRepository
        RepositoryProvider(
          create: (context) => VoteRepository(
            context.read<FirebaseService>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EventCubit(
              context.read<EventRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'User App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home: HomeScreen(),
        ),
      ),
    );
  }
}