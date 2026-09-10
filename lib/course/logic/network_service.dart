import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isInitial = true;

  @override
  void onInit() {
    super.onInit();
    _checkInitialStatus();
    _subscription = _connectivity.onConnectivityChanged.listen(_onChanged);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);
  }

  Future<void> _checkInitialStatus() async {
    final result = await _connectivity.checkConnectivity();
    isConnected.value = _hasConnection(result);
    _isInitial = false;
  }

  void _onChanged(List<ConnectivityResult> results) {
    final connected = _hasConnection(results);
    final wasConnected = isConnected.value;

    if (_isInitial) {
      isConnected.value = connected;
      _isInitial = false;
      return;
    }

    if (wasConnected == connected) return;

    isConnected.value = connected;

    if (wasConnected && !connected) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.snackbar(
        'Offline',
        'No internet connection',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.wifi_off, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
        isDismissible: true,
      );
    } else if (!wasConnected && connected) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.snackbar(
        'Connected',
        'Back online',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.wifi, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
        isDismissible: true,
      );
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
