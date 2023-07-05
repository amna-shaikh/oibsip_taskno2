import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calculator extends StatefulWidget {
  static TextEditingController Data = TextEditingController();
  @override
  _calculatorState createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  List<String> expression_list = ['CE','()','%','+','7','8','9','-','6','5','4','*','3','2','1','/', '.','0','C','=' ];
  var userinput = '';
  var output = '';
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
            backgroundColor: Colors.white,

            body:
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
              [
               Padding(
                padding: EdgeInsets.only(top: 70),
                  child: Text(
                    userinput,
                     textAlign: TextAlign.right,
                    maxLines: 1,
                    style: TextStyle(fontSize: 35 ,color: Colors.black ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 80),
                  child: Text(
                        output,
                       textAlign: TextAlign.right,
                        maxLines: 1,
                        style: TextStyle(fontSize: 35 , color: Colors.black),
                      )),

              Expanded(
                child: GridView.builder(
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4


                    ),
                    itemCount: expression_list.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: (){
                          String result = expression_list[index];
                          if(result == "=")
                            {
                              calculate();
                            }
                          else if(result == "C"){
                            setState(() {
                              userinput = "";
                              output = "";
                            });

                          }
                          else if(result == "CE"){
                            setState(() {
                           if(output.isNotEmpty){

                           }
                           else {
                             userinput =
                                 userinput.substring(0, userinput.length - 1);
                           }

                            });

                          }

                          else {
                            setState(() {
                             // userinput += " ";
                              userinput +=result;
                              print(result);
                            });

                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                         decoration: BoxDecoration(
                         border: Border.all(color: Colors.black),
                           color: index == 0 || index == 1 || index == 2 ||index == 3 || index == 7 || index == 11|| index == 15 || index == 19 ?  Colors.amber : Colors.white,
                      ),
                          child: Text(expression_list[index] , style: TextStyle(color: Colors.black , fontWeight:   FontWeight.w400 , fontSize: 30),),
                        ),
                      );
                    }),
              ),
            ]),


             ),
    );}
  void calculate() {
    setState(() {
      try {
        String UserOutput = userinput;
        UserOutput = userinput.replaceAll('x', '*');
        Parser p = Parser();
        Expression exp = p.parse(UserOutput);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        output = eval.toString();
        print(output);
      } catch(e){
        output = "Invalid syntax";
      }

    });
  }
}

