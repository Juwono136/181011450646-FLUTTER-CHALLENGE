import 'package:flutter/material.dart';
import 'package:github_api_app/model/users.dart';
import 'package:github_api_app/api/apiUser.dart';
import 'package:github_api_app/components/list.dart';

class CostumSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Users>>(
        future: ApiUser.searchUsers(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Users> list = snapshot.data!;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext contex, int index) => MyList(
                    avatar: list[index].avatarUrl,
                    login: list[index].login,
                    type: list[index].htmlUrl));
          }
        });
  }
}