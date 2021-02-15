import 'package:flutter/material.dart';
import 'package:yuk_chat/shared/theme.dart';
import 'package:yuk_chat/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              Text(
                "💬 Yuk Chat!",
                style: titleStyle.copyWith(fontSize: 32),
              ),
              SizedBox(height: 50),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: AuthForm(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
