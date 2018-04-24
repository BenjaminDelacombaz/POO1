# Structures avancées
<!-- .slide: data-state="heading" -->

![](ActiveRecord/advanced.jpg){:.heading}
 

## Héritage en BD ? ##

![](ActiveRecord/user_hierarchy.png){:.uml}
<!-- http://yuml.me/diagram/scruffy/class/[User|name]^-[Employee|site_id{bg:plum}],[Employee]^-[Teacher|acronym{bg:plum}],[User]^-[Student|current_class_id{bg:lightblue}] -->

~~~ ruby
class User < ActiveRecord::Base
end

class Student < User
  belongs_to :current_class
end
~~~
{:.put-left}

~~~ ruby
class Employee < User
  belongs_to :site
end

class Teacher < Employee
end
~~~
{:.put-right}


Comment implémenter ceci dans la base de donnée?
 

## STI: Single Table Inheritance ##

| id | type     | name     | current_class_id | site_id  | acronym |
|---:|----------|----------|-----------------:|---------:|---------|
|  1 | Employee | Joe      | __NULL__         |       42 | __NULL__
|  2 | Employee | Bob      | __NULL__         |       34 | __NULL__
|  3 | Teacher  | Suzanne  | __NULL__         |       34 | SE
|  4 | Teacher  | Jack     | __NULL__         |       12 | JK
|  5 | Teacher  | Nancy    | __NULL__         |       34 | NY
|  6 | Student  | Nina     |              123 | __NULL__ | __NULL__
|  7 | Student  | Joe      |              101 | __NULL__ | __NULL__
 

## STI: Intégré à `AR` ##

~~~ irb
>> Student.create(name: 'Alan', current_class: CurrentClass.first)
=> #<Student id: 8, name: "Alan", current_class_id: 101, site_id: nil, acronym: nil>
~~~

~~~ sql
INSERT INTO `users`
SET `type`, `name`, `current_class_id`, `site_id`, `acronym`
VALUES ('Student', 'Alan', 101, NULL, NULL)
~~~
<!-- .element: class="fragment" -->

~~~ irb
>> Employee.all
=> [#<Employee id: 1, name: "Joe", ...>,
    #<Employee id: 2, name: "Bob", ...>,
    #<Teacher id: 3, name: "Suzanne", ...>, ...]
~~~
<!-- .element: class="fragment" -->

~~~ sql
SELECT `users`.* FROM `users` WHERE `type` IN ('Employee', 'Teacher')
~~~
<!-- .element: class="fragment" -->
 

## Associations polymorphiques ##

Permet d'associer des éléments de types différents  
sur une seule association.

Exemple:

- Ajouter une _photo_ à un utilisateur
- Ajouter une _photo_ à un produit
 

## Assoc. polymorphiques ##

![](ActiveRecord/assoc_polymorphic.png){:.uml}
<!-- http://yuml.me/diagram/scruffy;scale:120/class/[users|id;firstname;lastname{bg:orange}]-[pictures|id;filename;mime_type;subject_id;subject_type{bg:green}],[products|id;name;category_id{bg:orange}]-[pictures|id;filename;mime_type;subject_id;subject_type{bg:green}].svg -->

~~~ ruby
class Picture < ActiveRecord::Base
  belongs_to :subject, polymorphic: true
end

class User < ActiveRecord::Base
  has_many :pictures, as: :subject
end
 
class Product < ActiveRecord::Base
  has_many :pictures, as: :subject
end
~~~

