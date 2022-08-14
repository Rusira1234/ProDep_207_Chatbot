import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_js/javascriptcore/jscore_runtime.dart';
//import 'package:flutter/services.dart';
//import 'dart:js' as js;
//import 'package:flutter_js/flutter_js.dart';
//import 'package:flutter_js/javascriptcore/jscore_runtime.dart';
//import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

//import 'package:js/js.dart' as js;
//import 'package:js' as js;
//import '../Business Logic/chatbot-deployment-main/static/app.js' as logic;
final JavascriptRuntime jsRuntime = getJavascriptRuntime();
var count = 0;
var name_counter = 0;
String user_name = "";
String the_bot_result = "";
String theReplyMessage = "";
bool count_exceeds = false;
var user_reponses = [];
/* Response response;
var dio = Dio(); */
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String theReply = "";
  //JavascriptRuntime jsRuntime;
  Future<String> getTestReply(
      JavascriptRuntime jsRuntime, String testReply) async {
    print(testReply);
    String appJs = await rootBundle.loadString("assets/theTest.js");
    //final theEquation = "sendReply($testReply)";
    final jsResult =
        jsRuntime.evaluate(appJs + """sendReply("${testReply}")""");
    print(jsResult);
    final jsStringResult = jsResult.stringResult;
    final yooReply = jsStringResult.toString();
    return jsStringResult;
  }

  Future<String> getBotReply(String userReply) async {
    String appJs = await rootBundle.loadString(
        "assets/Business Logic/chatbot-deployment-main/static/app2.js");
    final jsResult = await jsRuntime.evaluate(appJs +
        """onSendButton("${userReply}","${count}", "${name_counter}")""");
    final jsStringResult = jsResult.stringResult;
    count++;
    name_counter++;
    return jsStringResult;
  }

  /* Future<String> theFunction(JavascriptRuntime jsRuntime, String query) async {
    String theJs = await rootBundle
        .loadString("Business Logic/chatbot-deployment-main/static/app.js");
    final jsResult = jsRuntime.evaluate(theJs + """onSendButton($query""");
    final jsStringResult = jsResult.stringResult;
    return jsStringResult;
  } */
  @override
  void initState() {
    super.initState();
    messsages.insert(0, {
      "data": 0,
      "message":
          "Sanvadaya aramba keerima sandaaha obage nama atulath karanna :)"
    });
  }

  void response(String query) async {
    /* try {
      //await getBotReply(jsRuntime, query);
      print(query);
      String message_test = await getBotReply(query);
      setState(() {
        messsages.insert(0, {"data": 0, "message": message_test});
      });
    } on PlatformException catch (e) {
      print('error: ${e.details}');
    } */
    /*   final response = await dio
        .post('http://127.0.0.1:5000' + '/predict', data: {"message": query});
    print(response); */
    user_reponses.add(query);
    if (name_counter == 0) {
      user_name = query;
      name_counter++;
    }
    var questions = [
      "Obage wayasa kopamana weiida ?",
      user_name + " , adha dhavasa obata kohomadha :) ?",
      "Ada davase oyage wadda plan ekata anuwa wenavadda (wistratmakava pawasanna) ?",
      "matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha",
      "mona wagge contents da oyya facebook ekke wadiyenma dakkke ?",
      user_name + " , matta kiyanna Oya adda mona hari upset ekenda inne ?",
      "adda davase obagae twitter baavitaya pilibandha yamak pawasanna...",
      user_name + " , oya mea welave hodinda inne ? :)",
      "adda davasse oyage meal plan eka gana oya satis wenavadda ?",
      "oya dinapatha sports walla yedenavada ?",
      "adda davasse mea wenakun oyya kochara welavak films baluwada ? mona wage films da baluwe ?",
      "oya films balanne kammali hinda da nattam karanna wadak nati hinda da ehemath nattam .... ?",
      "oyya samanayen books kiyawanavada ? books dinapatha kiyaweema gana mokada hitanne ?",
      user_name +
          " , oyyage adda davasse goal ekuk tiyenavada ? ekka sampoorna kara ganna oyya lassthida ? :)",
      "oya dinapatha sports walla yedenavada ?",
      "oya social media use karanne mona wage popurses walatada ?",
      "matta kiyanna oyyge adda davasa gatta wenna vidiha ganna oya monna widihatada satis wenne? :)",
      user_name +
          " , avasanna washyen obata mona hari avul sahagata prashnayak / hageemak tibenum eya maa hata pawasanna, kenekta pawaseemen oabage manasa nidahas wenava :) ",
      "Sanvadayata sambandha vunata godaaak stuthii.. obata Suba davasak weewwa " +
          user_name +
          " !! Neerogiyawa sitinna :)"
    ];
    try {
      final response = await http.post(
        Uri.parse("http://localhost:5000/predict"),
        body: jsonEncode({"message": query}),
        headers: {"Content-Type": "application/json"},
      );
      print(json.decode(response.body)["answer"]);
      the_bot_result = json.decode(response.body)["answer"].toString();
    } catch (error) {
      print("Error: " + error);
    }
    try {
      if (count >= 19) {
        count_exceeds = true;
      }

      if (count >= 7 && (query == "ow" || query == "oww")) {
        //questions[count] = questions[count];
        String correctQuestion = questions[count];
        questions[count] = correctQuestion;
      } else {
        if (the_bot_result != "Matta Therunne naha...") {
          if (the_bot_result ==
                  "Matta kiyanna oyya upset ekken inna hetuwa :)" &&
              (count == 6)) {
            questions[count] = the_bot_result;
          } else {
            if (the_bot_result !=
                "Matta kiyanna oyya upset ekken inna hetuwa :)") {
              if (!count_exceeds) {
                questions[count] = the_bot_result + " " + questions[count];
              } else {
                questions[count] = the_bot_result;
              }
            } else {
              if (!count_exceeds) {
                questions[count] = questions[count];
              } else {
                questions[count] = the_bot_result;
              }
            }
          }
          if (questions[count] ==
              "Matta kiyanna oyya upset ekken inna hetuwa :) matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha") {
            questions[count] =
                "matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha";
          }
          if (count == 19) {
            questions[count] = ":)";
          }
        } else {
          if (count == 19) {
            questions[count] = ":)";
          }
        }
      }

      if (the_bot_result ==
              "hondai :) facebook use kalle nati vunata kamak naha " &&
          user_reponses.contains("4")) {
        questions[count] = the_bot_result + " " + questions[count + 1];
      }

      if (count_exceeds) {
        questions[count] = ":)";
      }
      /*  if (questions[count - 1] == "oya dinapatha sports walla yedenavada ?") {
        questions[count] =
            the_bot_result + " oya dinapatha sports walla yedenavada ?";
      } */
      theReplyMessage = questions[count];
    } catch (error) {
      if (the_bot_result != "" && the_bot_result != "Matta Therunne naha...") {
        theReplyMessage = the_bot_result + " :) ";
      } else {
        theReplyMessage = ":)";
      }
    }

    //let msg2 = {name: "Sam", message: questions[count]};
    //this.messages.push(msg2);

    setState(() {
      messsages.insert(0, {"data": 0, "message": theReplyMessage});
    });

    if (count >= 7 && (query == "ow" || query == "oww")) {
      count++;
    }

    if (the_bot_result == "Matta kiyanna oyya upset ekken inna hetuwa :)" &&
        (count == 6)) {
      count--;
    }

    if (the_bot_result ==
            "hondai :) facebook use kalle nati vunata kamak naha " &&
        user_reponses.contains("4")) {
      count++;
    }

    if (questions[count] ==
        "Matta kiyanna oyya upset ekken inna hetuwa :) matta kiyanna oya adda kochara wella facebook use kalada ? (option ekuk select karanna) \n 1. 1 to 2 hours \n 2. 3 to 4 hours \n 3. more than 4 hours \n 4. use kalle nahha") {
      count++;
    }
    /*  if (questions[count - 1] == "oya dinapatha sports walla yedenavada ?") {
      count++;
    } */
    count++;
    // thi is done to clear the bot reply to avoid colids in if checks.
    the_bot_result = "";
    /* setState(() {
      messsages.insert(
          0, {"data": 0, "message": json.decode(response.body)["answer"]});
    }); */

    //final result = await js.context.callMethod("onSendButton", [query]);

    //final result = await theFunction(jsRuntime, query);
    /*  final chatbox = new logic.Chatbox(query);
    theReply = js.allowInterop(
      F: chatbox.onSendButton(query),
    ); */
    //theReply = js.context.callMethod('onSendButton', [query]);
/*     AuthGoogle authGoogle = await AuthGoogle(
        fileJson: "assets/service.json")
        .build();
    Dialogflow dialogflow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query); */

    //print(aiResponse.getListMessage()[0]["text"]["text"][0].toString());
  }

/*   Future<String> getTestReply(
      JavascriptRuntime jsRuntime, String testReply) async {
    String appJs = await rootBundle.loadString("assets/theTest.js");
    final jsResult = jsRuntime.evaluate(appJs + """sendReply($testReply)""");
    final jsStringResult = jsResult.stringResult;
    final yooReply = jsStringResult.toString();
    return jsStringResult;
  } */

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat bot",
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Today, ${DateFormat("Hm").format(DateTime.now())}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 5.0,
              color: Colors.greenAccent,
            ),
            Container(
              child: ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.greenAccent,
                    size: 35,
                  ),
                ),
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageInsert,
                    decoration: InputDecoration(
                      hintText: "Enter a Message...",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onChanged: (value) {},
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30.0,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      if (messageInsert.text.isEmpty) {
                        print("empty message");
                      } else {
                        setState(() {
                          messsages.insert(
                              0, {"data": 1, "message": messageInsert.text});
                        });
                        response(messageInsert.text);
                        messageInsert.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  //for better one i have use the bubble package check out the pubspec.yaml

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/robot.jpg"),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: data == 0
                    ? Color.fromRGBO(23, 157, 139, 1)
                    : Colors.orangeAccent,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/default.jpg"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
