import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:grupocsl/controllers/orders/photos_before_controller.dart';
import 'package:grupocsl/views/orders/photos/before/components/add_tile_widget.dart';
import 'package:grupocsl/views/orders/photos/before/components/list_images.dart';


class PhotoBeforeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adicionar fotos'
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(5),
        child: GetBuilder<PhotoBeforeController>(
          init: PhotoBeforeController(),
          builder: (photoBeforeController){ 
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisCount: 4,
              itemCount: photoBeforeController.images.length + 1,
              itemBuilder: (ctx, index){
                if(index < photoBeforeController.images.length){
                  return ListImages(photoBeforeController.images[index].path, index);
                } else{
                  return AddTileWidget();
                }
              },
              staggeredTileBuilder: (index){
                return StaggeredTile.count(
                  2,
                  index.isEven ? 2 : 1,
                );
              },
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            );
          },
        ),
      ),
    );
  }
}