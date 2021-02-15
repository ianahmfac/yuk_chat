import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yuk_chat/services/auth_service.dart';
import 'package:yuk_chat/shared/theme.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isSecure = true;
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  bool _isLoading = false;
  String _email;
  String _username;
  String _password;

  void _passwordVisibility() {
    setState(() {
      _isSecure = !_isSecure;
    });
  }

  void _changeLoginOrSignUp() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _loginProcess() async {
    FocusManager.instance.primaryFocus.unfocus();
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_isLogin) {
        await AuthService.signInWithEmailPassword(_email, _password);
      } else {
        await AuthService.signUp(_email, _username, _password);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isLogin ? "Masuk" : "Buat Akun",
              style: titleStyle,
            ),
            SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
              ),
              validator: (value) {
                if (value.isEmpty) return "Email tidak boleh kosong";
                if (!EmailValidator.validate(value))
                  return "Format email tidak valid";
                return null;
              },
              onSaved: (newValue) => _email = newValue,
            ),
            SizedBox(height: _isLogin ? 0 : 16),
            if (!_isLogin)
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value.isEmpty) return "Username tidak boleh kosong";
                  if (value.length < 4) return "Username sangat pendek";
                  return null;
                },
                onSaved: (newValue) => _username = newValue,
              ),
            SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: _isSecure,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _isSecure ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: _passwordVisibility,
                ),
              ),
              validator: (value) {
                if (value.isEmpty) return "Password tidak boleh kosong";
                if (value.length < 8)
                  return "Password setidaknya memiliki 8 karakter";
                return null;
              },
              onSaved: (newValue) => _password = newValue,
            ),
            SizedBox(height: 16),
            ButtonBar(
              children: [
                TextButton(
                  onPressed: _changeLoginOrSignUp,
                  child: Text(_isLogin ? "Buat Akun?" : "Punya Akun?"),
                ),
                _isLoading
                    ? SpinKitFadingCircle(
                        color: Theme.of(context).accentColor,
                      )
                    : ElevatedButton.icon(
                        onPressed: _loginProcess,
                        icon: Icon(_isLogin ? Icons.login : Icons.create),
                        label: Text(_isLogin ? "Masuk" : "Buat Akun"),
                      )
              ],
            )
          ],
        ));
  }
}
