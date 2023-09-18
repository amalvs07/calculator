import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';



class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String  result="0";
String useerinput="";

List<String> ButtonList=[
  'AC',
  '(',
  ')',
  '/',
  '7',
  '8',
  '9',
  '*',
  '4',
  '5',
  '6',
  '+',
  '1',
  '2',
  '3',
  '-',
  'C',
  '0',
  '.',
  '=',
];

  @override
  Widget build(BuildContext context) { 

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        SizedBox(
          height: MediaQuery.of(context).size.height/2.5,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                useerinput,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  
                ),
              ),
            ),
                Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            )
          ]),
        ),
        Divider(color:Colors.white),
        Expanded(child: Container(
          
          padding: EdgeInsets.all(10),
          child:GridView.builder(
            itemCount:ButtonList.length ,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12
              ), 
          itemBuilder: (BuildContext context,int index){
            return CustomButton(ButtonList[index]);
          })
        ))
      ]),
    );
  }


  Widget CustomButton(String text){
    return InkWell(
      splashColor:Colors.black,
      onTap: (){
        setState(() {
          handleButtons(text);
        });
      },
      child:
      Ink(
        decoration: 
        BoxDecoration(
          color:getBgColor(text),
          
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: Offset(-3,-3),
            ),
          ],
        ),
        child: Center(
          child: Text(text,
          style: TextStyle(
            color: getColor(text),
            fontSize:30,
            fontWeight: FontWeight.bold 

            ),
            
          ),
        ),
      )
    );
  }
  getColor(String text){
    if (
      text=="/"||
      text=="*"||
      text=="+"||
      text=="-"||
      text=="C"||
      text=="("||
      text==")"
      
    
    ) {
      return Color.fromARGB(255, 252, 100, 100);
    } 
    return Colors.white;
  }


    getBgColor(String text){
    if (text=="AC") {
      return Color.fromARGB(255, 252, 100, 100);
    } 
     if (text=="=") {
      return Color.fromARGB(255, 100, 211, 96);
    } 
    return Colors.black;
  }


  handleButtons(String text){
    if (text=="AC") {
      useerinput="";
      result="0";
      return;
    }
    if (text=="C") {
      if (useerinput.isNotEmpty) {
          useerinput=useerinput.substring(0,useerinput.length-1);
            
            return;
          }
   else{
    return null;
   }
      
    }

       if (text=="=") {
      
      result=calculated();
      useerinput=result;
      if(result.endsWith(".0")){
       result=result.replaceAll(".0", "");
      }
       if(useerinput.endsWith(".0")){
       useerinput=useerinput.replaceAll(".0", "");
      }
      return;
    }
    useerinput=useerinput+text;

  }
  String calculated(){
    try {
      var exp=Parser().parse(useerinput);
      var evaluation=exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "error";
    }
  }
}

