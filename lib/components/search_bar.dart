import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class PlacesSearchBar extends StatelessWidget {
  const PlacesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: SearchAnchor(
          builder: (BuildContext context,
            SearchController controller) {
            return SearchBar(
              controller: controller,
              hintText: "주소 검색",
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)
              ),
              leading: const Icon(Icons.search),
              // onTap: () => controller.openView(),
              // onChanged: (_) => controller.openView()
            );
          },
          suggestionsBuilder: (BuildContext context,
            SearchController controller) {
            return List<ListTile>.generate(
              0,
              (int index) {
                return const ListTile();
              }
            );
          },
        )
      )
    );
  }
}