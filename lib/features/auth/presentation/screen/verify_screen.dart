import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification code')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('We have to sent the code  verification to'),
              Text('email.com.vn'),
              SizedBox(height: 20),
              Row(children: [
                  
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
