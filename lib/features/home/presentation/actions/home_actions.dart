import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

/// Central place for home screen actions. Keeps UI declarative; logic in Cubit.
abstract final class HomeActions {
  static void load(BuildContext context) {
    context.read<HomeCubit>().loadHomeData();
  }

  static void refresh(BuildContext context) {
    context.read<HomeCubit>().refresh();
  }

  static void selectCategory(BuildContext context, int index) {
    context.read<HomeCubit>().selectCategory(index);
  }

  static void toggleFavorite(BuildContext context, int productId) {
    context.read<HomeCubit>().toggleFavorite(productId);
  }
}
