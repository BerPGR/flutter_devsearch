import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_devs/services/storage_service.dart';
import '../home_bloc.dart';

class HomeTablet extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final StorageService _storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          const SizedBox(height: 20),
          _buildSearchRow(context, homeBloc),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: "Search ",
        style: TextStyle(fontSize: 65, color: Color(0xFF0069CA)),
        children: [
          TextSpan(
            text: "d_evs",
            style: TextStyle(fontSize: 65, color: Color(0xFF8C19D2)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchRow(BuildContext context, HomeBloc homeBloc) {
    return Row(
      children: [
        Expanded(child: _buildSearchField(context, homeBloc)),
        const SizedBox(width: 10),
        _buildSearchButton(homeBloc),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context, HomeBloc homeBloc) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: 'Search',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          homeBloc.searchUser(value.trim());
          _storageService.addSearchHistory(value.trim());
        }
      },
    );
  }

  Widget _buildSearchButton(HomeBloc homeBloc) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8C19D2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () {
        if (_controller.text.trim().isNotEmpty) {
          homeBloc.searchUser(_controller.text.trim());
          _storageService.addSearchHistory(_controller.text.trim());
        }
      },
      child: const Text('Search', style: TextStyle(color: Colors.white)),
    );
  }
}
