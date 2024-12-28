import 'dart:math';

import 'package:SC3040_App/models/CollectionOfShows.dart';
import 'package:SC3040_App/models/Review.dart';
import 'package:SC3040_App/models/User.dart';
import 'package:SC3040_App/viewModels/auth_viewmodel.dart';
import 'package:SC3040_App/viewModels/collection_viewmodel.dart';
import 'package:SC3040_App/viewModels/register_viewmodel.dart';
import 'package:SC3040_App/viewModels/review_viewmodel.dart';
import 'package:SC3040_App/widgets/addreview.dart';
import 'package:SC3040_App/widgets/appbar.dart';
import 'package:SC3040_App/widgets/customtextinput.dart';
import 'package:SC3040_App/widgets/navbar.dart';
import 'package:SC3040_App/widgets/reviewcard.dart';
import 'package:SC3040_App/widgets/showlistview.dart';
import 'package:SC3040_App/widgets/tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CollectionsViewmodel>(
          create: (BuildContext context) => CollectionsViewmodel(),
        ),
        ChangeNotifierProvider<ReviewViewmodel>(
          create: (BuildContext context) => ReviewViewmodel(),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (BuildContext context) => RegisterViewModel(),
        )
      ],
      child: const Scaffold(
        appBar: CustomAppBar(
          displayProfileIcon: false,
        ),
        body: ProfilePageChild(),
      ),
    );
  }
}

class ProfilePageChild extends StatelessWidget {
  const ProfilePageChild({
    super.key,
  });

