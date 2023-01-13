import 'package:flutter/material.dart';

void openSnackbar(context , snackMassage , color  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  backgroundColor : color ,
      action : SnackBarAction(
      label : "OK",
          textColor: Colors.white,
          onPressed: (){},
),
    content : Text(
        snackMassage,
        style: const TextStyle(fontSize:14),
    )
    ));


}