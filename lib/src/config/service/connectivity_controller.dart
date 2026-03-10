import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'dart:io';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  
  // Reactive variables
  final RxBool isConnected = true.obs;
  final RxBool isCheckingConnection = false.obs;
  final RxString connectionType = 'unknown'.obs;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  // Initialize connectivity
  Future<void> initConnectivity() async {
    List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      Get.log('Could not check connectivity status: $e');
      result = [ConnectivityResult.none];
    }
    
    return _updateConnectionStatus(result);
  }

  // Update connection status
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final hasConnection = result.any((element) => 
      element == ConnectivityResult.mobile || 
      element == ConnectivityResult.wifi ||
      element == ConnectivityResult.ethernet);
    
    if (hasConnection) {
      // Even if connected to WiFi/Mobile, check actual internet connectivity
      final hasInternet = await _hasInternetConnection();
      isConnected.value = hasInternet;
      
      if (hasInternet) {
        if (result.contains(ConnectivityResult.wifi)) {
          connectionType.value = 'wifi';
        } else if (result.contains(ConnectivityResult.mobile)) {
          connectionType.value = 'mobile';
        } else if (result.contains(ConnectivityResult.ethernet)) {
          connectionType.value = 'ethernet';
        }
      }
    } else {
      isConnected.value = false;
      connectionType.value = 'none';
    }
  }

  // Check actual internet connectivity by pinging a reliable server
  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Manual retry connection check
  Future<void> retryConnection() async {
    isCheckingConnection.value = true;
    
    // Add a small delay for better UX
    await Future.delayed(const Duration(seconds: 1));
    
    try {
      await initConnectivity();
    } catch (e) {
      Get.log('Error retrying connection: $e');
    } finally {
      isCheckingConnection.value = false;
    }
  }

  // Get connection status text
  String get connectionStatusText {
    if (!isConnected.value) {
      return 'No Internet Connection';
    }
    
    switch (connectionType.value) {
      case 'wifi':
        return 'Connected via WiFi';
      case 'mobile':
        return 'Connected via Mobile Data';
      case 'ethernet':
        return 'Connected via Ethernet';
      default:
        return 'Connected';
    }
  }
}