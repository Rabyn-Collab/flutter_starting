import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/user_service.dart';




final userProvider = FutureProvider((ref) => UserService.getData());