import 'package:flutter/material.dart';

import '../../../../core/widgets/error_display_widget.dart';
import '../actions/home_actions.dart';

/// Error state view with retry. No business logic; retry delegates to [HomeActions].
class HomeErrorView extends StatelessWidget {
  final String message;

  const HomeErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorDisplayWidget(
        message: message,
        onRetry: () => HomeActions.refresh(context),
      ),
    );
  }
}
