import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../cubit/home_cubit.dart';
import '../actions/home_actions.dart';
import '../listener/home_listener.dart';
import '../views/home_view_factory.dart';

/// Home feature screen: Scaffold + BlocConsumer. No business logic; only layout and state → view.
/// - Listener: side-effects (e.g. error snackbar).
/// - Builder: view from [HomeViewFactory] for current [HomeState].
class HomeScreen extends StatefulWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onCartTap;

  const HomeScreen({
    super.key,
    this.onProfileTap,
    this.onCartTap,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) HomeActions.load(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: HomeListener.listen,
        builder: (context, state) {
          return HomeViewFactory.build(
            context,
            state,
            onProfileTap: widget.onProfileTap,
            onCartTap: widget.onCartTap,
          );
        },
      ),
    );
  }
}
