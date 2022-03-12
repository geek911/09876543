import 'package:flutter/material.dart';

enum HomeFragmentType { HOME, DONATIONS, RECEIVED, PROFILE }

abstract class HomeFragments {
  static Widget atIndex([HomeFragmentType type = HomeFragmentType.HOME]) {
    Widget fragment;
    switch (type) {
      case HomeFragmentType.HOME:
        fragment = _homeFragment();
        break;
      case HomeFragmentType.DONATIONS:
        fragment = _donations();
        break;
      case HomeFragmentType.RECEIVED:
        fragment = _received();
        break;

      case HomeFragmentType.PROFILE:
        fragment = _profile();
        break;
      default:
        fragment = _homeFragment();
        break;
    }

    return fragment;
  }

  static Widget _homeFragment() {
    return const Center(
      child: Text("Home Page"),
    );
  }

  static Widget _donations() {
    return const Center(
      child: Text("Donations Page"),
    );
  }

  static Widget _received() {
    return const Center(
      child: Text("Received Page"),
    );
  }

  static Widget _profile() {
    return const Center(
      child: Text("Profile Page"),
    );
  }
}
