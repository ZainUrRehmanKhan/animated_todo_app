import 'package:flutter/cupertino.dart';
import 'package:todo_app/src/models/database_utils.dart';

const facebook = 'assets/icons/facebook.png';
const google = 'assets/icons/google.png';
const twitter = 'assets/icons/twitter.png';
const bg_image = 'assets/bg-image.webp';
const bg_image_jpg = 'assets/bg-image.jpg';

const Map<TaskType, Icon> icons  = {
  TaskType.Personal: Icon(
    CupertinoIcons.person_fill,
    size: 18,
    color: CupertinoColors.white,
  ),
  TaskType.Work: Icon(
    CupertinoIcons.briefcase_fill,
    size: 18,
    color: CupertinoColors.white,
  ),
  TaskType.General: Icon(
    CupertinoIcons.gear_alt_fill,
    size: 18,
    color: CupertinoColors.white,
  ),
};

