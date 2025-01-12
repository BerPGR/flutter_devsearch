import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
                  children: [
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      user.name.split(" ").first,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xFF171923),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "@${user.username}",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
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
                  Text("${user.followers} seguidores",
                      style: TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                spacing: 8,
                children: [
                  SvgPicture.asset('assets/svgs/following.svg'),
                  Text("${user.following} seguindo",
                      style: TextStyle(fontSize: 14))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(user.bio, style: TextStyle(fontSize: 16)),
          const SizedBox(
            height: 24,
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/company.svg"),
                  Text(user.company ?? "No company",
                      style: TextStyle(fontSize: 14))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/location.svg"),
                  Text(user.location ?? "No location",
                      style: TextStyle(fontSize: 14))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/email.svg"),
                  Text(user.email ?? "No email", style: TextStyle(fontSize: 14))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/link.svg"),
                  if (user.blog!.isEmpty)
                    Text("No Blog", style: TextStyle(fontSize: 14))
                  else
                    Text(user.blog!, style: TextStyle(fontSize: 14))
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  SvgPicture.asset("assets/svgs/twitter.svg"),
                  Text(user.twitterUsername ?? "No twitter",
                      style: TextStyle(fontSize: 14))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
