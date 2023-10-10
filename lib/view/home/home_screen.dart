import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gardenia/shared/bottomnavigation/core/constants.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  ValueNotifier<bool> notifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    notifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    notifier.value = true;
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Container(
                          decoration: const BoxDecoration(gradient: gcolor),
                          height: 300,
                          child: Image.network(
                            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.5tFGU4QsY1cfsFm9QZJD1wHaE9%26pid%3DApi&f=1&ipt=f77b75f6c62783af2b2397e203912dfad58459e8bf93c7eb92b4fe5fe5921f3f&ipo=images',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                          child: Row(
                            children: [],
                          ),
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          final crossAxisCount =
                              constraints.maxWidth > 600 ? 3 : 2;
                          const aspectRatio = 3.0 / 4.0;
                          return gridMethord(aspectRatio, crossAxisCount);
                        }),
                      ],
                    ),
                    notifier.value == true ? topContainer() : const SizedBox(),
                  ],
                ),
              );
            }),
      ),
    );
  }

  AnimatedContainer topContainer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      width: double.infinity,
      height: 130,
      color: Colors.white.withOpacity(0.6),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Gardenia',
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SearchWidget(),
        ],
      ),
    );
  }

  GridView gridMethord(double aspectRatio, int crossAxisCount) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: aspectRatio,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return const ProductTile(
            name: 'sdaf',
            subname: 'kjbdfvjkjklndvkln',
            rate: 23,
            image:
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.cmRHPqeRkBl0I2so0qf-NwHaJ4%26pid%3DApi&f=1&ipt=d851d30b7eb26026a889e36fb9f4bd923d4090835bf9271130ceae085fe8b899&ipo=images',
            description: 'dsfdsfadf');
      },
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          border: InputBorder.none,
          labelText: "Search",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  final String name;
  final String subname;
  final int rate;
  final String image;
  final String description;

  const ProductTile({
    Key? key,
    required this.name,
    required this.subname,
    required this.rate,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isAddedToWishlist = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                )),
            child: Stack(
              children: [
                Positioned(
                    left: size.width / 3.2,
                    top: -4,
                    child: IconButton(
                      icon: Icon(
                        isAddedToWishlist
                            ? CupertinoIcons.suit_heart_fill
                            : CupertinoIcons.heart,
                        color: Colors.black,
                        size: 24,
                      ),
                      onPressed: () async {},
                    ))
              ],
            ),
          ),
          Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
          Text(
            widget.subname,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "₹${widget.rate}.00",
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
