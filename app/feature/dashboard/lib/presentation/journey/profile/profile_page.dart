import 'package:feature_dashboard/presentation/journey/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

// TODO(Melly): move to independent feature
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: LayoutDimen.dimen_16.w,
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: LayoutDimen.dimen_41.h,
                    ),
                    Image.asset(
                      'assets/images/profile.png',
                      width: LayoutDimen.dimen_120.w,
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      height: LayoutDimen.dimen_36.h,
                    ),
                    if (state is ProfileLoaded) ...[
                      Text(
                        state.user.name,
                        style: TextStyle(
                          fontSize: LayoutDimen.dimen_18.minSp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        state.user.email,
                        style: TextStyle(
                          fontSize: LayoutDimen.dimen_16.minSp,
                        ),
                      ),
                      Text(
                        state.user.phone,
                        style: TextStyle(
                          fontSize: LayoutDimen.dimen_16.minSp,
                        ),
                      ),
                      SizedBox(
                        height: LayoutDimen.dimen_53.h,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                          LayoutDimen.dimen_20.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            LayoutDimen.dimen_10.w,
                          ),
                          color: CustomColors.secondary.c50.withOpacity(0.7),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Perusahaan'),
                                Text('Toko Adi Jaya Sembako'),
                              ],
                            ),
                            SizedBox(
                              height: LayoutDimen.dimen_16.w,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Posisi'),
                                Text('Kasir'),
                              ],
                            )
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
