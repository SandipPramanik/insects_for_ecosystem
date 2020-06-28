import 'dart:convert';

import 'package:ecofriendlyinsects/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(25.0, 15.0, 15.0,
                15.0), // top will be 15.0 if appbar is given else it should be 45.0
            child: Text(
              "Insect Quiz",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 5.0),
                    blurRadius: 10.0,
                  )
                ],
              ),
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: AssetImage("assets/opening.jpg"),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Are you an expert entomologist or an insect novice? "
                    "Answer these ten questions about insects to find out!",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[800],
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => GetJson()));
                    },
                    child: Text(
                      "Start Quiz",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).primaryColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GetJson extends StatelessWidget {
  String assetload;

  setAsset() {
    assetload = "assets/quiz/quiz.json";
  }

  @override
  Widget build(BuildContext context) {
    setAsset();

    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(assetload, cache: true),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text("Loading"),
            ),
          );
        } else {
          return _QuizPage(mydata: mydata);
        }
      },
    );
  }
}

class _QuizPage extends StatefulWidget {
  var mydata;

  _QuizPage({Key key, @required this.mydata}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState(mydata);
}

class _QuizPageState extends State<_QuizPage> {
  var mydata;

  _QuizPageState(this.mydata);

  Color colorToShow = Colors.grey[300];
  Color right = Colors.green[400];
  Color wrong = Colors.red[400];
  int marks = 0;
  var _firstPress = true;
  int i = 1;

  Map<String, Color> btncolor = {
    "a": Colors.grey[300],
    "b": Colors.grey[300],
    "c": Colors.grey[300],
  };

  void nextQuestion() {
    setState(() {
      _firstPress = true;
      if (i < 10) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ResultPage(marks: marks, mydata: mydata)));
      }
      btncolor["a"] = Colors.grey[300];
      btncolor["b"] = Colors.grey[300];
      btncolor["c"] = Colors.grey[300];
    });
  }

  void checkAnswer(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      marks = marks + 1;
      colorToShow = right;
    } else {
      colorToShow = wrong;
    }
    setState(() {
      btncolor[k] = colorToShow;
    });
  }

  Widget ChoiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: MaterialButton(
        onPressed: () async {
          if (_firstPress) {
            _firstPress = false;
            checkAnswer(k);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            mydata[1][i.toString()][k],
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
        ),
        color: btncolor[k],
        splashColor: Colors.indigoAccent,
        highlightColor: Colors.indigoAccent,
        minWidth: double.infinity,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget txt;
    if (i < 10) {
      txt = Text(
        "NEXT QUESTION",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      txt = Text(
        "FINISH TEST",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
        ),
      );
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Insect Quiz",
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
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Text(
                "Question $i of 10",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins"),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.centerLeft,
                  child: ListView(
                    children: <Widget>[
                      Text(
                        mydata[0][i.toString()],
                        style: TextStyle(fontSize: 18.0, fontFamily: "Poppins"),
                      ),
                    ],
                  )),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ChoiceButton('a'),
                  ChoiceButton('b'),
                  ChoiceButton('c'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      onPressed: () {
                        nextQuestion();
                      },
                      child: txt,
                      color: Colors.yellow[400],
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
