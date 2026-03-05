import 'package:flutter/material.dart';

import '../cubit/home_cubit.dart';
import 'home_error_view.dart';
import 'home_initial_view.dart';
import 'home_loaded_view.dart';
import 'home_loading_view.dart';

/// Builds the appropriate view for each [HomeState]. No side-effects; use [HomeListener] for those.
abstract final class HomeViewFactory {
  static Widget build(
    BuildContext context,
    HomeState state, {
    VoidCallback? onProfileTap,
    VoidCallback? onCartTap,
  }) {
    if (state is HomeLoading) {
      return HomeLoadingView(
        onProfileTap: onProfileTap,
        onCartTap: onCartTap,
      );
    }
    if (state is HomeError) {
      return HomeErrorView(message: state.message);
    }
    if (state is HomeLoaded) {
      return HomeLoadedView(
        state: state,
        onProfileTap: onProfileTap,
        onCartTap: onCartTap,
      );
    }
    return const HomeInitialView();
  }
}
