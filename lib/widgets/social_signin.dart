import 'package:flutter/material.dart';

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Continue with',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        TextButton(onPressed: (){}, child: const Text('Google',style: TextStyle(fontWeight: FontWeight.bold),)),
                        Container(height: 40,width: 1,decoration: const BoxDecoration(color: Colors.white),),
                        TextButton(onPressed: (){}, child: const Text('Facebook',style: TextStyle(fontWeight: FontWeight.bold),))
                      ],
                    ),
                  );
  }
}