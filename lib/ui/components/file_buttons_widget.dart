import 'package:flutter/material.dart';

import 'package:openlib/ui/components/delete_dialog_widget.dart';
// import 'package:openlib/ui/epub_viewer.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'package:openlib/ui/pdf_viewer.dart';
import 'package:openlib/services/files.dart';

class FileOpenAndDeleteButtons extends StatelessWidget {
  final String id;
  final String format;
  final Function onDelete;

  const FileOpenAndDeleteButtons(
      {Key? key,
      required this.id,
      required this.format,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21, bottom: 21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                )),
            onPressed: () async {
              if (format == 'pdf') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return PdfView(
                    fileName: '$id.$format',
                  );
                }));
              } else {
                String path = await getFilePath('$id.$format');
                VocsyEpub.setConfig(
                  themeColor: Theme.of(context).colorScheme.secondary,
                  identifier: "iosBook",
                  scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                  allowSharing: true,
                  enableTts: true,
                  // nightMode: true,
                );
                VocsyEpub.open(path);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (BuildContext context) {
                //   return EpubViewerWidget(
                //     fileName: '$id.$format',
                //   );
                // }))
              }
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(17, 8, 17, 8),
              child: Text('Open'),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(
                      width: 3, color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return ShowDeleteDialog(
                      id: id,
                      format: format,
                      onDelete: onDelete,
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.all(5.3),
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
