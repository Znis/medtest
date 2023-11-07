import 'package:medtest/medtest/medtest_app_theme.dart';
import 'package:medtest/medtest/home_medtest.dart';
import 'package:medtest/medtest/models/category.dart';
import 'package:medtest/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key, this.callBack, this.displayCategory})
      : super(key: key);

  final Function(int, bool)? callBack;
  final CategoryType? displayCategory;

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> displayCategoryList = Category.categoryListBasics;
    switch (widget.displayCategory) {
      case CategoryType.basics:
        displayCategoryList = Category.categoryListBasics;
        break;

      case CategoryType.blood:
        displayCategoryList = Category.categoryListBlood;
        break;

      case CategoryType.hormone:
        displayCategoryList = Category.categoryListHormone;
        break;

      default:
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: displayCategoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = displayCategoryList.length > 10
                      ? 10
                      : displayCategoryList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return CategoryView(
                    category: displayCategoryList[index],
                    animation: animation,
                    animationController: animationController,
                    callback: widget.callBack!,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryView extends StatefulWidget {
  const CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,
      required this.callback})
      : super(key: key);

  final Function(int, bool) callback;
  final Category? category;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - widget.animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                return widget.callback(widget.category!.id, true);
              },
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                              child: Text(
                                                widget.category!.title,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  letterSpacing: 0.27,
                                                  color: DesignCourseAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       right: 16, bottom: 8),
                                          //   child: Row(
                                          //     mainAxisAlignment:
                                          //         MainAxisAlignment
                                          //             .spaceBetween,
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment.center,
                                          //     children: <Widget>[

                                          //       // Container(
                                          //       //   child: Row(
                                          //       //     children: <Widget>[
                                          //       //       Text(
                                          //       //         '${category!.rating}',
                                          //       //         textAlign:
                                          //       //             TextAlign.left,
                                          //       //         style: TextStyle(
                                          //       //           fontWeight:
                                          //       //               FontWeight.w200,
                                          //       //           fontSize: 18,
                                          //       //           letterSpacing: 0.27,
                                          //       //           color:
                                          //       //               DesignCourseAppTheme
                                          //       //                   .grey,
                                          //       //         ),
                                          //       //       ),
                                          //       //       Icon(
                                          //       //         Icons.star,
                                          //       //         color:
                                          //       //             DesignCourseAppTheme
                                          //       //                 .nearlyBlue,
                                          //       //         size: 20,
                                          //       //       ),
                                          //       //     ],
                                          //       //   ),
                                          //       // )
                                          //     ],
                                          //   ),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16, right: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  '\$${widget.category!.money}',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .nearlyBlue,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    widget.callback(0, false);
                                                    setState(() {
                                                      cartItemsList[widget
                                                              .category!.id] =
                                                          !cartItemsList[widget
                                                              .category!.id];
                                                      cartItemsList[widget
                                                              .category!.id]
                                                          ? cartItemCount++
                                                          : cartItemCount--;
                                                      cartItemsList[widget.category!.id]
                                                          ? Fluttertoast.showToast(
                                                              msg: 'Item Added',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  Colors.green[
                                                                      400],
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 14.0)
                                                          : Fluttertoast.showToast(
                                                              msg:
                                                                  'Item Removed',
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity: ToastGravity
                                                                  .BOTTOM_LEFT,
                                                              timeInSecForIosWeb:
                                                                  1,
                                                              backgroundColor:
                                                                  DesignCourseAppTheme
                                                                      .nearlyBlue
                                                                      .withOpacity(
                                                                          0.7),
                                                              textColor:
                                                                  Colors.white,
                                                              fontSize: 14.0);
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          DesignCourseAppTheme
                                                              .nearlyBlue,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  8.0)),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Icon(
                                                        cartItemsList[widget
                                                                .category!.id]
                                                            ? Icons.close
                                                            : Icons.add,
                                                        color: cartItemsList[
                                                                widget.category!
                                                                    .id]
                                                            ? DesignCourseAppTheme
                                                                .nearlyWhite
                                                            : DesignCourseAppTheme
                                                                .nearlyWhite,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 24, left: 16),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child:
                                      Image.asset(widget.category!.imagePath)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
