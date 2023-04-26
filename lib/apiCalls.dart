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



Future<void> sendPost(
  String studentName, 
  String studentID,
  String postContent,
  ) async{
  var url = Uri.http("beamapp-a16fe.ew.r.appspot.com", "/posts");
  var request = await http.post(
    url, 
    headers:{'Content-Type':'application/json'},
    body: jsonEncode(<String, String>{
      "name": studentName,
      "student_ID": studentID,
      "content": postContent
  
    }),
  );
  print(request.statusCode);
  if (request.statusCode == 201){
    print("Success");
  }
  else{
    print("eRROR");
  }

}


Future<Post?> getPost(
  String postID,
  ) async{
  var url = Uri.http("beamapp-a16fe.ew.r.appspot.com", "/posts/$postID");
  var request = await http.get(
    url, 
    headers:{'Content-Type':'application/json'},
    
  );
  print(request.statusCode);
  if (request.statusCode == 201){
    print("Success");
    final Map<String, dynamic> data = json.decode(request.body);
    final Post postData = Post.fromJson(data);
    return postData;
  }
  else{
    print("eRROR");
  }
  return null;

}
  

Future<bool> patchPost(
  String studentName, 
  String studentID,
  String postContent,
  String postID,
  ) async{
  var url = Uri.http("beamapp-a16fe.ew.r.appspot.com", "/posts");
  var request = await http.patch(
    url, 
    headers:{'Content-Type':'application/json'},
    body: jsonEncode(<String, String>{
      "name": studentName,
      "student_ID": studentID,
      "content": postContent,
      "post_ID": postID,
  
    }),
  );
  print(request.statusCode);
  if (request.statusCode == 201){
    print("Success");
    return true;
  }
  else{
    print("eRROR");
    return false;
  }

}