import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:beam_frontend/APIConstants.dart' as API;
import 'package:beam_frontend/Student.dart';
import 'package:beam_frontend/viewProfile.dart';
import 'package:beam_frontend/userVerificationModal.dart';
import 'package:beam_frontend/Post.dart';


Future<Student?> getStudent(
  String studentID,


  ) async{
  var url = Uri.http("beamapp-a16fe.ew.r.appspot.com", "/users/$studentID");
  var request = await http.get(
    url, 
    headers:{'Content-Type':'application/json'},
   
  );
  print(request.statusCode);
  if (request.statusCode == 200){
    print("Success");
      final Map<String, dynamic> data = json.decode(request.body);
      final Student studentData = Student.fromJson(data);
      return studentData;

  }
  else{
    print("eRROR");
  }
  return null;

  }
  