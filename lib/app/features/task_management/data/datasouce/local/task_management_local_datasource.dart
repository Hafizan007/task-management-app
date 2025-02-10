import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../config/data/datasources/local/database_helper.dart';
import '../../../../../config/data/models/sync_queue_model.dart';
import '../../../../../config/networking/app_exception.dart';
import '../../../../../constants/db_constant.dart';
import '../../models/task_delete_request_model.dart';
import '../../models/task_get_request_model.dart';
import '../../models/task_model.dart';
import '../../models/task_store_request_model.dart';
import '../../models/task_update_request_model.dart';

abstract class TaskManagementLocalDataSource {
  Future<TaskModel> storeTaskManagementData(
    TaskStoreRequestModel taskStoreRequestModel,
  );

  Future<List<TaskModel>> getTaskManagementData(TaskGetRequestModel params);

  Future<void> updateTaskManagementData(TaskUpdateRequestModel params);

  Future<void> deleteTaskManagementData(TaskDeleteRequestModel params);

  Future<void> addToSyncQueue(SyncQueueModel syncQueue);
  Future<List<SyncQueueModel>> getSyncQueue();
  Future<void> removeSyncQueueItem(String id);
}

@LazySingleton(as: TaskManagementLocalDataSource)
class TaskManagementLocalDataSourceImpl
    implements TaskManagementLocalDataSource {
  final DatabaseHelper databaseHelper;

  TaskManagementLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<TaskModel> storeTaskManagementData(
    TaskStoreRequestModel taskStoreRequestModel,
  ) async {
    final taskData = taskStoreRequestModel.toJson();
    try {
      final db = await databaseHelper.database;
      await db.insert(
        DbConstant.taskTable,
        taskData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return TaskModel.fromJson(taskData);
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<List<TaskModel>> getTaskManagementData(
      TaskGetRequestModel params) async {
    try {
      final db = await databaseHelper.database;

      String query = 'SELECT * FROM ${DbConstant.taskTable} WHERE 1=1';
      List<dynamic> args = [];

      if (params.taskStatus != null) {
        query += ' AND taskStatus = ?';
        args.add(params.taskStatus);
      }

      if (params.searchQuery != null && params.searchQuery!.isNotEmpty) {
        query += ' AND title LIKE ?';
        args.add('%${params.searchQuery}%');
      }

      query += ' ORDER BY dueDate ASC';

      final List<Map<String, dynamic>> tasks = await db.rawQuery(query, args);
      return tasks.map((task) => TaskModel.fromJson(task)).toList();
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> updateTaskManagementData(TaskUpdateRequestModel params) async {
    try {
      final db = await databaseHelper.database;
      await db.update(
        DbConstant.taskTable,
        params.toJson(),
        where: 'id = ?',
        whereArgs: [params.id],
      );
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> deleteTaskManagementData(TaskDeleteRequestModel params) async {
    try {
      final db = await databaseHelper.database;
      await db.delete(
        DbConstant.taskTable,
        where: 'id = ?',
        whereArgs: [params.id],
      );
    } catch (e) {
      throw CacheException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> addToSyncQueue(SyncQueueModel syncQueue) async {
    try {
      final database = await databaseHelper.database;
      await database.insert(
        DbConstant.syncQueueTable,
        syncQueue.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException(message: 'Failed to add to sync queue');
    }
  }

  @override
  Future<List<SyncQueueModel>> getSyncQueue() async {
    try {
      final database = await databaseHelper.database;
      final List<Map<String, dynamic>> syncQueue =
          await database.query(DbConstant.syncQueueTable);
      return syncQueue.map((e) => SyncQueueModel.fromJson(e)).toList();
    } catch (e) {
      throw CacheException(message: 'Failed to get sync queue');
    }
  }

  @override
  Future<void> removeSyncQueueItem(String id) async {
    try {
      final database = await databaseHelper.database;
      await database.delete(
        DbConstant.syncQueueTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException(message: 'Failed to remove sync queue item');
    }
  }
}
