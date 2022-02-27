import '../../../../data/models/breeds/breeds_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {

  final BreedsModel theBreed;

  const Description({Key? key, required this.theBreed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubDescription(
          first: "Origin : ",
          second: theBreed.origin,
          unit: "",
        ),
        SubDescription(
          first: "Bred For : ",
          second: theBreed.bredFor,
          unit: "",
        ),
        SubDescription(
          first: "Weight : ",
          second: theBreed.weight.metric,
          unit: " kg",
        ),
        SubDescription(
          first: "Height : ",
          second: theBreed.height?.metric,
          unit: " inches",
        ),
        SubDescription(
          first: "Life Span : ",
          second: theBreed.lifeSpan,
          unit: "",
        ),
      ],
    );
  }
}

class SubDescription extends StatelessWidget {
  final String? first;
  final String? second;
  final String? unit;

  const SubDescription({Key? key, this.first, this.second, this.unit}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: Row(
        children: [
          Text(
            first!,
            style: TextStyle(
              fontSize: orientation == Orientation.portrait
                  ? size.height * 0.032
                  : size.height * 0.05,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          if (second != null)
            Expanded(
              child: Text(
                second! + unit!,
                style: TextStyle(
                  fontSize: orientation == Orientation.portrait
                      ? size.height * 0.032
                      : size.height * 0.05,
                  color: Theme.of(context).primaryColor,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            )
          else
            Text(
              "-",
              style: TextStyle(
                fontSize: orientation == Orientation.portrait
                    ? size.height * 0.032
                    : size.height * 0.05,
              ),
            ),
        ],
      ),
    );
  }
}
