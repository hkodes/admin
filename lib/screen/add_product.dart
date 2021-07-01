import 'package:flutter/material.dart';
import 'package:kitchenappliances/screen/appdrawer.dart';
import '../provider/product.dart';
import 'package:provider/provider.dart';

class Addproduct extends StatefulWidget {
  static const route = "./addproduct";
  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  //final items = MultiSelectItem<String>("na","");
  final form = GlobalKey<FormState>();
  final imagecontroller = TextEditingController();
  final imagecontroller1 = TextEditingController();
  final imagecontroller2 = TextEditingController();
  TextEditingController colorcontroller = TextEditingController();
  TextEditingController titlecontroller;
  TextEditingController pricecontroller;
  TextEditingController descriptioncontroller;
  TextEditingController sizecontroller;
  TextEditingController subtitlecontroller;
  TextEditingController companynamecontroller;

  Map<String, String> initvalues = {
    'title': '',
    'subtitle': '',
    'price': '',
    'size': '',
    'description': '',
    'company': '',
  };
  final imagefocusnode1 = FocusNode();
  final imagefocusnode2 = FocusNode();
  final imagefocusnode3 = FocusNode();
  final titlenode = FocusNode();
  final subtitlenode = FocusNode();
  final pricenode = FocusNode();
  final companynode = FocusNode();
  final descriptionnode = FocusNode();
  final sizenode = FocusNode();

  var editedproduct = Product(
    id: null,
    title: '',
    price: 0,
    size: 0,
    subtitle: '',
    description: '',
    company: '',
    image1: '',
    image2: '',
    image3: '',
  );
  var isinit = true;
  void initState() {
    imagefocusnode1.addListener(() {
      updateimageurl();
    });
    imagefocusnode2.addListener(() {
      updateimageurl();
    });
    imagefocusnode3.addListener(() {
      updateimageurl();
    });
    super.initState();
  }

