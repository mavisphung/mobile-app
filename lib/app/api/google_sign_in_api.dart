import 'package:google_sign_in/google_sign_in.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email',
      'openid',
    ],
  );

  static Future<GoogleSignInAccount?> login() async {
    await _googleSignIn.signOut();
    _googleSignIn.clientId.toString().debugLog('ClientId');
    return _googleSignIn.signIn();
  }

  static Future<GoogleSignInAccount?> disconnect() => _googleSignIn.disconnect();
}
