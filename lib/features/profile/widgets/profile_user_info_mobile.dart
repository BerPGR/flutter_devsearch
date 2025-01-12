import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_devs/features/models/user_model.dart';

class ProfileUserInfoMobile extends StatelessWidget {
  final UserModel user;
  const ProfileUserInfoMobile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFFf2ebff)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                child: Image.network(user.avatarUrl),
                backgroundColor: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [Text(user.name), Text("@${user.username}")],
                ),
              )
            ],
          ),
          Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 8,
                children: [
                  SvgPicture.asset('assets/svgs/followers.svg'),
                  Text("${user.followers} seguidores"),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  SvgPicture.asset('assets/svgs/following.svg'),
                  Text("${user.following} seguindo")
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(user.bio),
          const SizedBox(
            height: 24,
          ),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/company.svg"),
                  Text(user.company ?? "No company")
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/location.svg"),
                  Text(user.location ?? "No location")
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/email.svg"),
                  Text(user.email ?? "No email")
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/link.svg"),
                  if (user.blog!.isEmpty)
                    Text("No Blog")
                  else
                    Text(user.blog!)
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/twitter.svg"),
                  Text(user.twitterUsername ?? "No twitter")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
