




class Todo{
  late String title;


  Todo({required this.title});



   Todo.init(): title='';

   Todo copyWith({String? title}){
     return Todo(title: title ?? this.title);
   }

}