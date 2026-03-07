import 'package:flutter/foundation.dart';

/// Notifies when auth state (login / logout / guest) changes so [GoRouter] can re-evaluate redirect.
class AuthRefreshNotifier extends ChangeNotifier {
  void notifyAuthChanged() => notifyListeners();
}
