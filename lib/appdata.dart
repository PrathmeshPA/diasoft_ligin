import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:get/get.dart';

class api extends StatefulWidget {
  
  
  @override
  _apiState createState() => _apiState();
}

// ignore: camel_case_types
class _apiState extends State<api> {

  

  List product = [];
   getdata() async {
    var rec= await http.get(Uri.parse("http://192.168.29.222/getbal.php"));
    if (rec.statusCode==200)
    setState(() {
     product = jsonDecode(rec.body);
    });
    
    print(product);
    return product;

  // final response = await http.get(Uri.parse('http://192.168.29.222/newfile.json'));
  // print(json.decode(response.body));

  }

  @override
  void initState() {
    
    super.initState();
    getdata();
  
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("ApiData"),
    ),
     body:
     //Center(child: Text(getdata.toString())),
     
    ListView.builder(
      itemCount: product.length,
      itemBuilder: (context,index){
          

      return ListTile(
        leading: Text(product[index]['name']),
        trailing: Text(product[index]['code']),
        //title: Text(product[index]['capital']) ,
        );
      }
    )
    );

    
    
    
  }
}