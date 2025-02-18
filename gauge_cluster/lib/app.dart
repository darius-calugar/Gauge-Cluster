import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gauge_cluster/app_colors.dart';
import 'package:gauge_cluster/blocs/car_cubit.dart';
import 'package:gauge_cluster/screens/playground_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => CarCubit(),
        ),
      ],
      child: Container(
        color: AppColors.black2,
        child: DefaultTextStyle(
          style: TextStyle(
            fontFamily: 'Tomorrow',
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: PlaygroundScreen(),
          ),
        ),
      ),
    );
  }
}
