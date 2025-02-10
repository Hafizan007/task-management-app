import 'dart:async';

import 'package:injectable/injectable.dart';

import '../../features/task_management/domain/repositories/task_management_repository.dart';

@singleton
class SyncService {
  final TaskManagementRepository repository;
  Timer? _syncTimer;

  SyncService(this.repository);

  void startSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => repository.syncData(),
    );
  }

  void stopSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }
}
