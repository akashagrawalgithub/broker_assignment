import 'package:broker/presentation/screen/authentication.dart';
import 'package:broker/presentation/widget/brokerOption.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrokerSelectionScreen extends StatefulWidget {
  const BrokerSelectionScreen({super.key});

  @override
  State<BrokerSelectionScreen> createState() => _BrokerSelectionScreenState();
}

class _BrokerSelectionScreenState extends State<BrokerSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Choose Your Broker",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Select your preferred trading platform",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32),
              BrokerOption(
                name: "Zerodha",
                logo:
                    "https://play-lh.googleusercontent.com/wnNYBAH1m-XJMfduOHfEATQAhCwyKUYeHAD1Fi9-OjtxKyPKjFEmgWvbx-OX2dM65xjp",
                color: Colors.blue,
                onTap: () {
                  Get.to(
                    () => UserLogin(
                      logo:
                          "https://play-lh.googleusercontent.com/wnNYBAH1m-XJMfduOHfEATQAhCwyKUYeHAD1Fi9-OjtxKyPKjFEmgWvbx-OX2dM65xjp",
                      name: "Zerodha",
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              BrokerOption(
                name: "Groww",
                logo: "https://groww.in/groww-logo-270.png",
                color: Colors.blue,
                onTap: () {
                  Get.to(
                    () => UserLogin(
                      logo: "https://groww.in/groww-logo-270.png",
                      name: "Groww",
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              BrokerOption(
                name: "Upstox",
                logo:
                    "https://logosandtypes.com/wp-content/uploads/2022/08/Upstox.png",
                color: Colors.blue,
                onTap: () {
                  Get.to(
                    () => UserLogin(
                        logo:
                    "https://logosandtypes.com/wp-content/uploads/2022/08/Upstox.png",
                name: "Upstox",
                    ),
                  );
                },
              ),
              SizedBox(height: 16),

              BrokerOption(
                name: "Angel One",
                logo:
                    "https://play-lh.googleusercontent.com/Ic8lUYwMCgTePpo-Gbg0VwE_0srDj1xD386BvQHO_mOwsfMjX8lFBLl0Def28pO_Mvk",
                color: Colors.blue,
                onTap: () {
                  Get.to(
                    () => UserLogin(
                         name: "Angel One",
                logo:
                    "https://play-lh.googleusercontent.com/Ic8lUYwMCgTePpo-Gbg0VwE_0srDj1xD386BvQHO_mOwsfMjX8lFBLl0Def28pO_Mvk",
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
