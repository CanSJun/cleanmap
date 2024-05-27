import 'package:cleanmap/components/intro_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/parser.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.35,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Image(
                    image: AssetImage('assets/images/logo-4x.png')
                  ),
                )
              )
            ),
            IntroButton(
              '배출 장소 찾기',
              onPressed: () => Navigator.pushNamed(context, '/search')
            ),
            IntroButton(
              '배출 방법 확인',
              onPressed: () {}
            ),
            IntroButton(
              '분리 수거 챗봇',
              onPressed: () {}
            ),
            Expanded(
              child: FutureBuilder(
                future: getGitCommitHash(),
                builder: (BuildContext context,
                  AsyncSnapshot<String> snapshot) {
                  final String commitHash = (snapshot.hasData)
                    ? (snapshot.data)!.substring(0, 7)
                    : "unknown";

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Text(commitHash)
                  );
                }
              )
            )
          ]
        ),
      )
    );
  }

  Future<String> getGitCommitHash() async {
    final head = await rootBundle.loadString('.git/HEAD');

    if (head.startsWith('ref: ')) {
      final branchName = head.split('ref: refs/heads/').last.trim();

      return await rootBundle.loadString('.git/refs/heads/$branchName');
    } else {
      return head;
    }
  }
}