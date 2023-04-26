
//import statements
import 'dart:convert';
import 'package:beam_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:beam_frontend/APIConstants.dart' as API;
import 'package:beam_frontend/Student.dart';
import 'package:beam_frontend/editProfile.dart';
import 'package:beam_frontend/Post.dart';



class viewProfile extends StatelessWidget {
  final Student? studentInfo;
  const viewProfile({this.studentInfo});

  final int value = 6;
  
  

 @override
Widget build(BuildContext context) {

  //Student details fetched from the database
  String newName = studentInfo!.name;
  String newEmail = studentInfo!.studentEmail;
  String newDob = studentInfo!.studentDateOfBirth;
  String newYearGroup = studentInfo!.studentYearGroup;
  String newResidence = studentInfo!.studentResidence;
  String newMovie = studentInfo!.studentMovie;
  String newFood = studentInfo!.studentFood;
  String newID = studentInfo!.student_ID;
  String dateCreated = studentInfo!.dateCreated;
  String timeCreated = studentInfo!.timeCreated;

  List<String> data = [
    newEmail, 
    newDob, 
    newYearGroup, 
    newResidence, 
    newMovie,
    newFood
  ];
  // for (int num = 0; num < 4; num++){
  //   print(data["column1"]);
  //   print(data["column2"]);
  // }

  List<String> dataHeaders = ["Email", 
  "Date of Birth", 
  "Year Group", 
  "Residence", 
  "Favourite Movie", 
  "Favourite Food"];

  return Scaffold(
    appBar: AppBar(
      title: const Text('View Profile Page'),
    ),

    //Constructs first row of information on the page with user profile image and preliminary user data
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Batman trilogy III.png',
              fit: BoxFit.cover,
              height: 300,
              width: 300,
            ),
            const SizedBox(width: 10), // Add some space between the image and the text
            Text(
              'Name: $newName\nID: $newID\nDate Joined: $dateCreated',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: value,

            itemBuilder: (BuildContext context, int index) {
            int listLength = data.length~/2;


            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(dataHeaders[index],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Expanded(
                      child: Text(data[index],
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              );
            }
            
            
          ),
        ),
        Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => editProfile(studentInfo:studentInfo)),
                    );
                },
                child: Text('Edit Profile'),
                style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(150, 50)), 
                ),
              ),
              SizedBox(width: 16), // Add some space between the buttons
              ElevatedButton(
                onPressed: () {
                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
  
                style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(150, 50)), // Set the minimum size
                ),
                child: const Text('Go to Welcome Page'),
              ),
            ],
          ),

      ],
      
    ),
    
  );
}

}