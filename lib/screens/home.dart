
import "package:flutter/material.dart";
import "package:to_do/constants/colors.dart";

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar() ,
      body: Container(
        padding:  EdgeInsets.symmetric(
            horizontal: 20,
          vertical: 15,

        ),
        child: Column(
          children: [
            searchBox(),
          ],
        )
      ),
    );
  }

  Widget searchBox(){
    return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(
                  Icons.search,
                  color: tdBlack,
                  size: 20,
                ),
                prefixIconConstraints: BoxConstraints(
                    maxHeight: 20, maxWidth: 20
                ),
                border: InputBorder.none,
                hintText: 'search',
                hintStyle: TextStyle(
                    color: tdGrey
                )
            ),
          )
      );
  }

  AppBar _buildAppBar(){
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 30,
            width: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/profile-pic (16).png"),
            ),
          )
        ],
      ),
    );
  }
}
