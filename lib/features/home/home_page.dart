import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:search_devs/services/github_service.dart';
import 'package:search_devs/services/storage_service.dart';
import 'home_bloc.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final StorageService _storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(GithubService(), _storageService),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            bool isWideScreen = constraints.maxWidth > 810;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Search ",
                      style: TextStyle(
                        fontSize: isMobile ? 50 : 80,
                        color: const Color(0xFF0069CA),
                      ),
                      children: [
                        TextSpan(
                          text: "d_evs",
                          style: TextStyle(
                            fontSize: isMobile ? 50 : 80,
                            color: const Color(0xFF8C19D2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search Field
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is HomeError) {
                        return Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        );
                      }

                      if (state is HomeLoaded) {
                        Modular.to
                            .pushNamed('/profile', arguments: state.user)
                            .then((_) {
                          _controller.clear();
                          BlocProvider.of<HomeBloc>(context).clearSearch();
                        });
                      }

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  focusNode: _focusNode,
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    labelText: 'Search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: const OutlineInputBorder(),
                                  ),
                                  onSubmitted: (value) {
                                    if (value.trim().isNotEmpty) {
                                      BlocProvider.of<HomeBloc>(context)
                                          .searchUser(value.trim());
                                    }
                                  },
                                ),
                              ),
                              if (isWideScreen) const SizedBox(width: 10),
                              if (isWideScreen)
                                Container(
                                  height: 48,
                                  width: 176,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF8C19D2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_controller.text.trim().isNotEmpty) {
                                        BlocProvider.of<HomeBloc>(context)
                                            .searchUser(
                                                _controller.text.trim());
                                      }
                                    },
                                    child: const Text(
                                      'Search',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (!isWideScreen && !isMobile)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8C19D2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_controller.text.trim().isNotEmpty) {
                                      BlocProvider.of<HomeBloc>(context)
                                          .searchUser(
                                              _controller.text.trim());
                                    }
                                  },
                                  child: const Text(
                                    'Search',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}