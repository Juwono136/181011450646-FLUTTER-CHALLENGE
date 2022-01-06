import 'package:github_api_app/model/users.dart';
import 'package:github_api_app/api/apiUser.dart';
import 'package:github_api_app/components/list.dart';
import 'package:github_api_app/components/search.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int page = 1;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  List<Users> listUser = [];
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refreshKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiUser.getUsers(1).then((value) => {
      setState(() {
        listUser = value;
      })
    });
  }

  void _onRefresh() async {
    print('refresh');
    await Future.delayed(Duration(seconds: 2));
    var list = await ApiUser.getUsers(1);
    page = 1;
    listUser.clear();
    listUser.addAll(list);
    setState(() {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    await Future.delayed(Duration(seconds: 2));
    page++;
    print("page = " + page.toString());
    var list = await ApiUser.getUsers(page);
    listUser.addAll(list);
    print("sudah");
    _refreshController.loadComplete();
    setState(() {});
    print("sudah 2");
  }

  Widget buildCtn() {
    return ListView.separated(
        key: _contentKey,
        itemBuilder: (context, index) {
          return MyList(
              avatar: listUser[index].avatarUrl,
              login: listUser[index].login,
              type: listUser[index].htmlUrl);
        },
        separatorBuilder: (context, index) {
          return Container();
        },
        itemCount: listUser.length);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      enableLoadingWhenFailed: true,
      context: context,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 2, 64, 1.0),
        appBar: AppBar(
          title: Text('List User Github'),
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(0, 1, 23, 1.0),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: CostumSearch());
                },
                icon: Icon(Icons.search))
          ],
        ),
        // bottomNavigationBar: ButtonBar(),
        body: SmartRefresher(
          key: _refreshKey,
          controller: _refreshController,
          enablePullUp: true,
          child: buildCtn(),
          physics: BouncingScrollPhysics(),
          footer: ClassicFooter(
            loadStyle: LoadStyle.ShowWhenLoading,
          ),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        ),
      ),
      headerBuilder: () => WaterDropMaterialHeader(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      footerTriggerDistance: 30,
    );
  }
}