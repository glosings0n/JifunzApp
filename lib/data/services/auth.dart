import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final auth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await (googleSignIn.signIn());

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth == null) {
      return null;
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  Stream<User?> get user => auth.authStateChanges();

  signOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }
}
