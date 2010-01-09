ActionController::Routing::Routes.draw do |map|

  map.connect '/jverb/', :action => 'new', :controller => 'quiz'
  map.connect '/jverb/lexicon', :action => 'list', :controller => 'lexicon'
  map.connect '/jverb/kanji', :controller => 'kanji', :action => 'new'
  map.connect '/jverb/kanji/:action', :controller => 'kanji'
  map.connect '/jverb/inflect', :action => 'list', :controller => 'inflect'
  map.connect '/jverb/:controller/:action'

  map.connect '', :controller => "quiz", :action => 'new'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'


end
