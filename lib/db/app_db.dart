import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plug2go/utils/logger.dart';

/// to store local data
class AppDB {
  AppDB._(this._box);
  static const _appDbBox = '_appDbBox';
  final Box<dynamic> _box;

  /// to get instance
  static Future<AppDB> getInstance() async {
    try {
      final box = await Hive.openBox<dynamic>(_appDbBox);
      return AppDB._(box);
    } catch (e) {
      final appDir = await getApplicationDocumentsDirectory();
      if (appDir.existsSync()) {
        appDir.deleteSync(recursive: true);
      }
      final box = await Hive.openBox<dynamic>(_appDbBox);
      return AppDB._(box);
    }
  }

  /// save value
  T getValue<T>(String key, {T? defaultValue}) => _box.get(key, defaultValue: defaultValue) as T;

  /// save value
  Future<void> setValue<T>(String key, T value) => _box.put(key, value);

  /// to get user token
  String get token => getValue('token', defaultValue: '');

  ///to set user token
  set token(String update) => setValue('token', update);

  ///Removes all user data except
  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      e.logFatal;
    }
  }

  /// to set internet status
  set internetStatus(String status) => setValue('internetStatus', status);

  /// to get internet status
  String get internetStatus => getValue('internetStatus', defaultValue: 'connected');

  /// to check internet connection status is connected or not
  bool get isInternetConnected {
    return internetStatus == 'connected';
  }

  // AuthModel? get userModel =>
  //     getValue<dynamic>('userModel') != null ? AuthModel.fromJson(Map<String, dynamic>.from(getValue('userModel'))) : null;

  // set userModel(AuthModel? update) => setValue('userModel', update?.toJson());

  ///set user type
  set isEvUser(bool update) => setValue('userType', update);

  ///get user type
  bool get isEvUser => getValue('userType', defaultValue: true);

  /// get remember me email
  String? get email => getValue('email', defaultValue: '');

  /// set remember me email
  set email(String? update) => setValue('email', update);

  /// get remember me password
  String? get password => getValue('password', defaultValue: '');

  /// set remember me password
  set password(String? update) => setValue('password', update);
}
