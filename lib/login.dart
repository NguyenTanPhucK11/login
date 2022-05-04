import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/ManageLogin.dart';
import 'dart:async';

class Login extends StatefulWidget {
  static const routeName = '/login';
  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var urlImg = 'lib/images/';

  _distant(double _heihgt) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.005 * _heihgt,
    );
  }

  bool _rememberValue = false;
  bool _showPassword = false;
  bool _clicked = false;
  final _mainColor = Colors.orange;
  final _backgroundColor = Colors.white;
  TextEditingController _userName = TextEditingController();
  TextEditingController _userPassword = TextEditingController();

  final FocusNode _idFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final _keyUsername = GlobalKey<FormState>();
  final _keyPassword = GlobalKey<FormState>();

  void _passHideShow() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget line(Color colors) {
    return Container(
      margin: EdgeInsets.all(3),
      height: 4.0,
      width: 30.0,
      color: colors,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // autoLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _scale = 0.5;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        key: _key,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    var screenSize = MediaQuery.of(context).size;
    var _scale = 0.5;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          right: screenSize.width * 0.2 * _scale,
          left: screenSize.width * 0.2 * _scale,
          top: screenSize.height * 0.15 * _scale,
          bottom: screenSize.height * 0.04 * _scale,
        ),
        child: Column(
          children: [
            Image.asset('images/ic_fpt_is_network.jpg'),
            Text(
              'LOGIN WITH FLUTTER',
              style: TextStyle(
                color: Colors.blueGrey[700],
                fontSize: 45 * _scale,
                fontWeight: FontWeight.bold,
              ),
            ),
            _distant(2 * _scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                line(Colors.blue),
                line(_mainColor),
                line(Colors.green)
              ],
            ),
            _distant(10 * _scale),
            // Text(
            //   'LOGIN',
            //   style: TextStyle(
            //     color: _mainColor,
            //     fontSize: 38 * _scale,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            mainLogin(),
            _distant(18 * _scale),
            Image.asset(
              'images/swipe.png',
              scale: 2 * _scale,
            ),
          ],
        ),
      ),
    );
  }

  Widget mainLogin() {
    var _scale = 0.5;
    return Column(
      children: <Widget>[
        _distant(6 * _scale),
        Form(
          key: _keyUsername,
          child: TextFormField(
            focusNode: _idFocus,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z0-9]+|\s"))
            ],
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              suffixIcon: Icon(null),
              hintText: 'Username',
            ),
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              _keyUsername.currentState.validate();
            },
            controller: _userName,
            validator: (value) {
              return value.isEmpty ? 'Please enter email or phone' : null;
            },
          ),
        ),
        _distant(6 * _scale),
        Form(
          key: _keyPassword,
          child: TextFormField(
            focusNode: _passFocus,
            obscureText: !_showPassword,
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: _showPassword
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                onPressed: _passHideShow,
              ),
              hintText: 'Password',
            ),
            onChanged: (value) {
              _keyPassword.currentState.validate();
            },
            textInputAction: TextInputAction.next,
            controller: _userPassword,
            validator: (value) {
              return value.isEmpty ? 'Please enter password' : null;
            },
          ),
        ),
        _distant(6 * _scale),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: SizedBox(
                  width: Checkbox.width,
                  height: Checkbox.width,
                  child: Container(
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: _mainColor,
                      ),
                      borderRadius: new BorderRadius.circular(100),
                    ),
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.transparent,
                      ),
                      child: Checkbox(
                        value: _rememberValue,
                        onChanged: (value) => setState(() {
                          _rememberValue = value;
                        }),
                        activeColor: _mainColor,
                        checkColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06 * _scale),
              Text(
                'Remember login',
                style: TextStyle(
                  color: _mainColor,
                  fontSize: 30 * _scale,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        _distant(6 * _scale),
        RaisedButton(
          onPressed: _clicked
              ? null
              : () async {
                  if (_keyUsername.currentState.validate() ||
                      _keyPassword.currentState.validate()) {
                    if (_keyUsername.currentState.validate() &&
                        _keyPassword.currentState.validate()) {
                      setState(() => _clicked = true);
                      if (_clicked) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                  child: Platform.isIOS
                                      ? Theme(
                                          data: ThemeData(
                                              cupertinoOverrideTheme:
                                                  CupertinoThemeData(
                                                      brightness:
                                                          Brightness.dark)),
                                          child: CupertinoActivityIndicator())
                                      : CircularProgressIndicator());
                            });
                        await new Future.delayed(const Duration(seconds: 2));
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManageLogin()));
                        await Future.delayed(Duration(milliseconds: 300));
                        setState(() => _clicked = false);
                        await Future.delayed(Duration(milliseconds: 300));
                      }
                    }
                  }
                },
          color: _mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12 * _scale,
            decoration: new BoxDecoration(),
            child: Center(
              child: Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 35 * _scale,
                  color: _backgroundColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
