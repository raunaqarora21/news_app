import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';

import 'article_view.dart';
class CategoryView extends StatefulWidget {
  final String category;
  CategoryView({this.category});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  List<Article> articles = [];
  bool _loading = true;
  getCategoryNews() async{
    CategoryNewsClass news = CategoryNewsClass();
    await news.getNews(widget.category);
    articles = news.news;
    setState(() {
      _loading = false;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter',style: TextStyle(color: Colors.black),),
            Text('News',style : TextStyle(color: Colors.blue),),
          ],

        ),
        actions: [
          Opacity(opacity: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.save),

            ),),

        ],
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
      ) ,
      body:  _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return BlogTile(
                      title: articles[index].title,

                      imageUrl: articles[index].urlToImage,
                      desc: articles[index].description,
                      url : articles[index].articleUrl,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc ,url;
  BlogTile({this.imageUrl,this.title,this.desc,this.url});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(imageUrl: url,)));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.network(imageUrl)),
            SizedBox(height: 8.0,),
            Text(title,style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),),
            SizedBox(height: 8.0,),
            Text(desc,
              style: TextStyle(
                  color: Colors.black54
              ),),
          ],
        ),
      ),
    );
  }
}