  Future<bool?> _changePassword(
    BuildContext context,
    RegisterViewModel registerViewModel,
  ) async {
    bool obscurePassword = true;
    bool obscureConfirmPassword = true;

    return showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextInput(
                    labelText: "Old Password",
                    labelTextStyle: GoogleFonts.bebasNeue(),
                    controller: registerViewModel.oldPasswordController,
                    obscureText: obscurePassword,
                  ),
                  CustomTextInput(
                    labelText: "New Password",
                    labelTextStyle: GoogleFonts.bebasNeue(),
                    controller: registerViewModel.passwordController,
                    obscureText: obscurePassword,
                  ),
                  CustomTextInput(
                    labelText: "Confirm New Password",
                    labelTextStyle: GoogleFonts.bebasNeue(),
                    controller: registerViewModel.confirmPasswordController,
                    obscureText: obscureConfirmPassword,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    registerViewModel.confirmPasswordController.clear();
                    registerViewModel.passwordController.clear();
                    Navigator.pop(context, false);
                  },
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    if (registerViewModel.passwordController.text ==
                        registerViewModel.confirmPasswordController.text) {
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Passwords do not match'),
                        ),
                      );
                      setState(() {
                        registerViewModel.confirmPasswordController.clear();
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<bool?> _deleteCollection(BuildContext context, String text) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Collection'),
          content:
              Text("Are you sure you want to delete the Collection $text?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _createCollection(
    BuildContext context,
    CollectionsViewmodel collectionsViewmodel,
    List<CollectionOfShows> shows_collections_list,
  ) async {
    collectionsViewmodel.collectionNameController.text =
        'Collection${shows_collections_list.length + 1}';
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Name your collection'),
          content: TextField(
            controller: collectionsViewmodel.collectionNameController,
            decoration: const InputDecoration(hintText: "Collection Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
            ),
            TextButton(
              child: const Text('Create Collection'),
              onPressed: () {
                final newName =
                    collectionsViewmodel.collectionNameController.text;
                if (shows_collections_list
                    .any((element) => element.name == newName)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Collection name $newName already exists'),
                    ),
                  );
                } else {
                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _renameCollection(
      BuildContext context, CollectionsViewmodel collectionsViewmodel) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Collection'),
          content: TextField(
            controller: collectionsViewmodel.collectionNameController,
            decoration: const InputDecoration(hintText: "New Collection Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
            ),
            TextButton(
              child: const Text('Rename'),
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void deleteCollection(
    BuildContext context,
    CollectionsViewmodel collectionsViewmodel,
    int index,
  ) {
    collectionsViewmodel.deleteCollection(context, index);
  }

  void renameCollection(
    BuildContext context,
    CollectionsViewmodel collectionsViewmodel,
    int index,
  ) {
    collectionsViewmodel.renameCollection(
      context,
      index,
    );
  }

  void createCollection(
    BuildContext context,
    CollectionsViewmodel collectionsViewmodel,
  ) {
    collectionsViewmodel.createCollection(context);
  }

  void changePassword(
    BuildContext context,
    RegisterViewModel registerViewModel,
  ) async {
    bool? newPassword = await _changePassword(context, registerViewModel);
    if (newPassword!) {
      bool success = await registerViewModel.updatePassword(context);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password changed successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${registerViewModel.errorMessage}'),
          ),
        );
      }
    }
  }

  void deleteAccount(String username) {
    //TODO: Add delete account functionality
  }

  Future<bool?> _editReview(
    BuildContext context,
    ReviewViewmodel reviewViewModel,
    Review existingReview,
  ) async {
    reviewViewModel.ratingController.text = existingReview.rating.toString();
    reviewViewModel.commentController.text = existingReview.comment!;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit your review'),
          content: AddReviewPage(
            show: existingReview.show,
            reviewViewModel: reviewViewModel,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
            ),
            TextButton(
              child: const Text('Edit Review'),
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _deleteReview(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Review'),
          content: const Text("Are you sure you want to delete this review?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  void editReview(
    BuildContext context,
    ReviewViewmodel reviewViewmodel,
    Review review,
    int index,
  ) async {
    bool? edit = await _editReview(context, reviewViewmodel, review);
    edit ??= false;
    if (edit) {
      bool editSuccess = await reviewViewmodel.editReview(context, index);
      if (editSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review edited successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${reviewViewmodel.errorMessage}'),
          ),
        );
      }
    }
  }

  void deleteReview(
    BuildContext context,
    ReviewViewmodel reviewViewmodel,
    int index,
  ) async {
    bool? delete = await _deleteReview(context);
    delete ??= false;
    if (delete) {
      bool deleteSuccess = await reviewViewmodel.deleteReview(context, index);
      if (deleteSuccess) {
        // show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Review deleted successfully'),
          ),
        );
      } else {
        // show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${reviewViewmodel.errorMessage}'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final collectionsViewmodel = Provider.of<CollectionsViewmodel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final reviewViewmodel = Provider.of<ReviewViewmodel>(context);
    final registerViewModel = Provider.of<RegisterViewModel>(context);
    User user = authViewModel.user!;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: NavBar(
              minExpandWidth: 800.0,
              destinations: [
                NavBarDestination(
                  name: "Profile",
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                  page: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user?.username ?? 'Loading...',
                        style: GoogleFonts.bebasNeue(fontSize: 30),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Add change password functionality
                          changePassword(context, registerViewModel);
                        },
                        child: const Text('Change Password'),
                      ),
                      const SizedBox(height: 20),
                      // delete account button
                      ElevatedButton(
                        onPressed: () {
                          //TODO: Add delete account functionality
                        },
                        child: const Text('Delete Account'),
                      ),
                    ],
                  ),
                ),
                NavBarDestination(
                  name: "My Collections",
                  icon: const Icon(
                    Icons.collections,
                    size: 30,
                  ),
                  page: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "My Collections",
                                style: GoogleFonts.bebasNeue(fontSize: 30),
                              ),
                            ),
                          ),
                          if (user?.shows_collections_list.isNotEmpty ?? false)
                            SafeArea(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () async {
                                    bool? create = await _createCollection(
                                      context,
                                      collectionsViewmodel,
                                      user.shows_collections_list,
                                    );
                                    create ??= false;
                                    if (create) {
                                      createCollection(
                                        context,
                                        collectionsViewmodel,
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                            )
                        ],
                      ),
                      Expanded(
                        child: (user.shows_collections_list.isEmpty)
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No collections available',
                                      style:
                                          GoogleFonts.bebasNeue(fontSize: 20),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        bool? create = await _createCollection(
                                          context,
                                          collectionsViewmodel,
                                          user.shows_collections_list,
                                        );
                                        create ??= false;
                                        if (create) {
                                          createCollection(
                                            context,
                                            collectionsViewmodel,
                                          );
                                        }
                                      },
                                      child:
                                          const Text('Create a new collection'),
                                    ),
                                  ],
                                ),
                              )
                            : (user.shows_collections_list.length == 1)
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  user.shows_collections_list[0]
                                                      .name,
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.bebasNeue(
                                                      fontSize: 30),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  bool? rename =
                                                      await _renameCollection(
                                                    context,
                                                    collectionsViewmodel,
                                                  );
                                                  rename ??= false;
                                                  if (rename) {
                                                    renameCollection(
                                                      context,
                                                      collectionsViewmodel,
                                                      0,
                                                    );
                                                  }
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  bool? delete =
                                                      await _deleteCollection(
                                                          context,
                                                          user
                                                              .shows_collections_list[
                                                                  0]
                                                              .name);
                                                  delete ??= false;
                                                  if (delete) {
                                                    deleteCollection(
                                                      context,
                                                      collectionsViewmodel,
                                                      0,
                                                    );
                                                  }
                                                },
                                                icon: const Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 200,
                                        child: ShowListView(
                                          shows: user.shows_collections_list[0]
                                              .showsList,
                                          showDeleteIcon: true,
                                          onDelete: (showId) async {
                                            // Implement delete show functionality
                                            bool success =
                                                await collectionsViewmodel
                                                    .deleteShowsFromCollection(
                                              context,
                                              0,
                                              showId,
                                            );
                                            if (success) {
                                              // mark the widget for rebuild
                                              user = authViewModel.user!;
                                              (context as Element)
                                                  .markNeedsBuild();
                                              // show success message
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Show deleted successfully'),
                                                ),
                                              );
                                            } else {
                                              // show error message
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Error: ${collectionsViewmodel.errorMessage}'),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : CustomTabBar(
                                    tabBarDestinations: List.generate(
                                      user.shows_collections_list.length,
                                      (index) => TabBarDestination(
                                        tabWidget: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, top: 10.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        user
                                                            .shows_collections_list[
                                                                index]
                                                            .name,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .bebasNeue(
                                                                fontSize: 30),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        bool? rename =
                                                            await _renameCollection(
                                                          context,
                                                          collectionsViewmodel,
                                                        );
                                                        rename ??= false;
                                                        if (rename) {
                                                          renameCollection(
                                                            context,
                                                            collectionsViewmodel,
                                                            index,
                                                          );
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit),
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        bool? delete =
                                                            await _deleteCollection(
                                                                context,
                                                                user
                                                                    .shows_collections_list[
                                                                        index]
                                                                    .name);
                                                        delete ??= false;
                                                        if (delete) {
                                                          deleteCollection(
                                                            context,
                                                            collectionsViewmodel,
                                                            index,
                                                          );
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 200,
                                              child: ShowListView(
                                                shows: user
                                                    .shows_collections_list[
                                                        index]
                                                    .showsList,
                                                showDeleteIcon: true,
                                                onDelete: (showId) async {
                                                  // Implement delete show functionality
                                                  bool success =
                                                      await collectionsViewmodel
                                                          .deleteShowsFromCollection(
                                                    context,
                                                    index,
                                                    showId,
                                                  );
                                                  if (success) {
                                                    // mark the widget for rebuild
                                                    user = authViewModel.user!;
                                                    (context as Element)
                                                        .markNeedsBuild();
                                                    // show success message
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Show deleted successfully'),
                                                      ),
                                                    );
                                                  } else {
                                                    // show error message
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Error: ${collectionsViewmodel.errorMessage}'),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        icon: null,
                                        tabName: user
                                            .shows_collections_list[index].name,
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
                NavBarDestination(
                  name: "My Reviews",
                  icon: const Icon(
                    Icons.reviews,
                    size: 30,
                  ),
                  page: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "My Reviews",
                                style: GoogleFonts.bebasNeue(fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: (user.reviews_list.isEmpty)
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No reviews available',
                                      style:
                                          GoogleFonts.bebasNeue(fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3,
                                ),
                                itemCount: user.reviews_list.length,
                                itemBuilder: (context, index) {
                                  final review = user.reviews_list[index];
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: ReviewCard(
                                          review: review,
                                          displayShow: true,
                                          show: review.show,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          // Implement edit review functionality
                                          editReview(
                                            context,
                                            reviewViewmodel,
                                            review,
                                            index,
                                          );
                                          // mark the widget for rebuild
                                          user = authViewModel.user!;
                                          (context as Element).markNeedsBuild();
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          // Implement delete review functionality
                                          deleteReview(
                                            context,
                                            reviewViewmodel,
                                            index,
                                          );
                                          // mark the widget for rebuild
                                          user = authViewModel.user!;
                                          (context as Element).markNeedsBuild();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
