# Validations
<!-- .slide: data-state="heading" -->

![](ActiveRecord/validations.jpg){:.heading}
 

## Pourquoi? ##

S’assurer de la cohérence des données dans la BD

~~~ ruby
class Car < ActiveRecord::Base
  validates :color, presence: true
end
~~~

~~~ irb
>> titine = Car.new
=> #<Car id: nil, color: nil>
>> titine.save
=> false
>> titine.errors.full_messages
=> ["Color can't be blank"]
~~~ 
 

## En standard ##

~~~ ruby
# Le champs doit être VRAI
acceptance: true

acceptance: {
  # Spécifie le terme considéré comme VRAI
  accept: __string__
}
~~~

~~~ ruby
# Le contenu du champs doit être le même que le
# champs: nom_du_champs_confirmation
confirmation: true
~~~

~~~ ruby
# Le champs doit être rempli
presence: true
~~~
 

## En standard ##

~~~ ruby
# Le champs doit respecter un format défini par une Regexp
format: { with: __regexp__ }
~~~

~~~ ruby
# Le contenu du champs doit être exclu d'un ensemble
exclusion: {
  # Spécifié le contenu refusé
  in: __array__
  # ou `within`
}
~~~

~~~ ruby
# Le contenu du champs doit faire partie d'un ensemble
inclusion: {
  # Spécifié le contenu accepté
  in: __array__
  # ou `within`
}
~~~
 

## En standard ##

~~~ ruby
# Le champs doit être d'une certaine longueur (texte)
length: {
  # La longueur doit être au minimum de la valeur spécifiée
  minimum: value
  # La longueur doit être au maximum de la valeur spécifiée
  maximum: value
  # La longueur doit être comprise dans l'intervalle spécifié
  in: __range__ # ou `within`
  # La longueur doit être la valeur spécifiée
  is: value
}
~~~

~~~ ruby
# Le champs doit être unique dans la BD
uniqueness: true

uniqueness: { 
  # Permet de tester l'unicité restreinte par rapport à un champs
  scope: 'parent_id'
}
~~~
 

## En standard ##

~~~ ruby
# Le champs doit être numérique
numericality: true

numericality: {
  # Contrôle que le champs soit un entier
  only_integer: true
  # Contrôle que le champs soit plus grand que la valeur spécifiée
  greater_than: value
  # Contrôle que le champs soit plus grand ou égale à la valeur spécifiée
  greater_than_or_equal_to: value 
  # Contrôle que le champs soit égal à la valeur spécifiée
  equal_to: value
  # Contrôle que le champs soit plus petit que la valeur spécifiée
  less_than: value
  # Contrôle que le champs soit plus petit ou égal à la valeur spécifiée
  less_than_or_equal_to: value
  # Contrôle que le champs soit impair
  odd: true
  # Contrôle que le champs soit pair
  even: true
}
~~~
 

## Exemple ##

~~~ ruby
class Car < ActiveRecord::Base
  validates :color,
    presence: true,
    length: { minimum: 3, maximum: 31 }

  validates :price,
    numericality: {
      greater_than: 2000,
      less_than: 1000000, 
      even: true
    }

  validates :name, uniqueness: true
end
~~~
 

## Options supplémentaires ##

Permettre les champs non renseigné

~~~ ruby
class Car < ActiveRecord::Base
  validates :color, length: {:minimum => 3}, allow_blank: true
  validates :price, numericality: true, allow_nil: true
end
~~~

Choisir le moment de la validation, par défaut: `save`

~~~ ruby
class Car < ActiveRecord::Base
  validates :color, length: {minimum: 3}, on: :create
  validates :price, numericality: true, on: :update
end
~~~
 

## Validations conditionnelles ##

Chaque validation peut être executée ou non selon l'état de l'object

~~~ ruby
class Wheel < ActiveRecord::Base
  validates :size, numericality: true, if: :mounting?
  
  protected
  
  def mounting?
    # return true or false
  end
end
~~~

~~~ ruby
class Car < ActiveRecord::Base
  validates :color, length: {minimum: 3},
    unless: ->(car) { car.engine.nil? }
end
~~~
 

## Associations ##

~~~ ruby
class Car < ActiveRecord::Base
  validates_associated :wheels
end
~~~

Attention, en consultant `#errors` on aura simplement un `invalid`
sur le champs `wheels`, pour avoir le détail il faudra consulter
les objets de la relations. 
 

## Personnalisées ##

Il y a plusieurs possibilités pour ajouter des validations
personnalisées, voici la façon *direct* (sans réutilisation)

~~~ ruby
class Car < ActiveRecord::Base
  validate :quality_test, on: :create
  
  protected
  
  def quality_test
    if something_gone_wrong
      errors.add(:base, "Bad quality!")
    end
  end
end
~~~
 

## Externes ##

