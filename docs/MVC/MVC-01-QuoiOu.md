# Quoi - Où
<!-- .slide: data-state="heading" -->

![Messy](MVC/recycle.jpg){:.heading}
 

## Comment?

Le pattern **MVC** définit _quel_ code il faut mettre _où_. Avec peu d'expérience il est facile
de dériver et mettre du code au mauvais endroit.

**Ce chapitre définit quelques règles qui permettent d'éviter cette dérive.**
 

## Fat Models, Skinny Controllers

Quel est le rôle du *controlleur* ?

C'est le code qui réceptionne les actions de l'utilisateur, prépare les données
et choisi la vue à redonner à l'utilisateur.

La dérive possible ici est **prépare les données**.

<!-- .element: class="fragment" -->

En effet, cette préparation peut utiliser des algorithmes complexes, le code
concerné doit se trouver au maximum dans les modèles, le moins possible dans
le controlleur. D'où l'adage: **Fat models, Skinny controllers**<!-- .element: class="fragment" -->

<!-- .element: class="fragment" -->
 

`event.rb`

~~~ ruby
class Event < ActiveRecord::Base
  def self.between(from, to)
    # Fat code
  end
  
  def self.concerning(user)
    # Fat code
  end
end
~~~

`events_controller.rb`

~~~ ruby
class EventsController < ApplicationController
  def index
    # Skinny code here!
    from = Time.now
    @events = Event.between(from, from+1.month).concerning(current_user)
  end
end
~~~
 

## Dumb Views

Les vues doivent contenir uniquement du code *bête*, il n'y aura donc pas
d'algorithme dedans.

Néanmoins, il arrive que pour afficher des données, il faille les mâcher ce qui
n'est pas forcément le rôle du _contrôleur_ ou des _modèles_.

<!-- .element: class="fragment" -->

Dans ce cas, on utilise des **helpers**. Ce sont des composants de code qui cachent
la complexité à la vue.

<!-- .element: class="fragment" -->
 

`index.html.erb`

~~~ erb
<ul>
  <% @events.each do |event| >
    <li>
      <%= color_bullet(event)><%= event %>
    </li>
  <% end >
</ul>
~~~

`event_helpers.rb`

~~~ ruby
module EventHelper
  EVENT_CLASSES = {'booking' => 'orange', 'appointment' => 'blue', 'party' => 'red'}
  
  def color_bullet(event)
    "<span class='event-bullet #{EVENT_CLASSES[event.kind]}'></span>"
  end
end
~~~

