import 'package:flutter/material.dart';
import 'package:library_app/dbfunctions/categorydb.dart';
import 'package:library_app/models/admin_model/category_model.dart';
import 'package:library_app/screens/admin/category/categoryviewalladmin.dart';
import 'package:library_app/screens/user/screen/category/user_categorwise_view.dart';
import 'package:library_app/screens/widgets/common/customappbar.dart';

class UserCategory extends StatelessWidget {
  const UserCategory({super.key});

  @override
  Widget build(BuildContext context) {
    refreshcategory();
    return Scaffold(
        appBar: CustomAppBar(
          titleofpage: 'Category',
          isBackRequired: false,
          iseditRequired: false,
        ),
        body: SafeArea(
            child: Column(children: [
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
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              final data = newList[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return UserCategoryWiseView(
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
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        data.categorytype,
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemCount: newList.length);
                  }))
        ])));
  }
}
