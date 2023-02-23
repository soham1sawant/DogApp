import 'package:dogbreeds_api/dogbreeds_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Description extends StatelessWidget {

  const Description({super.key, required this.theBreed});

  final BreedsModel theBreed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubDescription(
          first: 'Origin : ',
          second: theBreed.origin,
          unit: '',
        ),
        SubDescription(
          first: 'Bred For : ',
          second: theBreed.bredFor,
          unit: '',
        ),
        SubDescription(
          first: 'Weight : ',
          second: theBreed.weight.metric,
          unit: ' kg',
        ),
        SubDescription(
          first: 'Height : ',
          second: theBreed.height?.metric,
          unit: ' inches',
        ),
        SubDescription(
          first: 'Life Span : ',
          second: theBreed.lifeSpan,
          unit: '',
        ),
      ],
    );
  }
}

class SubDescription extends StatelessWidget {

  const SubDescription({super.key, this.first, this.second, this.unit});
  final String? first;
  final String? second;
  final String? unit;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: Row(
        children: [
          Text(
            first!,
            style: TextStyle(
              fontSize: size.height * 0.032,
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
                  fontSize: size.height * 0.032,
                  color: Theme.of(context).primaryColor,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            )
          else
            Text(
              '-',
              style: TextStyle(
                fontSize: size.height * 0.032,
              ),
            ),
        ],
      ),
    );
  }
}
