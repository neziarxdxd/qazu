import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qazu/db/account_model.dart';
import 'package:qazu/db/list_accounts.dart';
import 'package:qazu/db/models/user_model.dart';

class ListAccounts extends StatefulWidget {
  const ListAccounts({super.key});

  @override
  State<ListAccounts> createState() => _ListAccountsState();
}

class _ListAccountsState extends State<ListAccounts> {
  late Box box;
  // future list Account Settings
  late Future<List<UserModel>> list;
  late Accounts accountSettings;
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final String type = "Student";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // open mydb then get the box accounts
    box = Hive.box("accounts");

    accountSettings = Accounts();
    list = accountSettings.getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accounts"),
      ),

      /// display the data in a list view without using a future builder using list in AccountSettings
      /// and then use a future builder to display the data in a list view
      body: FutureBuilder(
        future: list,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? Center(
                    child: Container(child: const Text("Empty")),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // make it dismissible
                      return Dismissible(
                        confirmDismiss: (direction) => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Confirm"),
                            content: const Text(
                                "Are you sure you want to delete this account?"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text("Yes"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("No"),
                              ),
                            ],
                          ),
                        ),
                        background: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // white text
                              const Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          color: Colors.red,
                        ),
                        direction: DismissDirection.endToStart,
                        key: Key(snapshot.data![index].id.toString()),
                        onDismissed: (direction) {
                          // remove the item from the data source
                          accountSettings.deleteAccount(
                              snapshot.data![index].id.toString());
                          // show a snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Account deleted"),
                            ),
                          );
                        },
                        child: ListTile(
                            // edit the account
                            onTap: () {
                              // show a dialog
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Edit Account"),
                                    content: Form(
                                      key: formKey,
                                      child: Container(
                                        height: 300,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter a first name";
                                                }
                                                return null;
                                              },
                                              controller: controllerFirstName =
                                                  TextEditingController(
                                                      text: snapshot
                                                          .data![index]
                                                          .firstName),
                                              decoration: const InputDecoration(
                                                labelText: "First Name",
                                              ),
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter a last name";
                                                }
                                                return null;
                                              },
                                              controller: controllerLastName =
                                                  TextEditingController(
                                                      text: snapshot
                                                          .data![index]
                                                          .lastName),
                                              decoration: const InputDecoration(
                                                labelText: "Last Name",
                                              ),
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter an email";
                                                }
                                                return null;
                                              },
                                              controller: controllerEmail =
                                                  TextEditingController(
                                                      text: snapshot
                                                          .data![index].email),
                                              decoration: const InputDecoration(
                                                labelText: "Email",
                                              ),
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value!.length >= 8 &&
                                                    value.contains(
                                                        RegExp(r'[A-Z]')) &&
                                                    value.contains(
                                                        RegExp(r'[a-z]')) &&
                                                    value.contains(
                                                        RegExp(r'[0-9]')) &&
                                                    value.contains(RegExp(
                                                        r'[!@#$%^&*(),.?":{}|<>]'))) {
                                                  return null;
                                                } else {
                                                  return 'Password should be 8 characters and above';
                                                }
                                              },
                                              controller: controllerPassword =
                                                  TextEditingController(
                                                      text: snapshot
                                                          .data![index]
                                                          .password),
                                              decoration: const InputDecoration(
                                                labelText: "Password",
                                              ),
                                            ),
                                            // DropdownButton is used to display the list of accounts
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            // update the account
                                            if (formKey.currentState!
                                                .validate()) {
                                              accountSettings.updateAccountById(
                                                  // get the key of the account
                                                  box.keyAt(index),
                                                  UserModel(
                                                    id: 0,
                                                    firstName:
                                                        controllerFirstName
                                                            .text,
                                                    lastName:
                                                        controllerLastName.text,
                                                    email: controllerEmail.text,
                                                    password:
                                                        controllerPassword.text,
                                                    type: snapshot
                                                        .data![index].type,
                                                  ));
                                              // close the dialog
                                              Navigator.pop(context);
                                              // refresh the listq
                                              setState(() {
                                                list = accountSettings
                                                    .getAccounts();
                                              });
                                            }
                                          },
                                          child: const Text("Update")),
                                      TextButton(
                                        onPressed: () {
                                          // close the dialog
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            trailing: Column(
                              children: [
                                Icon(
                                  snapshot.data![index].type == "student"
                                      ? Icons.account_box_rounded
                                      : Icons.school_sharp,
                                ),
                                Text(snapshot.data![index].type.toString()),
                              ],
                            ),
                            title: Text(
                                "${snapshot.data![index].firstName}  ${snapshot.data![index].lastName}"),
                            // display the Key of the account
                            subtitle: Text(
                              snapshot.data![index].email.toString(),
                            )),
                      );
                    },
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
