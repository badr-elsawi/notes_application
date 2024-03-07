import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/shared/http_service/http_service.dart';
import 'package:notes_app/shared/styles/light_theme.dart';

import 'cubits/app_cubit/app_cubit.dart';
import 'cubits/app_cubit/app_states.dart';
import 'cubits/bloc_observer.dart';
import 'cubits/note-Cubit/notes_cubit.dart';
import 'layout/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  HttpServices.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
            create: (BuildContext context) => NotesCubit()..getNotes()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Notie',
                theme: lightTheme,
                home: Home(),
              );
            },
          );
        },
      ),
    );
  }
}
