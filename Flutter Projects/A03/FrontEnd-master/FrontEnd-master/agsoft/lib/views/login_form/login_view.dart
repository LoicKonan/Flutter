import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// This is the class that will handle the LoginScreen
// It will set the color and the different widgets that
// will be displayed on the screen. and the authentication
// of the user, LIKE THE PASSWORD and the User Name.
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010101),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _user_name_Field(),
            _passwordField(),
            _login_button(context),
            _github_button(),
          ],
        ),
      ),
    );
  }

  Widget _github_button() {
    return IconButton(
      color: Colors.white,
      onPressed: () {},
      icon: FaIcon(FontAwesomeIcons.github),
      iconSize: 32,
    );
  }

  Widget _google_button() {
    return IconButton(
      color: Colors.white,
      onPressed: () {},
      icon: FaIcon(FontAwesomeIcons.google),
      iconSize: 32,
    );
  }

// The login Widget.
  Widget _login_row() {
    return Row(
      children: [_github_button(), _google_button()],
    );
  }

// The Username Widget..
  Widget _user_name_Field() {
    return TextFormField(
        obscureText: false,
        decoration: InputDecoration(
            icon: FaIcon(FontAwesomeIcons.userNinja),
            fillColor: Colors.grey,
            filled: true,
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            hintText: 'User Name'));
  }

// The Password widgets
  Widget _passwordField() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            fillColor: Colors.grey,
            filled: true,
            contentPadding: EdgeInsets.all(16),
            icon: FaIcon(FontAwesomeIcons.key),
            hintText: 'Password'));
  }

// This widgets handle the picture of the logo.
  Widget _logo_image() {
    return Image.asset('assets/images/logo.png');
  }

  Widget _login_button(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/second');
      }, // onPressed
      child: Text('Login'),

      style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(7.0))),
    );
    // style:
    // ElevatedButton.styleFrom(
    //     shape: new RoundedRectangleBorder(
    //         borderRadius: new BorderRadius.circular(20.0)));
  }
}
