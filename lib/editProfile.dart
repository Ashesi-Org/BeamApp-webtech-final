//ISSUE - Add buffering sign when loading edit page and loading response after edit


import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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

import 'main.dart';

class editProfile extends StatefulWidget {
  final Student? studentInfo;
  const editProfile({this.studentInfo});

  @override
  State<editProfile> createState() => _editProfileState();
  
}

class _editProfileState extends State<editProfile> {

  //Helper functions to ensure that studentInfo which is 
  //information about the current user is up to date
  late Student studentInfo;
  
  @override
  void initState() {
    super.initState();
    studentInfo = widget.studentInfo!;
  }

  final _emailTextController = TextEditingController();
  final _yearGroupController = TextEditingController();
  final _majorTextController = TextEditingController();
  final _residenceController = TextEditingController();
  final _favFoodTextController = TextEditingController();
  final _favMovieTextController = TextEditingController();

  //Options for drop downs
List<String> _residenceOptions = ['On-campus', 'Off-campus'];
 String? _selectedResidence;

List<String> _majorOptions = ['Computer Science', 'Computer Engineering', 'Electrical Engineering', 'Mechanical Engineering', 'Management Information Systems', 'Business Administration'];
String? _selectedMajor;

Color _dropDownColor = Colors.red;



//Variables storing form field data
final _signUpInfo = GlobalKey<FormState>();
String _studentName = '';
String _studentID = '';
String _studentMajor = '';
String _studentResidence = '';
String _studentEmail = '';
String _studentMovie = '';
String _studentFood = '';
String _studentDateOfBirth = '';
String _studentYearGroup = '';


//Submit form function
void _submitForm() async {
  if (_signUpInfo.currentState!.validate()) {
    _signUpInfo.currentState!.save();
    try {
      await putStudent(
      _studentID,
      _studentMajor,
      _studentResidence,
      _studentMovie,
      _studentFood,
      _studentYearGroup);
     
      // Do something with the server response
    } catch (e) {
      print('Error: $e');
    }
  }
}


// ISSUE - Access the studentID that has been passed and use here
Future<void> putStudent(
  String studentID,
  String studentMajor,
  String studentResidence,
  String studentMovie,
  String studentFood,
  String studentYearGroup
  ) 
  async{
  var url = Uri.http("beamapp-a16fe.ew.r.appspot.com", "/users");
  var request = await http.put(
    url, 
    headers:{'Content-Type':'application/json'},
    body: jsonEncode(<String, String>{
    
        "Fav_food": studentFood,
        "Fav_movie": studentMovie,
        "major": studentMajor,
        "residence": studentResidence,
        "student_ID": studentID,
        "year_group": studentYearGroup


  
    }),

  );
  print(request.statusCode);
  if (request.statusCode == 200){
    print("Success");
    print(request.body);
    

  }
  else{
    print("eRROR");
  }

}




