import 'package:flutter/material.dart';

import '../cubit/cart_cubit.dart';

/// Cart state side-effects (e.g. could show error snackbar here).
/// Currently cart uses ErrorDisplayWidget in view; keep listener for future toasts.
void handleCartState(BuildContext context, CartState state) {
  // Optional: if (state is CartError) showErrorBanner(context, state.message);
}
