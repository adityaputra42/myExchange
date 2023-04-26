import 'package:crypto_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
 return Scaffold(
  backgroundColor: AppColor.blackText,bottomNavigationBar:  BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(4.h),
                        
                      ),
                      activeIcon: Padding(
                        padding: EdgeInsets.all(4.h),
                        
                      ),
                      label: 'Wallet',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(4.h),
                        
                      ),
                      activeIcon: Padding(
                        padding: EdgeInsets.all(4.h),
                        
                      ),
                      label: 'Activity',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Padding(
                        padding: EdgeInsets.all(4.h),
                       
                      ),
                      activeIcon: Padding(
                        padding: EdgeInsets.all(4.h),
                        
                      ),
                      label: 'Explorer',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.all(4.h),
                       
                      ),
                      activeIcon: Padding(
                        padding: EdgeInsets.all(4.h),
                        
                      ),
                      label: 'Settings',
                    ),
                  ],
                  elevation: 0,
                  currentIndex: 0,
                  onTap: (value) {},
                  backgroundColor: Colors.transparent,
                  
                  selectedLabelStyle: AppFont.semibold12,
                  unselectedItemColor: AppColor.darkerGray,
                  showUnselectedLabels: true,
                  unselectedLabelStyle:
                      AppFont.semibold12.copyWith(color: AppColor.darkerGray),
                ),
 );
  }
  }