  @override
  Widget build(BuildContext context) {

  //Student details fetched from the database
  String newName = studentInfo.name;
  String newEmail = studentInfo.studentEmail;
  String newDob = studentInfo.studentDateOfBirth;
  String newYearGroup = studentInfo.studentYearGroup;
  String newResidence = studentInfo.studentResidence;
  String newMovie = studentInfo.studentMovie;
  String newFood = studentInfo.studentFood;
  String newID = studentInfo.student_ID;
  String newMajor = studentInfo.studentMajor;

  //Hint Text that represents the user's current info
    String yearGroupHintText = newYearGroup;
    String foodHintText = newFood;
    String movieHintText = newMovie;



  //Form for collecting user edits
    return Scaffold(
      body: Form(
        key: _signUpInfo,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
           Text('Edit Account', style: Theme.of(context).textTheme.headlineMedium),


              // Year Group Field
              Padding(
                padding:EdgeInsets.all(4.0),
                child:TextFormField(
                  controller: _yearGroupController,
                  decoration:InputDecoration(
                    hintText: "Year Group - $yearGroupHintText",
                    prefixIcon: Icon(UniconsLine.graduation_cap)
                    ),
                onSaved: (value){
                  _studentYearGroup = value ?? newYearGroup;
                }
                )
              ),

              //Residence drop down 
              Padding(
                padding: EdgeInsets.all(4.0),
                child:DropdownButtonFormField(
                  items: _residenceOptions.map((item) {
                  return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
                decoration:const InputDecoration(
                  filled:true,
                  fillColor: Colors.green
                ),
                onSaved: (value){
                  _studentResidence = value ?? newResidence;
                },

              value: _selectedResidence,
              hint:const Text('Residential Status'),
              onChanged: (value){
                setState((){
                  _selectedResidence = value;
                  _dropDownColor = Colors.green;
                  
                }
                );
              },
              ),
              ),

            // Major drop down 
            Padding(
              padding:EdgeInsets.all(4.0),
               child: DropdownButtonFormField(
                items: _majorOptions.map((item) {
                  return DropdownMenuItem(
                  value: item,
                  child: Text(item),
               );}).toList(),
               hint: const Text('Select your major'),
               decoration:const InputDecoration(
                filled:true,
                fillColor: Colors.green,
               ),
               onSaved: (value){
                _studentMajor = value ?? newMajor;
               },
               value: _selectedMajor,
               onChanged: (value){

              },
               ),
               ),


              // Favourite Food Field
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _favFoodTextController,
                  decoration:  InputDecoration(
                  hintText: "Favourite Food - $foodHintText",
                  prefixIcon: Icon(UniconsLine.crockery)
                  ),
                  onSaved:(value){
                    _studentFood = value?? newFood;
                  }
                )
                ),

                // Favourite movie field
                Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _favMovieTextController,
                  decoration: InputDecoration(
                  hintText: "Favourite movie - $movieHintText",
                  prefixIcon: Icon(UniconsLine.film)
                  ),
                  onSaved: (value){
                    _studentMovie = value ?? newMovie;
                  }
                )
                ),

                //Navigaation buttons
                Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only( bottom : 5.0),
                child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states){
                      return states.contains(MaterialState.disabled)
                      ? null : Colors.white;
                    }
                  ),
                  minimumSize: MaterialStateProperty.all(const Size(150, 50)), 

                  backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states){
                      return states.contains(MaterialState.disabled)
                      ? null : Colors.blue;
                    }
                  ),
                ),
                onPressed: () {
                  if (_signUpInfo.currentState!.validate()) {
                    _studentID = newID;
                    _signUpInfo.currentState!.save();
                    _submitForm();
                    showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Beam Response'),
                  content: Text('Your profile has been successfully edited.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
                  }
                },

                child: const Text('Edit Beam Pass'),
                ) 
                ),
                
                const SizedBox(width: 30,),
                
                Padding(
                padding: EdgeInsets.only( bottom : 5.0),
                child: TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states){
                      return states.contains(MaterialState.disabled)
                      ? null : Colors.white;
                    }
                  ),
                  minimumSize: MaterialStateProperty.all(const Size(150, 50)), 

                  backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states){
                      return states.contains(MaterialState.disabled)
                      ? null : Colors.blue;
                    }
                  ),
                ),
                onPressed: () {
                 Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                },

                child: const Text('Welcome Page'),
                ) 
                )
              
            ],
          ),

            //   Padding(
            //     padding: EdgeInsets.only( bottom : 5.0),
            //     child: TextButton(
            //     style: ButtonStyle(
            //       foregroundColor: MaterialStateProperty.resolveWith(
            //         (Set<MaterialState> states){
            //           return states.contains(MaterialState.disabled)
            //           ? null : Colors.white;
            //         }
            //       ),
            //       minimumSize: MaterialStateProperty.all(const Size(150, 50)), 

            //       backgroundColor: MaterialStateProperty.resolveWith(
            //         (Set<MaterialState> states){
            //           return states.contains(MaterialState.disabled)
            //           ? null : Colors.blue;
            //         }
            //       ),
            //     ),
            //     onPressed: () {
            //       if (_signUpInfo.currentState!.validate()) {
            //         _studentID = newID;
            //         _signUpInfo.currentState!.save();
            //         _submitForm();
            //         showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: Text('Beam Response'),
            //       content: Text('Your profile has been successfully edited.'),
            //       actions: [
            //         TextButton(
            //           onPressed: () {
            //             Navigator.pop(context);
            //             Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => WelcomeScreen()),
            //         );
            //           },
            //           child: Text('OK'),
            //         ),
            //       ],
            //     );
            //   },
            // );

             

            //       }
            //     },

            //     child: const Text('Edit Beam Pass'),
            //     ) 
            //     )
               //Test 8.0 value here
          ],
        ),
      ),
    );
  }
}