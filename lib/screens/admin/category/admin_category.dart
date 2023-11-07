import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:library_app/dbfunctions/bookdb.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/models/admin_model/category_model.dart';
import 'package:library_app/screens/admin/category/categoryadd.dart';
import 'package:library_app/screens/admin/category/categoryedit.dart';
import 'package:library_app/screens/admin/category/categoryviewalladmin.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class AdminCategory extends StatelessWidget {
  const AdminCategory({super.key});

  @override
  Widget build(BuildContext context) {
    refreshcategory();
    return Scaffold(
      appBar: CustomAppBar(
        titleofpage: 'Category',
        isBackRequired: false,
        iseditRequired: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: false,
            context: context,
            builder: (context) {
              return const CategoryAdd();
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 79, 103, 92),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: categoryadded,
                  builder:
                      (BuildContext context, List<CategoryModel> newList, _) {
                    return newList.isEmpty
                        ? Center(
                            child: Text(
                              'No Category Added',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          )
                        : SlidableAutoCloseBehavior(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final data = newList[index];
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      extentRatio: .2,
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Text(
                                                  'Are you sure to delete the "${data.categorytype}"',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text(
                                                        'No',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      )),
                                                  TextButton(
                                                      onPressed: () async {
                                                        final count =
                                                            await tocheckcategorycontentcount(
                                                                data.categorytype);
                                                        if (count == 0) {
                                                          deletecategory(
                                                              data.categoryid);
                                                          Navigator.of(context)
                                                              .pop();
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              10))),
                                                                  elevation: 5,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content: Text(
                                                                    'Deleted',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )));
                                                        } else {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              10))),
                                                                  elevation: 5,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content: Text(
                                                                    "This category contains books.So it can't deleted",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )));
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Yes',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.green),
                                                      )),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: Icons.delete,
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.black,
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                      ],
                                    ),
                                    startActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      extentRatio: .2,
                                      children: [
                                        SlidableAction(
                                            onPressed: (context) {
                                              showModalBottomSheet(
                                                isScrollControlled: true,
                                                isDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return CategoryEdit(
                                                      data: data);
                                                },
                                              );
                                            },
                                            icon: Icons.edit,
                                            backgroundColor: Colors.blue,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10)))
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return CategoryViewAdmin(
                                              name: data.categorytype,
                                            );
                                          },
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              data.categorytype,
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: newList.length),
                          );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
