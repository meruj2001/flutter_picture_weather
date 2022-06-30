import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stroktrail/dataSource/picture_api_service.dart';
import 'package:stroktrail/models/picture_model.dart';
import 'package:stroktrail/pages/third_page.dart';

class PictureScreen extends StatefulWidget {
  const PictureScreen({Key? key}) : super(key: key);

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  static const _pageSize = 10;

  final PagingController<int, PictureModel> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, PictureModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(itemBuilder: (context, item, index) {
          return Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            color: Colors.white,
            shadowColor: Colors.red,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16/9,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createRoute(item.downloadUrl ?? ""));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      width: 0,
                      child: Hero(
                        tag: item.downloadUrl ?? "",
                        child: CachedNetworkImage(
                          imageUrl: item.downloadUrl ?? "",
                          maxWidthDiskCache: 1920,
                          maxHeightDiskCache: 1080,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.red,)),
                          errorWidget: (context, url, error) => const Icon(Icons.error_outlined),
                        ),
                      )
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    item.author ?? "",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await PictureApiService.getPictures(pageKey, _pageSize);
      final isLastPage = newItems.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void dispose() {
    log("picture dispose");
    _pagingController.dispose();
    super.dispose();
  }

  Route _createRoute(String url) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ThirdWidget(imageUrl: url,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
}
