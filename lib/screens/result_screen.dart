import 'package:ecofriendlyinsects/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  int marks;
  var mydata;

  ResultPage({Key key, @required this.marks, @required this.mydata})
      : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState(marks, mydata);
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = [
    "assets/expert.jpg",
    "assets/amateur.jpg",
    "assets/beginner.jpg"
  ];

  String message;
  String image;

  @override
  void initState() {
    if (marks > 7) {
      image = images[0];
      message =
          "When it comes to insects, you're the bees knees!\n$name, you have scored $marks!";
    } else if (marks > 3) {
      image = images[1];
      message =
          "You know your bugs from your beetles!\n$name, you have scored $marks!";
    } else {
      image = images[1];
      message =
          "There are lots of amazing insects still to be discovered!\n$name, your score is $marks!";
    }
    super.initState();
  }

  int marks;
  var mydata;

  _ResultPageState(this.marks, this.mydata);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "RESULT",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.8,
            fontFamily: "Poppins",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
                  child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * (3 / 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      image: AssetImage(
                        image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                ),
              ),
            ],
          ))),
          Container(
              height: 75.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => _Answer(
                                mydata: mydata,
                              )));
                    },
                    child: Text(
                      "See answers",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class _Answer extends StatefulWidget {
  var mydata;

  _Answer({Key key, @required this.mydata}) : super(key: key);

  @override
  _AnswerState createState() => _AnswerState(mydata);
}

class _AnswerState extends State<_Answer> {
  var mydata;

  _AnswerState(this.mydata);

  int i = 1;

  Widget Question(int i) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text.rich(TextSpan(children: <TextSpan>[
            TextSpan(
                text: "Ques $i :",
                style: TextStyle(
                    color: Color(0xFF242B54),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins")),
            TextSpan(
                text: " ${mydata[0][i.toString()]}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.normal,
                )),
          ])),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text.rich(TextSpan(children: <TextSpan>[
              TextSpan(
                  text: "Ans :",
                  style: TextStyle(
                      color: Color(0xFF0B5C46),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins")),
              TextSpan(
                  text: " ${mydata[2][i.toString()]}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.italic)),
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
            child: Divider(
              color: Color(0xFF242B54),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ANSWERS",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.8,
              fontFamily: "Poppins",),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Question(1),
          Question(2),
          Question(3),
          Question(4),
          Question(5),
          Question(6),
          Question(7),
          Question(8),
          Question(9),
          Question(10),
          Container(
            height: 15.0,
          )
        ],
      ),
    );
  }
}
