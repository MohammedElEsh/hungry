import 'package:flutter/material.dart';

import '../cubit/home_cubit.dart';

/// Handles Home Bloc state side-effects only: snackbars, navigation, banners.
/// UI for each state is built by [HomeViewFactory]; this only reacts to state changes.
abstract final class HomeListener {
  static void listen(BuildContext context, HomeState state) {
    if (state is HomeError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

}
