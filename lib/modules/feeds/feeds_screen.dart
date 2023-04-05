import 'package:flutter/material.dart';
import 'package:social_app/styles/iconbroken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: const <Widget>[
                Image(
                  image: NetworkImage(
                    'https://img.freepik.com/premium-photo/group-people-jumping-mountain-sunset-friends-party-happy-time_33755-6224.jpg?size=626&ext=jpg&ga=GA1.1.825316313.1674289475&semt=sph',
                  ),
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Text(
                    "Communicate With Friends",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => buildPostItem(context),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: 10,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget buildPostItem(BuildContext context) => Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-photo/young-arab-man-isolated-blue-background-keeping-arms-crossed-frontal-position_1368-266175.jpg?size=626&ext=jpg&ga=GA1.1.825316313.1674289475&semt=sph'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            Text(
                              "Ahmed Ghaly",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          "May 1, 2023 at 06:02 pm",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    height: 1.5,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 23,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.5,
                  color: Colors.grey[300],
                ),
              ),
              const Text(
                "Duis eiusmod ad exercitation commodo laborum qui nisi. Sint quis esse nulla eu tempor. Voluptate veniam elit ut exercitation deserunt ut mollit labore labore voluptate consequat elit in. Et qui amet exercitation cupidatat est in enim nulla nisi. Ad officia minim ullamco dolore occaecat esse laboris dolor reprehenderit nulla. Deserunt voluptate occaecat magna consectetur culpa nostrud amet quis ipsum commodo ex excepteur enim aliquip. Elit pariatur ullamco aliqua sit dolore voluptate commodo eiusmod velit consequat laboris consectetur.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 5,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: 5,
                        ),
                        child: SizedBox(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: const Text(
                              "#software",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5),
                        child: SizedBox(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            child: const Text(
                              "#flutter",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/happy-stylish-man-casual-clothes-standing-cliff-mountain_158538-13995.jpg?size=626&ext=jpg&ga=GA1.1.825316313.1674289475&semt=sph',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              IconBroken.heart,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "1200 Like",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Icon(
                              IconBroken.chat,
                              size: 20,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "200 Comment",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 5,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.5,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-photo/positive-hipster-asian-girl-playing-ukulele-making-faces-singing-feeling-happy_1258-133315.jpg?w=360&t=st=1680720777~exp=1680721377~hmac=c7f08b8856548f56575c0be0369c6fe9c451ebfa4878aa2c35ad015ab15e97d4'),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Write a comment...",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                    ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          IconBroken.heart,
                          size: 18,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
