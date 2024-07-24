import 'dart:ui';
import 'package:atmoseye/bloc/whether_bloc_bloc.dart';
import 'package:atmoseye/common/colors.dart';
import 'package:atmoseye/common/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  Widget getWhetherIcon(int code) {
    String imagePath;
    // Default imag/
    imagePath = 'assets/1 (1).png';

    // Determine imagePath based on code
    if (code >= 200 && code <= 299) {
      imagePath = 'asset/1 (1).png';
    } else if (code >= 300 && code <= 399) {
      imagePath = 'asset/2 (1).png';
    } else if (code >= 400 && code <= 499) {
      imagePath = 'asset/3 (1).png';
    } else if (code >= 500 && code <= 599) {
      imagePath = 'asset/4.png';
    } else if (code >= 600 && code <= 699) {
      imagePath = 'asset/5 (1).png';
    } else if (code >= 700 && code <= 799) {
      imagePath = 'asset/6.png';
    } else if (code >= 800 && code <= 899) {
      imagePath = 'asset/7 (1).png';
    }

    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + _animationController!.value * 0.2,
          child: Image.asset(imagePath),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, 
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 153, 0),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              SizedBox(height: 8),
              BlocBuilder<WhetherBlocBloc, WhetherBlocState>(
                builder: (context, state) {
                  if (state is WhetherBlocSucess) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextStyle(
                            text: 'Hi there! ',
                            fontsize: 25,
                            color: white,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomTextStyle(
                            text: 'Atmoseye predicts ${state.weather.weatherMain!} today in ${state.weather.areaName}',
                            fontsize: 15,
                            color: Color.fromARGB(255, 191, 185, 185),
                            fontWeight: FontWeight.bold,
                          ),
                          getWhetherIcon(state.weather.weatherConditionCode!), // Adjust as necessary
                          Center(
                            child: CustomTextStyle(
                              text: '${state.weather.temperature!.celsius!.round()}°C',
                              fontsize: 59,
                              color: white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Center(
                            child: CustomTextStyle(
                              text: '${state.weather.weatherMain!.toUpperCase()} !',
                              fontsize: 30,
                              color: white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Center(
                            child: CustomTextStyle(
                              text: DateFormat('EEE dd ').add_jm().format(state.weather.date!),
                              fontsize: 15,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('asset/11.png', scale: 8),
                                  SizedBox(width: 5),
                                  Column(
                                    children: [
                                      CustomTextStyle(
                                        text: 'Sunrise',
                                        fontsize: 13,
                                        color: Colors.grey,
                                      ),
                                      CustomTextStyle(
                                        text: DateFormat().add_jm().format(state.weather.sunrise!),
                                        fontsize: 15,
                                        color: white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset('asset/12.png', scale: 8),
                                  SizedBox(width: 5),
                                  Column(
                                    children: [
                                      CustomTextStyle(
                                        text: 'Sunset',
                                        fontsize: 13,
                                        color: Colors.grey,
                                      ),
                                      CustomTextStyle(
                                        text: DateFormat().add_jm().format(state.weather.sunset!),
                                        fontsize: 15,
                                        color: white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset('asset/13.png', scale: 8),
                                  SizedBox(width: 5),
                                  Column(
                                    children: [
                                      CustomTextStyle(
                                        text: 'Temp Max',
                                        fontsize: 13,
                                        color: Colors.grey,
                                      ),
                                      CustomTextStyle(
                                        text: '${state.weather.tempMax!.celsius!.round()} °C',
                                        fontsize: 15,
                                        color: white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset('asset/14.png', scale: 8),
                                  SizedBox(width: 1),
                                  Column(
                                    children: [
                                      CustomTextStyle(
                                        text: 'Temp Min',
                                        fontsize: 13,
                                        color: Colors.grey,
                                      ),
                                      CustomTextStyle(
                                        text: '${state.weather.tempMin!.celsius!.round()} °C',
                                        fontsize: 15,
                                        color: white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 17),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
