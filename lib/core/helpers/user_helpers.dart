import '../../features/onboarding/data/models/user_details_model.dart';
import '../constants/app_strings.dart';
import '../managers/shared_preference_manager.dart';

class UserHelpers {
  static late UserDetails? userDetails;

  static setAuthToken(String token) async {
    SharedPreferencesManager.setString(STRING_KEY_APPTOKEN, token);
  }

  // static setReferralCode(String code) async {
  //   // SharedPreferencesManager.setString(STRING_REF_CODE_KEY, code);
  // }

  static setReferralCodeAndSharer(String code) async {
    SharedPreferencesManager.setString(STRING_REFERRAL_SHARE_KEY, code);
  }

  static String getRefCode() {
    return SharedPreferencesManager.getString(STRING_REF_CODE_KEY);
  }

  static String getRefCodeAndSharer() {
    return SharedPreferencesManager.getString(STRING_REFERRAL_SHARE_KEY);
  }

  static String getAuthToken() {
    return SharedPreferencesManager.getString(STRING_KEY_APPTOKEN);
  }

  static setUserId(String id) async {
    SharedPreferencesManager.setString(STRING_KEY_USERID, id);
  }

  static String getUserId() {
    return SharedPreferencesManager.getString(STRING_KEY_USERID);
  }

  // static bool getIsContactPermissionGranted() {
  //   return SharedPreferencesManager.getBool(STRING_IS_FIRST_APP_OPEN);
  // }

  static setUserDetails(UserDetails profileDetails) async {
    SharedPreferencesManager.setObject(
        STRING_KEY_PROFILE_DETAILS, profileDetails);
    userDetails = profileDetails;
  }

  static Future<dynamic> getUserDetails() async {
    Object obj = SharedPreferencesManager.getObject(STRING_KEY_PROFILE_DETAILS);
    // if no details found call the api
    if (obj == false) {
      return obj;
    } else {
      userDetails = UserDetails.fromMap(obj as Map<String, dynamic>);
      return userDetails;
    }
  }

  static clearUser() async {
    SharedPreferencesManager.removeKey(STRING_KEY_USERID);
    SharedPreferencesManager.removeKey(STRING_KEY_APPTOKEN);
    SharedPreferencesManager.removeKey(STRING_KEY_PROFILE_DETAILS);
    SharedPreferencesManager.removeKey(STRING_REFERRAL_SHARE_KEY);
    SharedPreferencesManager.removeKey(STRING_REF_CODE_KEY);
  }

  static logout() async {
    SharedPreferencesManager.removeKey(STRING_KEY_USERID);
    SharedPreferencesManager.removeKey(STRING_KEY_APPTOKEN);
    SharedPreferencesManager.removeKey(STRING_KEY_PROFILE_DETAILS);
    SharedPreferencesManager.removeKey(STRING_REFERRAL_SHARE_KEY);
    SharedPreferencesManager.removeKey(STRING_REF_CODE_KEY);
    userDetails = null;
  }
}
