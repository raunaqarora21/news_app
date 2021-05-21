
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_view.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
bool _loading = true;
class _HomePageState extends State<HomePage> {
  List<CategoryModel> category = [];
  List<Article> articles = [];
  @override
  void initState() {
    super.initState();
    _loading = true;
    category = getCategory();
    getNews();
  }

  getNews() async{
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter',style: TextStyle(color: Colors.black),),
            Text('News',style : TextStyle(color: Colors.blue),),
          ],

        ),
        elevation: 1.0,
        centerTitle: true,
      ) ,
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      )
      : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                height: 70.0,

                child: ListView.builder(
                  itemCount: category.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return CategoryTile(
                      imageUrl: category[index].imageUrl,
                      categoryName: category[index].categoryName,
                    );
                  },
                ),
              ),
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

class CategoryTile extends StatelessWidget {
  final imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryView(
          category: categoryName.toString().toLowerCase(),
        )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(imageUrl: imageUrl,width: 120.0,height: 60.0,fit: BoxFit.cover,)
            ),
            Container(
            alignment: Alignment.center,
            width: 120.0,
            height: 60.0,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6.0)
              ),
              child: Text(categoryName,style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
              ),
              ),
            )
          ],
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


