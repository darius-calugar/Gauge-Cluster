import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/utils/app_colors.dart';
import 'package:gauge_cluster/blocs/car/car_cubit.dart';
import 'package:gauge_cluster/blocs/playground/playground_cubit.dart';
import 'package:gauge_cluster/screens/playground_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => CarCubit()),
        BlocProvider(create: (_) => PlaygroundCubit(exampleCount: 3)),
      ],
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.white1,
            dynamicSchemeVariant: DynamicSchemeVariant.content,
            brightness: Brightness.dark,
          ),
          textTheme: Typography.material2021().englishLike.apply(
            fontFamily: 'Tomorrow',
          ),
        ).copyWith(splashFactory: InkSparkle.splashFactory),
        home: PlaygroundScreen(),
      ),
    );
  }
}
