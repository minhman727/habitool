import 'package:flutter/material.dart';

import 'package:habitool/Custom_Values/custom_colors.dart';
import 'package:habitool/view/screen/home_screen.dart';
import 'package:habitool/view/screen/intro/login_screen.dart';
import 'package:habitool/view/screen/intro/verify_screen.dart';
import 'package:habitool/widgets/field.dart';
import 'package:habitool/model/methods.dart';
import 'package:provider/provider.dart';
import 'package:habitool/model/auth_provider.dart';
import 'package:habitool/view/screen/dashboard/dashboard_screen.dart';
import 'package:habitool/view/screen/intro/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;

  final TextEditingController _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _RePasswordController = TextEditingController();

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.light,
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: <Widget>[
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: CustomColors.blue,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(30)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 115.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 25.0,
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 25.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Đăng Ký',
                                      style: TextStyle(
                                        color: CustomColors.black,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                      child: field(size, "", _emailController)),
                                  SizedBox(height: 20.0),
                                  Container(
                                    child: TextFormField(
                                        controller: _passwordController,
                                        decoration: InputDecoration(
                                          labelText: 'Mật khẩu',
                                          labelStyle: TextStyle(
                                            color: CustomColors.grey,
                                            fontSize: 15,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              (_isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            onPressed: _toggleObscure,
                                          ),
                                        ),
                                        obscureText: _isObscure,
                                        validator: (val) {
                                          if (val.isEmpty)
                                            return 'Yêu cầu nhập mật khẩu';
                                          return null;
                                        }),
                                  ),
                                  SizedBox(height: 20.0),
                                  Container(
                                    child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Nhập lại mật khẩu',
                                          labelStyle: TextStyle(
                                            color: CustomColors.grey,
                                            fontSize: 15,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              (_isObscure
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            onPressed: _toggleObscure,
                                          ),
                                        ),
                                        obscureText: _isObscure,
                                        controller: _RePasswordController,
                                        validator: (val) {
                                          if (val.isEmpty)
                                            return 'Yêu cầu nhập lại mật khẩu';
                                          if (val != _passwordController.text)
                                            return 'sai mật khẩu';
                                          return null;
                                        }),
                                  ),
                                  SizedBox(height: 50.0),
                                  customButton(size, "Đăng ký")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 25.0),
                          // Row(
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: ElevatedButton.icon(
                          //         style: ElevatedButton.styleFrom(
                          //           primary: Colors.white,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(30),
                          //           ),
                          //           minimumSize: Size(100, 50),
                          //         ),
                          //         icon: Image.asset(
                          //           'assets/images/google-logo.png',
                          //           height: 35.0,
                          //         ),
                          //         label: Text('Google',
                          //             style: TextStyle(
                          //               color: CustomColors.darkgrey,
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.bold,
                          //             )),
                          //         onPressed: () => googleSignIn().then((user) {
                          //           if (user != null) {
                          //             Navigator.pushAndRemoveUntil(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                     builder: (context) =>
                          //                         DashBoardScreen()),
                          //                 (route) => false);
                          //           }
                          //         }),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 25.0,
                          //     ),
                          //     Expanded(
                          //       child: ElevatedButton.icon(
                          //         style: ElevatedButton.styleFrom(
                          //           primary: Colors.white,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(30),
                          //           ),
                          //           minimumSize: Size(100, 50),
                          //         ),
                          //         icon: Image.asset(
                          //           'assets/images/facebook-logo.png',
                          //           height: 35.0,
                          //         ),
                          //         label: Text(
                          //           'Facebook',
                          //           style: TextStyle(
                          //             color: CustomColors.darkgrey,
                          //             fontSize: 14,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //         onPressed: () {},
                          //         onLongPress: () {},
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 25.0,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Bạn đã có tài khoản? ',
                                style: TextStyle(
                                  color: CustomColors.darkgrey,
                                  fontSize: 13,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogInScreen()),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Đăng nhập",
                                    style: TextStyle(
                                      color: CustomColors.link,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget customButton(Size size, String text) {
    return GestureDetector(
      onTap: () {
        if (_emailController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            _RePasswordController.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          createAccount(_emailController.text, _passwordController.text,
                  _RePasswordController.text)
              .then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => VerifyScreen()));
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        content: Text('Đăng ký thành công'),
                      ));
            } else {

              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text('Đăng ký không thành công'),
                  ));
              print("Please enter Fields");
              print("SignUp failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Text('Đăng ký không thành công'),
                  ));
          print("Please enter Fields");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: CustomColors.blue,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
