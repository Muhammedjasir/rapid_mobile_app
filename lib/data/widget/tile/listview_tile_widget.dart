import 'package:flutter/material.dart';
import 'package:rapid_mobile_app/data/model/projects_list_model/project_list_response.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({Key? key, required this.response, this.onTap})
      : super(key: key);

  final ProjectListResponse response;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Card(
        child: ListTile(
          onTap: onTap,
          title: Text(
            response.projectName,
          ),
          subtitle: Text(
            response.projectUrl,
          ),
        ),
      ),
    );
  }
}
