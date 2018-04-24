# Callbacks & Observers
<!-- .slide: data-state="heading" -->

![](ActiveRecord/observers.jpg){:.heading}
 

## Callbacks, callwhat?

Afin d'assurer l'état des objets ActiveRecord,
il est possible de *s'accrocher* (hook) à plusieurs moments du
cycle de vie d'un objet.

Ceci est fait en déclarant des **callbacks**

~~~ ruby
class Teacher < ActiveRecord::Base
  before_validation :set_acronym
  
  protected
  
  def set_acroynm
    self.acronym = "#{firstname.first}#{lastname.first}#{lastname.last}".upcase \
      unless acronym
  end
end
~~~
 

## Callbacks à la modification

Les callbacks sont executés dans cet ordre selon les trois scénarios

    A la création:        A la mise à jour:     A la destruction:

    before_validation     before_validation     before_destroy
    after_validation      after_validation      around_destroy
    before_save           before_save           after_destroy
    around_save           around_save
    before_create         before_update
    around_create         around_update
    after_create          after_update
    after_save            after_save
 

## Callbacks à la lecture

Il existe également les callbacks

`after_initialize` et `after_find`

qui permettent l'execution de code lors de la création d'un objet et
lors du rapatriement d'un objet depuis la BD.

Référez vous au [guide](http://guides.rubyonrails.org/active_record_callbacks.html#after-initialize-and-after-find) pour les détails
 

## Observers

 - Similaire au *callbacks*
 - Lorsque le code du callback n'est pas  
   directement lié au modèle
 - Le code du modèle **n'est pas touché**!

Exemple: envoyer un mail de notification lorsqu'un nouveau commentaire est posté.

Depuis la version 4.0 de ActiveRecord, ce comportement a été déporté
dans une **gem** externe: `rails-observers`
 

## Observers : exemple

~~~ ruby
require 'rails/observers/activerecord/active_record'
~~~

Définition d'un observeur

~~~ ruby
class CommentObserver < ActiveRecord::Observer
  observe :comment

  def after_create(model)
    # envoi du mail de notification
  end
end
~~~

Enregistrement de l'observer, puis instantiation
(à faire une seule fois dans l'application)

~~~ ruby
ActiveRecord::Base.observers += [:comment_observer]
ActiveRecord::Base.instantiate_observers
~~~

