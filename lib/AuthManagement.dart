import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credentials = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final AuthResult authResult = await _auth.signInWithCredential(credentials);
  final FirebaseUser user = authResult.user;

  assert(user.getIdToken() != null);

  return user;
}

signOut() async {
  await _auth.signOut().then((val) async {
    await _googleSignIn.signOut();
  }).catchError((e) {
    print(e);
  });
}