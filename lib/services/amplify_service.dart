import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:kitubs/models/ModelProvider.dart';

class AmplifyService{

  Future<void> saveTenant(TenantModel tenant) async {

    try {

      await Amplify.DataStore.save(tenant);

    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }
  Future<void> savePayment(PaymentModel payment) async {

    try {
      await Amplify.DataStore.save(payment);

    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }
  Future<void> updateAmount(TenantModel tenant,balance) async {

    final updatedAmount = tenant.copyWith(balance: balance);
    try {

      // to update data in DataStore, you again pass an instance of a model to
      // Amplify.DataStore.save()
      await Amplify.DataStore.save(updatedAmount);
    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }
  Future<void> deleteTenantWithId(id) async {
    final oldPosts = await Amplify.DataStore.query(
      TenantModel.classType,
      where: TenantModel.ID.eq('$id'),
    );
    // Query can return more than one posts with a different predicate
    // For this example, it is ensured that it will return one post
    final oldPost = oldPosts.first;
    try {
      await Amplify.DataStore.delete(oldPost);
      print('Deleted a post');
    } on DataStoreException catch (e) {
      print('Delete failed: $e');
    }
  }
  Future<String> uploadImage(pickedFilePath,tenant) async {


    // Upload image with the current time as the key
    final key = DateTime.now().toString();
    final file = File(pickedFilePath);
    String results ='';
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: file,
        key: key +'.jpg' ,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      results = result.key;
      safePrint('Successfully uploaded image: ${result.key}');
      await updateUser(tenant,results);
    } on StorageException catch (e) {
      safePrint('Error uploading image: $e');
    }
    return results;
  }

  Future<void> updateUser(TenantModel tenant,key) async {
    final updatedUser = tenant.copyWith(key: key);
    try {

      // to update data in DataStore, you again pass an instance of a model to
      // Amplify.DataStore.save()
      await Amplify.DataStore.save(updatedUser);
    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }

  Future<void> updateName(TenantModel tenant,value) async {

    final updatedTenant = tenant.copyWith(name: value);
    try {

      // to update data in DataStore, you again pass an instance of a model to
      // Amplify.DataStore.save()
      await Amplify.DataStore.save(updatedTenant);
    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }
  Future<void> updateCell(TenantModel tenant,value) async {

    final updatedTenant = tenant.copyWith(cell: value);
    try {

      // to update data in DataStore, you again pass an instance of a model to
      // Amplify.DataStore.save()
      await Amplify.DataStore.save(updatedTenant);
    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }
  Future<void> updateAmountPerMonth(TenantModel tenant,value) async {

    final updatedTenant = tenant.copyWith(amount: value);
    try {

      // to update data in DataStore, you again pass an instance of a model to
      // Amplify.DataStore.save()
      await Amplify.DataStore.save(updatedTenant);
    } catch (e) {
      safePrint('An error occurred while saving Todo: $e');
    }
  }
}