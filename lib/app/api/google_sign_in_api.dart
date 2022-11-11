import 'package:google_sign_in/google_sign_in.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
    // clientId: '162922742863-p8d52vnuffvkft7e4i21qsansdk6atj6.apps.googleusercontent.com',
    scopes: [
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/userinfo.email',
      'openid',
    ],
  );

  static GoogleSignIn getInstance() => _googleSignIn;

  static Future<GoogleSignInAccount?> login() async {
    await _googleSignIn.signOut();
    return _googleSignIn.signIn();
  }

  // static Future<GoogleSignInAccount?> disconnect() => _googleSignIn.disconnect();
}
