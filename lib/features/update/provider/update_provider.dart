import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

enum AppUpdateStatus { checking, noUpdate, downloading, restartRequired, error }

class UpdateProvider extends ChangeNotifier {
  final _updater = ShorebirdUpdater();

  AppUpdateStatus _status = AppUpdateStatus.checking;
  String? _errorMessage;

  AppUpdateStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isAvailable => _updater.isAvailable;

  Future<void> checkAndUpdate() async {
    _status = AppUpdateStatus.checking;
    notifyListeners();

    try {
      final updateStatus = await _updater.checkForUpdate();

      switch (updateStatus) {
        case UpdateStatus.outdated:
          _status = AppUpdateStatus.downloading;
          notifyListeners();
          await _updater.update();
          _status = AppUpdateStatus.restartRequired;
          notifyListeners();
        case UpdateStatus.upToDate:
        case UpdateStatus.restartRequired:
        case UpdateStatus.unavailable:
          _status = AppUpdateStatus.noUpdate;
          notifyListeners();
      }
    } on UpdateException catch (e) {
      _errorMessage = e.message;
      _status = AppUpdateStatus.error;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _status = AppUpdateStatus.error;
      notifyListeners();
    }
  }
}
