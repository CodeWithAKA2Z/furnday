import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furnday/models/user/user_address_model.dart';
import 'package:furnday/widgets/user_profile/address_card.dart';

class UserServices {
  final _firestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  getBillingAddressModel() async {
    try {
      var doc = await _firestore.collection("users").doc(userUid).get();
      UserAddressModel billingAddress =
          UserAddressModel.fromJson(doc.data()!['billingAddress']);
      return billingAddress;
    } catch (e) {
      print(e);
    }
  }

  getShippingAddressModel() async {
    try {
      var doc = await _firestore.collection("users").doc(userUid).get();
      UserAddressModel shippingAddress =
          UserAddressModel.fromJson(doc.data()!['shippingAddress']);
      return shippingAddress;
    } catch (e) {
      print(e);
    }
  }

  setBillingAddress({required UserAddressModel userAddress}) async {
    var doc = _firestore.collection('users').doc(userUid);
    try {
      await doc.update({"billingAddress": userAddress.toJson()});
    } catch (e) {
      await doc.set({"billingAddress": userAddress.toJson()});
    }
  }

  setShippingAddress({required UserAddressModel userAddress}) async {
    var doc = _firestore.collection('users').doc(userUid);
    try {
      await doc.update({"shippingAddress": userAddress.toJson()});
    } catch (e) {
      await doc.set({"shippingAddress": userAddress.toJson()});
    }
  }

  Widget getBillingAddressCard() {
    final billingAddressStream =
        _firestore.collection("users").doc(userUid).snapshots();

    return StreamBuilder(
      stream: billingAddressStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        } else if (snapshot.hasData) {
          try {
            Map<String, dynamic> data =
                snapshot.data!.data()!['billingAddress'];

            if (data.isNotEmpty) {
              var userAddress = UserAddressModel.fromJson(
                  snapshot.data!.data()!['billingAddress']);

              return AddressCard(
                userAddress: userAddress,
              );
            } else {
              return AddressCard(
                userAddress: UserAddressModel(),
                isAddressNull: true,
              );
            }
          } catch (e) {
            return AddressCard(
              userAddress: UserAddressModel(),
              isAddressNull: true,
            );
          }
        } else {
          return const Text("Something went wrong");
        }
      },
    );
  }

  Widget getShippingAddress() {
    final shippingAddressStream =
        _firestore.collection('users').doc(userUid).snapshots();

    return StreamBuilder(
      stream: shippingAddressStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        } else if (snapshot.hasData) {
          try {
            Map<String, dynamic> data =
                snapshot.data!.data()!['shippingAddress'];

            if (data.isNotEmpty) {
              var userAddress = UserAddressModel.fromJson(
                  snapshot.data!.data()!['shippingAddress']);

              return AddressCard(
                userAddress: userAddress,
                isShipping: true,
              );
            } else {
              return AddressCard(
                userAddress: UserAddressModel(),
                isAddressNull: true,
                isShipping: true,
              );
            }
          } catch (e) {
            return AddressCard(
              userAddress: UserAddressModel(),
              isAddressNull: true,
              isShipping: true,
            );
          }
        } else {
          return const Text("Something went wrong");
        }
      },
    );
  }
}
