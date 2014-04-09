dotvim
======
@DATE: 2014-04-08

- - -
Desciption:
-----------

A place holds ruby-'s configuration of vim (macvim)

How to use
----------

1. Installation (Mac OS Mavericks)

    $ git clone https://github.com/ruby-/dotvim.git ~/.vim 

    $ ln -s ~/.vim/_vimrc ~/.vimrc 

2. Use `Vundle` install plugins

    $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

    $ vim +PluginInstall +qall 

3. Manage plugins

Launch `vim` and: 

* Update plugins:`:BundleUpdate`

* Remove un-used plugins: `:BundleClean`

* List all plugins: `:BundleList`

* Search a plugin: `:BundleSearch`

- - -
END
---
