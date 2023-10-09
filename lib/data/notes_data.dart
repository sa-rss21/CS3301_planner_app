class Notes {
  int id;
  String title;
  String content;
  Notes({required this.id, required this.title, required this.content});
}

get title => title;
List<Notes> notes = [
  Notes(id: 0, title: "Daily Tasks", content: "Do what I want when I want to!"),
  Notes(
      id: 1,
      title: "Random saying for the day",
      content: "You slay either way, slay all day"),
];