  void updateimageurl() {
    if (!imagefocusnode1.hasFocus) {
      if (imagecontroller.text.isEmpty) {
        return;
      }
      setState(() {});
    }
    if (!imagefocusnode2.hasFocus) {
      if (imagecontroller1.text.isEmpty) {
        return;
      }
      setState(() {});
    }
    if (!imagefocusnode3.hasFocus) {
      if (imagecontroller2.text.isEmpty) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    pricenode.dispose();
    titlenode.dispose();
    subtitlenode.dispose();
    companynode.dispose();
    sizenode.dispose();
    descriptionnode.dispose();
    imagefocusnode1.removeListener(() {
      updateimageurl();
    });
    imagefocusnode2.removeListener(() {
      updateimageurl();
    });
    imagefocusnode3.removeListener(() {
      updateimageurl();
    });
    super.dispose();
  }

  Widget imageinput(TextEditingController image, String text, Function save,
      FocusNode request, FocusNode focus, String message) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          // height: size.height * 0.1,
          width: size.width * 0.3,
          child: image.text.isEmpty
              ? Text("Enter the url")
              : Image.network(
                  image.text,
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          //height: size.height * 0.06,
          width: size.width * 0.65,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
          ),
          child: TextFormField(
            controller: image,
            onSaved: save,
            validator: (value) {
              if (value.isEmpty) {
                return message;
              } else {
                return null;
              }
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(request);
            },
            focusNode: focus,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
            ),
          ),
        )
      ],
    );
  }

  Widget input(TextEditingController ctl, String hint, Function save,
      FocusNode request, FocusNode focus, String message) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 10),
      height: size.height * 0.06,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: TextFormField(
        controller: ctl,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(request);
        },
        onSaved: save,
        validator: (value) {
          if (value.isEmpty) {
            return message;
          } else {
            return null;
          }
        },
        focusNode: focus,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }

  bool isloading = false;
  Future<void> saveform() async {
    final isvalid = form.currentState.validate();
    if (!isvalid) {
      return;
    }
    form.currentState.save();
    setState(() {
      isloading = true;
    });

    if (editedproduct.id == null) {
      try {
        await Provider.of<Products>(context, listen: false).add(editedproduct);
      } catch (error) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('error occured'),
                  content: Text(error),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('okay')),
                  ],
                ));
      }
    } else {
      return null;
    }
    setState(() {
      isloading = false;
    });
    Navigator.of(context).pushReplacementNamed(Addproduct.route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Add Products"),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: saveform)],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              imageinput(imagecontroller, "Enter the image URL 1",
                  (String value) {
                editedproduct = Product(
                    id: editedproduct.id,
                    description: editedproduct.description,
                    price: editedproduct.price,
                    title: editedproduct.title,
                    subtitle: editedproduct.subtitle,
                    company: editedproduct.company,
                    size: editedproduct.size,
                    image1: value,
                    image2: editedproduct.image2,
                    image3: editedproduct.image3);
              }, imagefocusnode2, imagefocusnode1, "enter the url"),
              SizedBox(
                height: 15,
              ),
              imageinput(imagecontroller1, "Enter the image URL 2",
                  (String value) {
                editedproduct = Product(
                    id: editedproduct.id,
                    description: editedproduct.description,
                    price: editedproduct.price,
                    title: editedproduct.title,
                    subtitle: editedproduct.subtitle,
                    company: editedproduct.company,
                    size: editedproduct.size,
                    image1: editedproduct.image1,
                    image2: value,
                    image3: editedproduct.image3);
              }, imagefocusnode3, imagefocusnode2, "enter the image url 2"),
              SizedBox(
                height: 15,
              ),
              imageinput(imagecontroller2, "Enter the image URL 3",
                  (String value) {
                editedproduct = Product(
                    id: editedproduct.id,
                    description: editedproduct.description,
                    price: editedproduct.price,
                    title: editedproduct.title,
                    subtitle: editedproduct.subtitle,
                    company: editedproduct.company,
                    size: editedproduct.size,
                    image1: editedproduct.image1,
                    image2: editedproduct.image2,
                    image3: value);
              }, companynode, imagefocusnode3, "enter the imageurl 3"),
              SizedBox(height: 25),
              input(companynamecontroller, "Enter the company name",
                  (String value) {
                editedproduct = Product(
                    id: editedproduct.id,
                    description: editedproduct.description,
                    price: editedproduct.price,
                    title: editedproduct.title,
                    subtitle: editedproduct.subtitle,
                    company: value,
                    size: editedproduct.size,
                    image1: editedproduct.image1,
                    image2: editedproduct.image2,
                    image3: editedproduct.image3);
              }, titlenode, companynode, "enter the company name"),
              SizedBox(height: 25),
              input(titlecontroller, "Enter the product name", (String value) {
                editedproduct = Product(
                    id: editedproduct.id,
                    description: editedproduct.description,
                    price: editedproduct.price,
                    title: value,
                    subtitle: editedproduct.subtitle,
                    company: editedproduct.company,
                    size: editedproduct.size,
                    image1: editedproduct.image1,
                    image2: editedproduct.image2,
                    image3: editedproduct.image3);
              }, subtitlenode, titlenode, "enter the product name"),
              SizedBox(height: 25),
              input(subtitlecontroller, "Enter the category", (String value) {
                editedproduct = Product(
                    id: editedproduct.id,
                    description: editedproduct.description,
                    price: editedproduct.price,
                    title: editedproduct.title,
                    subtitle: value,
                    company: editedproduct.company,
                    size: editedproduct.size,
                    image1: editedproduct.image1,
                    image2: editedproduct.image2,
                    image3: editedproduct.image3);
              }, descriptionnode, subtitlenode, "Enter the subtitle"),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: size.height * 0.25,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: TextFormField(
                  controller: descriptioncontroller,
                  maxLines: 14,
                  focusNode: descriptionnode,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(pricenode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "enter the description";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter the description",
                  ),
                  onSaved: (String value) {
                    editedproduct = Product(
                        id: editedproduct.id,
                        description: value,
                        price: editedproduct.price,
                        title: editedproduct.title,
                        subtitle: editedproduct.subtitle,
                        company: editedproduct.company,
                        size: editedproduct.size,
                        image1: editedproduct.image1,
                        image2: editedproduct.image2,
                        image3: editedproduct.image3);
                  },
                ),
              ),
              SizedBox(height: 25),
              input(pricecontroller, "Enter the price", (String value) {
                editedproduct = Product(
                    id: editedproduct.id,
                    description: editedproduct.description,
                    price: int.parse(value),
                    title: editedproduct.title,
                    subtitle: editedproduct.subtitle,
                    company: editedproduct.company,
                    size: editedproduct.size,
                    image1: editedproduct.image1,
                    image2: editedproduct.image2,
                    image3: editedproduct.image3);
              }, sizenode, pricenode, "Enter the price"),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.only(left: 10),
                height: size.height * 0.06,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: TextFormField(
                  controller: sizecontroller,
                  onFieldSubmitted: (_) {
                    sizenode.unfocus();
                  },
                  onSaved: (String value) {
                    editedproduct = Product(
                        id: editedproduct.id,
                        description: editedproduct.description,
                        price: editedproduct.price,
                        title: editedproduct.title,
                        subtitle: editedproduct.subtitle,
                        company: editedproduct.company,
                        size: int.parse(value),
                        image1: editedproduct.image1,
                        image2: editedproduct.image2,
                        image3: editedproduct.image3);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "enter the size";
                    } else {
                      return null;
                    }
                  },
                  focusNode: sizenode,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "enter the size",
                  ),
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
      drawer: Appdrawer(),
    );
  }
}
