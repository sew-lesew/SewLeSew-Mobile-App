import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constant.dart';

class StorageService {
  late final SharedPreferences _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> storeToken({
    String? accessToken,
    String? refreshToken,
    String? resetToken,
  }) async {
    if (accessToken != null) {
      await _prefs.setString('access_token', accessToken);
    }
    if (refreshToken != null) {
      await _prefs.setString('refresh_token', refreshToken);
    }
    if (resetToken != null) {
      await _prefs.setString('resetToken', resetToken);
    }
  }

  Future<void> storeId({
    String? closeCaseId,
    String? postId,
  }) async {
    if (closeCaseId != null) {
      await _prefs.setString('closeCaseID', closeCaseId);
    }
    if (postId != null) {
      await _prefs.setString('postId', postId);
    }
  }

  Future<void> storeEmail({
    String? email,
  }) async {
    if (email != null) {
      await _prefs.setString('email', email);
    }
  }

  Future<void> clearTokens() async {
    await _prefs.remove('access_token');
    await _prefs.remove('refresh_token');
    await _prefs.remove('resetToken');
    await _prefs.remove('closedCaseId');
    await _prefs.remove('postId');
    await _prefs.remove('email');
  }

  // Future<void> clearCloseCaseId() async {}

  // Future<void> clearPostId() async {}
  Future<String?> getEmail() async {
    return _prefs.getString('email');
  }

  Future<String?> getPostId() async {
    return _prefs.getString('posId');
  }

  Future<String?> getCloseCaseID() async {
    return _prefs.getString('closeCaseId');
  }

  Future<String?> getAccessToken() async {
    return _prefs.getString('access_token').toString();
  }

  Future<String?> getRefreshToken() async {
    return _prefs.getString('refresh_token');
  }

  Future<String?> getResetToken() async {
    return _prefs.getString('resetToken');
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(AppConstant.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  bool getIsLoggedIn() {
    return _prefs.getBool(AppConstant.STORAGE_USER_TOKEN_KEY) ?? false;
  }
}
