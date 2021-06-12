import 'package:flutter/material.dart';
import 'package:tic_tac_toe/UserName.dart';
import 'HomePage.dart';

class HumanPage extends StatefulWidget {
  String player1 = '';
  String player2 = '';

  HumanPage({Key? key, required this.player1, required this.player2}) : super(key: key);
  
  @override
  _HumanPageState createState() => _HumanPageState();
}
  
class _HumanPageState extends State<HumanPage> {
  // declartions 
  bool oTurn = true; 
    
  // 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  void _clearBoard() {
   setState(() {
     for (int i = 0; i < 9; i++) {
       displayElement[i] = '';
     }
   });
 
   filledBoxes = 0;
 }
 
 void _clearScoreBoard() {
   setState(() {
     xScore = 0;
     oScore = 0;
     for (int i = 0; i < 9; i++) {
       displayElement[i] = '';
     }
   });
   filledBoxes = 0;
 }

  void _showWinDialog(String winner) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Your " + winner + " is Winner!!!"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }
  
  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _checkWinner() {
    
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }
  
    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }
  
    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: (){
            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserNamePage()),
                    );
          },
        ), 
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.player1,
                        style: TextStyle(fontSize: 20,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.black),
                      ),
                      Text(
                        xScore.toString(),
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.player2, style: TextStyle(fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black)
                      ),
                      Text(
                        oScore.toString(),
                        style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[   
          Text("Choose who will go first"),    
          SizedBox(
            width:20,
          ),     
          RaisedButton(
              textColor: Colors.black,
              onPressed: () {
               _clearBoard();
                setState(() {
                  oTurn = false;
                });
              },
              child: Text(widget.player1),
            ),
            SizedBox(
              width: 20
            ),
             RaisedButton(
              textColor: Colors.black,
              onPressed: () {
                _clearBoard();
                setState(() {
                  oTurn = true;
                });
              },
              child: Text(widget.player2),
            ),]
        ),
          ),
          Expanded(   
            // Creating the Board for Tic tac toe
            child: Padding(
              padding: const EdgeInsets.fromLTRB(250, 0, 250, 0),
              child: Align(
                              child: Container(
                                height: 400,
                                width: 400,
                  child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },
                          // child: Text("Hye"),
                          child: Align(
                                child: Container(
                              height: 400,
                              width: 400,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red)),
                              child: Center(
                                child: Text(
                                  displayElement[index],
                                  style: TextStyle(color: Colors.black, fontSize: 35),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [ RaisedButton(
                    textColor: Colors.black,
                    onPressed: () {
                     _clearScoreBoard();
                    },
                    child: Text("Clear score board"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    textColor: Colors.black,
                    onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                    },
                    child: Text("Go back to home"),
                  )]
            ),
          ),
        ],
      ),
    );
  }
  
  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
        oTurn = !oTurn;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
        oTurn = !oTurn;
      }
  
      _checkWinner();
    });
  }
    
}