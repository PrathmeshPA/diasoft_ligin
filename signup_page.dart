//import 'dart:html';

import 'dart:convert';


import 'package:d_app/main.dart';
import 'package:d_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:regexpattern/regexpattern.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final firstname =TextEditingController();
  final lastname =TextEditingController();
  final email =TextEditingController();
  final password =TextEditingController();
  final mobileno =TextEditingController();

  Future sign_up (BuildContext context) async {
    
    Map mapdata ={
        "firstname": firstname.text,
        "lastname" : lastname.text,
        "email": email.text,
        "password": password.text,
        "mobileno": mobileno.text
    };
    print("json data : ${mapdata}");
    

      var url = Uri.parse("http://localhost/signup_data.php");
      var resp = await http.post(url , body: mapdata);
      var resultdata = jsonDecode(resp.body);
     // var resultdata =await json.decode(json.encode(resp.body));
    if(resultdata == "success"){
      Navigator.push(
         context,MaterialPageRoute(builder: (context)=> loginpage()),
       );
    }
    else {
      Fluttertoast.showToast(
        msg: "invalid data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white
        );
    }
     
  }

  

  String first_name = "";
  String last_name = "";
  String pass = "";
  String g_email = "";
  String p_Number = "";

  var _formkey = GlobalKey<FormState>();
  
  Widget _buildFirstName() {
    return TextFormField(
      controller: firstname,
      decoration: InputDecoration(
        labelText: "First Name",
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          
          return "First name is Required";
        }
        else if (!RegExp(r'^[a-zA-Z]{1,16}$', caseSensitive: false)
            .hasMatch(value)) {
              
          return 'Invalid First Name';
        }         
      },
    
      onSaved: (String? value) {
        first_name = value!;
       
        
      },
    );
  }
   Widget _buildLastName() {
    return TextFormField(
      controller: lastname ,
      decoration: InputDecoration(
        labelText: "Last Name",
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
         
          return "Last name is Required";
        }
        else if (!RegExp(r'^[a-zA-Z]{1,16}$', caseSensitive: false)
            .hasMatch(value)) {
              
          return 'Invalid Last Name';
        }
      },
      onSaved: (String? value) {
        last_name = value!;
      },
    );
  }

  
   Widget _buildEmail() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Email adress",
          border: OutlineInputBorder(),
          hintText: "Please Enter Your Email Adress"),
      validator: (String? value) {
        if (value!.isEmpty) {
         
          return "Email is Required";
        }
        else if  (!RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
        ).hasMatch(value)) {
          
          return 'Please enter a valid email Address';
        }
      },

      onSaved: (String? value) {
        g_email = value!;
        
      },
    );
  }


  Widget _buildPassword() {
    return TextFormField(
      controller: password,
      decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(),
          hintText: "Select Password"),
      obscureText: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Password is Required";
        }
        else if  (!RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                caseSensitive: true)
            .hasMatch(value)) {

              
          return 'Please enter a valid Password';
        }
      },
      onSaved: (String? value) {
        pass = value!;
      },
    );
  }


  Widget _buildPhoneNumber() {
    return TextFormField(
      controller: mobileno,
      maxLength: 10,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          labelText: "Mobile Number",
          border: OutlineInputBorder(),
          hintText: "Please Enter Your Mobile Number"),
      validator: (String? value) {
        if (value!.isEmpty) {
          
          return "Mobile Number is Required";
        }
        else if  (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
          
          return 'Please enter a valid Mobile Number';
        }
      },
      onSaved: (String? value) {
       
        p_Number = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFirstName(),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                          child: _buildLastName()),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // _buildUserName(),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  _buildEmail(),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildPassword(),
                  SizedBox(
                    height: 10.0,
                  ),
                  
                  _buildPhoneNumber(),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15.0),
                          minimumSize: Size(300.0, 50.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () {
                        
                        if (_formkey.currentState!.validate()  ) {
                          sign_up(context);
                          
                            

                      }
                        _formkey.currentState!.save();
                        //  Navigator.push(
                        //     context,MaterialPageRoute(builder: (context)=> loginpage()),
                        //       );

                        // print(_username);
                        // print(_password);
                        // print(_email);
                        // print(_phoneNumber);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => loginpage()
                        // ));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
