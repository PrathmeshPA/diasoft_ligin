import 'dart:convert';

import 'package:d_app/appdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginpage(),
    );
  }
}
 
 class loginpage extends StatefulWidget {
  const loginpage({ Key? key }) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  final username=TextEditingController();
  final userpass=TextEditingController();
  
  Future signin(BuildContext conte) async{

    // ignore: unrelated_type_equality_checks
    if(username.text == "" || userpass.text == ""){
       Fluttertoast.showToast(
        msg: "Fill username and password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
       backgroundColor: Colors.black,
        textColor: Colors.white
        
         );
    }
    else {
        var uri = Uri.parse('http://192.168.29.222//userdata.php');
        var respo = await http.post(uri, body: {
          "username" : username.text,
          "userpass" : userpass.text,
    });

   var Adata = jsonDecode(respo.body);
    // ignore: unrelated_type_equality_checks
    if(Adata == "yes"){
      Navigator.push(
         conte,MaterialPageRoute(builder: (context)=> api()),
      );
    }
    else{
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
 }

    


  GlobalKey<FormState> fromk=GlobalKey<FormState>(); 

  // void validate(){
  //   var currentState = fromk.currentState;
  //   if(currentState!.validate()){
      
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LogianPage")),
        body: Padding(
          
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Center(
                child: Card(
                  
                  child: Form(
                    key: fromk ,
                    child: Column(
                      children: [
                        
                        Center(
                          child: Form(child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                 child: Image.asset("assets/dlogo.jpeg",width: 200,height: 200,),
                                ),
                                TextFormField(
                                  controller: username,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.account_box),
                                    hintText: "User Name",labelText: "Enter username"
                                  ),
                                  validator: (value){
                                    if(value! . isEmpty){
                                      return "required";
                                    }else{
                                      return null  ;
                                  }                                                                                                
                                    
                                  },
                                ),
                                SizedBox(height: 20,),
                                TextFormField(
                                  controller: userpass,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.lock),
                                    hintText: "Password",labelText:"Enter Password"
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton(onPressed: (){
                          // validate();
                          signin(context);
                        },
                        child: Text("LogIn"),
                        color: Colors.blue,
                        textColor: Colors.white,
                        )
                      ],
                                  
                            ),
                  ),
                ),
              ),
            ),),
        ),
    );
  }
}

