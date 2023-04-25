// Create a function to show the modal bottom sheet
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:beam_frontend/viewProfile.dart';
import 'package:http/http.dart' as http;
import 'package:beam_frontend/Post.dart';



class userVerificationModal extends StatefulWidget {
  const userVerificationModal({super.key});

  @override
  State<userVerificationModal> createState() => _userVerificationModalState();
}

class _userVerificationModalState extends State<userVerificationModal> {
  @override
  Widget build(BuildContext context) {
    return const userVerificationModal();
  }
}


Future<Map<String, String>> showModal(BuildContext context) async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> userInfo = {};
  await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your ID:'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'ID',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your ID';
                  }
                  return null;
                },
                onSaved: (value) {
                  userInfo['student_ID'] = value!;
                },
              ),
              const Text('Enter your email:'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  userInfo['email'] = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      );
    },
  );
  return userInfo;
}