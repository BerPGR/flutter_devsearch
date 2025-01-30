import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_devs/features/profile/bloc/profile_bloc.dart';
import 'package:search_devs/features/profile/bloc/profile_event.dart';
import 'package:search_devs/features/profile/bloc/profile_state.dart';
import 'package:search_devs/features/profile/repository_model.dart';
import 'package:search_devs/features/home/user_model.dart';
import 'package:search_devs/features/profile/widgets/profile_user_info_mobile.dart';
import 'package:search_devs/features/profile/widgets/screens/desktop.dart';
import 'package:search_devs/features/profile/widgets/screens/mobile.dart';
import 'package:search_devs/utils/date_parser.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  final UserModel user;

  ProfilePage({required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final profileBloc = ReadContext(context).read<ProfileBloc>();
    profileBloc.add(ProfileLoadEvent(widget.user.username));

    return LayoutBuilder(builder: (context, constraints) {
      bool isMobileOrTablet = constraints.maxWidth < 1200;
      if (isMobileOrTablet) {
        return ProfileMobile(profileBloc: profileBloc, user: widget.user);
      } else {
        return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else if (state is ProfileLoaded) {
            return ProfileDesktop(profileBloc: profileBloc, user: widget.user);
          }
          return SizedBox.shrink();
        });
      }
    });
  }


}

            /*  return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildProfileSection(widget.user),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 3,
                    child: _buildRepositoryList(state.repositories, context),
                  ),
                ],
              );
            }*/