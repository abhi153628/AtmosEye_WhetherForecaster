import 'package:atmoseye/common/colors.dart';
import 'package:atmoseye/common/text_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('asset/Animation - 1721398740250.json', height: 150),
            const SizedBox(height: 20),
             CustomTextStyle(text: 'Fetching the latest weather data for you...',color: black,fontWeight: FontWeight.bold,fontsize: 15,),
             SizedBox(height: 20,),
              CustomTextStyle(text: '⋘ 𝑙𝑜𝑎𝑑𝑖𝑛𝑔 𝑑𝑎𝑡𝑎...⋙',color: black,fontWeight: FontWeight.bold,fontsize: 25,),
          ],
        ),
      ),
    );
  }
}
