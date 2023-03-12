import 'package:hive/hive.dart';
import 'package:qazu/db/models/user_model.dart';
import 'account_model.dart';

class Accounts {
  // create CRUD operations
  // create Account with ID, First Name, Last Name, Email, Password, Type
  Future<void> createAccount(UserModel userModel) async {
    final box = await Hive.openBox('accounts');

    // create a new account
    UserModel account = UserModel(
        id: userModel.id,
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        email: userModel.email,
        password: userModel.password,
        type: userModel.type);
    // add the account to the box
    await box.add(account);
  }

  // get all accounts
  Future<List<UserModel>> getAccounts() async {
    final box = await Hive.openBox('accounts');
    // let all the accounts be a list of AccountModel objects
    List<UserModel> accounts = [];
    // loop through the box and add each account to the list
    for (int i = 0; i < box.length; i++) {
      accounts.add(box.getAt(i)!);
    }
    // print all accounts
    for (int i = 0; i < accounts.length; i++) {
      print("Account ${i + 1}: ${accounts[i]}");
    }

    // print keys
    for (int i = 0; i < box.length; i++) {
      print(" ${box.keyAt(i)}");
    }

    return accounts;
  }

  // delete account by id
  Future<void> deleteAccount(String id) async {
    final box = await Hive.openBox('accounts');
    await box.deleteAt(int.parse(id));
  }

  // get account by ID
  Future<AccountModel> getAccountById(int id) async {
    final box = await Hive.openBox<AccountModel>('accounts');
    return box.get(id)!;
  }

  // update account by ID
  Future<void> updateAccountById(int key, UserModel userModel) async {
    final box = await Hive.openBox('accounts');
    UserModel account = UserModel(
        id: userModel.id,
        firstName: userModel.firstName,
        lastName: userModel.lastName,
        email: userModel.email,
        password: userModel.password,
        type: userModel.type);
    // update UserModel based on ID
    print("Key: $key");

    await box.put(key, account);
    print("UPDATED Account: ${account.toString()} with key");
  }

  // delete account by ID
  static Future<void> deleteAccountById(int id) async {
    final box = await Hive.openBox<AccountModel>('accounts');
    await box.delete(id);
  }

  bool isEmailAccountExist(String email) {
    final box = Hive.box('accounts');
    bool isExist = false;
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.email == email) {
        isExist = true;
        break;
      }
    }
    return isExist;
  }
}
