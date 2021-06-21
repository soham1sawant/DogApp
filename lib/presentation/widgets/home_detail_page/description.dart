import '../../../data/models/breeds.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  const Description({Key key, this.theBreed}) : super(key: key);

  final BreedsModel theBreed;

  Widget descriptions(
      BuildContext context, String first, String second, String unit) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text(
            first,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          if (second != null)
            Expanded(
              child: Text(
                second + unit,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).accentColor,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            )
          else
            Text("-"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          descriptions(context, "Origin : ", theBreed.origin, ""),
          descriptions(context, "Bred For : ", theBreed.bredFor, ""),
          descriptions(context, "Weight : ", theBreed.weight.metric, " kg"),
          descriptions(context, "Height : ", theBreed.height.metric, " inches"),
          descriptions(context, "Life Span : ", theBreed.lifeSpan, ""),
        ],
      ),
    );
  }
}
