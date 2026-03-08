import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Shows a banner when device is offline. Use as overlay or at top of scroll.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: Connectivity().onConnectivityChanged,
      initialData: const [ConnectivityResult.other],
      builder: (context, snapshot) {
        final results = snapshot.data ?? [ConnectivityResult.other];
        final isOffline = results.isEmpty ||
            results.every((r) =>
                r == ConnectivityResult.none || r == ConnectivityResult.other);
        if (!isOffline) return const SizedBox.shrink();
        return Material(
          color: Colors.orange.shade700,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.cloud_off, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${'offline_mode'.tr()} — ${'showing_cached_data'.tr()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
