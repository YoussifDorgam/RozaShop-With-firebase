
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_fire_base/Layout/home_layout.dart';
import 'package:shop_app_fire_base/models/user_model.dart';
import 'package:shop_app_fire_base/shared/constance/constance.dart';
import 'package:shop_app_fire_base/shared/provider/add_user.dart';
import 'package:shop_app_fire_base/shared/sharedprefrance/cash_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  UserProvider? userProvider;
  Future signInWithGoogle() async {
    // Attempt to get the currently authenticated user
    try {
      GoogleSignInAccount? currentUser = userProvider!.qoogleSignIn.currentUser;
      currentUser ??= await userProvider!.qoogleSignIn.signInSilently();
      currentUser ??= await userProvider!.qoogleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await currentUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      User user =
      (await userProvider!.firebaseAuth.signInWithCredential(credential)).user!;
      print("signed in " + user.displayName!);
      userProvider!.addUserData(
        currentUser: user,
        userEmail: user.email!,
        userImage: user.photoURL!,
        userName: user.displayName!,
      );
      // Authenticate with firebase
      return user;
    }catch(e){
      Fluttertoast.showToast(
          msg: e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    UserProvider userProvider1 = Provider.of(context);
    userProvider1.getUserData();


    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/background.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Sign in to continue',
                  style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                ),
                Text(
                  'Roza Shop',
                  style:
                      TextStyle(fontSize: 45.0, color: Colors.white, shadows: [
                    BoxShadow(
                      color: Colors.green.shade500,
                      offset: const Offset(3, 3),
                    ),
                  ]),
                ),
                Column(
                  children: [
                    SignInButton(
                      Buttons.Apple,
                      text: "Sign in with Apple",
                      onPressed: () {
                        cachHelper.removeData('uid');
                      },
                    ),
                    SignInButton(
                      Buttons.Google,
                      text: "Sign in with Google",
                      onPressed: () async  {
                        await signInWithGoogle().then((value)
                            {
                                 cachHelper.SaveData(key: 'uid', value: userProvider1.currentData!.userUid)
                                     .then((value) {
                                   NavegatandFinish(context, const HomeLayoute());;
                                 });
                            }

                        );
                      },
                    ),
                  ],
                ),
                Column(
                  children: const [
                    Text(
                      'signing in you are agreeing to our',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Terms and privacy policy',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
