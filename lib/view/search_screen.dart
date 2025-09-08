import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/search_viewmodel.dart';
import '../widget/highlight_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final vm = context.read<SearchViewModel>();
    _controller = TextEditingController(text: vm.query);

    // Khi người dùng gõ, cập nhật ViewModel
    _controller.addListener(() {
      vm.onQueryChanged(_controller.text);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: Column(
              children: [
                // Search box
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    cursorColor: Colors.blueAccent,
                    decoration: InputDecoration(
                      hintText: "Enter keyword",
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                        height: 2.0,
                      ),
                      border: InputBorder.none,
                      prefixIcon:
                          vm.isLoading
                              ? const Padding(
                                padding: EdgeInsets.all(12),
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              )
                              : const Icon(Icons.search, color: Colors.black),
                      suffixIcon:
                          _controller.text.isNotEmpty
                              ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  _controller.clear();
                                  vm.clearQuery();
                                },
                              )
                              : null,
                    ),
                  ),
                ),

                // Results
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.results.length,
                    itemBuilder: (_, index) {
                      final item = vm.results[index];
                      return ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: HighlightText(
                          text: item.displayName,
                          query: vm.query,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.directions),
                          onPressed:
                              () => vm.openInGoogleMaps(item.lat, item.lon),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
