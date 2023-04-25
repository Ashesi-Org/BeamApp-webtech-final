import 'package:flutter/src/widgets/placeholder.dart';
import 'package:beam_frontend/Post.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:beam_frontend/APIConstants.dart' as API;
import 'package:beam_frontend/Student.dart';
import 'package:beam_frontend/viewProfile.dart';
import 'package:beam_frontend/userVerificationModal.dart';
import 'package:beam_frontend/apiCalls.dart';
import 'package:beam_frontend/editProfile.dart';
import 'package:beam_frontend/Post.dart';

class feedView extends StatefulWidget {
  const feedView({super.key});

  @override
  State<feedView> createState() => _feedViewState();
}

class _feedViewState extends State<feedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Feed Page'),
      
    ),
    );
  }
}