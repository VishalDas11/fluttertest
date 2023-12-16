import 'package:flutter/material.dart';
import 'package:fluttertest/controller/getx_controller.dart';
import 'package:fluttertest/screens/reciepe_detail.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final StateController controller = Get.put(StateController());
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => Column(
          children: [
            SearchBar(
              onSearch: (value) {
                setState(() {
                  controller.filterRecipesByTitle(value);
                });
              },
              controller: searchController,
            ),
            controller.loading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                      value: 0.3,
                    ),
                  )
                : Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: searchController.text.isEmpty
                                    ? controller.productList.length
                                    : controller.filteredRecipes.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, mainAxisSpacing: 8),
                                itemBuilder: (context, int index) {
                                  var recipe = searchController.text.isEmpty
                                      ? controller.productList[index]
                                      : controller.filteredRecipes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RecipeDetail(
                                              reciepeModel: recipe),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.black,
                                      elevation: 4.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(12.0),
                                              ),
                                              child: Image.network(
                                                recipe.image.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 3),
                                            child: Text(
                                              recipe.title.toString(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final Function(String)? onSearch;
  final TextEditingController controller;

  const SearchBar({Key? key, this.onSearch, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: 'Search for recipes...',
          icon: Icon(Icons.search),
          border: InputBorder.none,
        ),
        onChanged: onSearch,
      ),
    );
  }
}
