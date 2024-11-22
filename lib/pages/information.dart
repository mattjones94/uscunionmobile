

import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';


class AppInformation extends StatefulWidget {
  const AppInformation({ Key? key }) : super(key: key);

  @override
  State<AppInformation> createState() => _AppInformationState();
}

class _AppInformationState extends State<AppInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.uscuBurgendy,
      appBar: AppBar(
        title: Text(
          "Information",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          ),
          backgroundColor: AppTheme.colors.uscuBurgendy,
      ),

      body: 
       Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              width: 375,
              height: 300,
              child: Center(
                child: Text(
                  "Lead Developer: Colby Jones\n Assistant Developer: David Lothers\n Current App Version:\n Please check regularly for new updated app versions\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  )
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                  
              ),
            ),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.all(10),
              ),
              onPressed: (){}, 
              child: 
                Text(
                  "Check for Updates",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ) ,
                )
              ),
          ],
        ),
      ),
    );
  }
}