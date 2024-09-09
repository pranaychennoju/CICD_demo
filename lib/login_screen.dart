import 'package:elearning_app/dashboard/Bottomnavigationbar.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome!",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 30,
                              letterSpacing: 4),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sign in to continue",
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w900,
                              fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Password',
                              suffixIcon: Icon(Icons.visibility_off_rounded)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                height: 44.0,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    gradient: LinearGradient(colors: [
                                      Color.fromARGB(255, 12, 1, 82),
                                      Colors.blue
                                    ])),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarWidget(),
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        color: Colors.white, letterSpacing: 2),
                                  ),
                                ),
                              ),
                              const TextButton(
                                  onPressed: null,
                                  child: Text('Forgot Password?')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(),
                      ))
                    ],
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Social Media Login",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assects/images/google.png',
                                // height: 50,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assects/images/fb.png',
                                // height: 50,
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Dont have an account?'),
                              const SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
