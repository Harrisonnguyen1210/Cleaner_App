import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABOUT',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24.0),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(fontSize: 20, color: Consts.textGrey),
                    children: [
                      TextSpan(
                        text: Consts.aboutTextFirstPart,
                      ),
                      TextSpan(
                        text: Consts.kimEmail,
                        style: TextStyle(
                          color: Consts.primaryBlue,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                      ),
                      TextSpan(
                        text: Consts.aboutTextSecondPart,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24.0),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 10,
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/METROPOLIA_UAS_LOGO.png',
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 10,
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/LEVITEZER_LOGO.png',
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 10,
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/SODEXO_LOGO.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
