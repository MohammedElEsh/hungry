import 'package:flutter/material.dart';

import '../../domain/entities/profile_entity.dart';

/// Holds profile form controllers and sync logic. Init/dispose in Screen.
class ProfileControllers {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController card = TextEditingController();

  void syncFromProfile(ProfileEntity profile) {
    name.text = profile.name;
    email.text = profile.email;
    address.text = profile.address ?? '';
    card.text = profile.visa ?? '';
  }

  void dispose() {
    name.dispose();
    email.dispose();
    address.dispose();
    card.dispose();
  }
}
