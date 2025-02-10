library app_initial_sources;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/data/model/user_local_model.dart';
import '../../features/profile/data/models/profile_local_model.dart';
import '../injection/injection.dart';
import '../services/sync_service.dart';
import 'env.dart';

part 'app_initial.dart';
