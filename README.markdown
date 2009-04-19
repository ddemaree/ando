# Ando is a blogging engine. There are many blogging engines, but this one is mine. #

It's not the first attempt, and it's not done. It may never be done. But I'm okay with that.

**Note for people who forked or followed the previous versions of Ando:** I've archived the previous `ando` and `ando_plus_plus` repos as detached branches of this new repo. This newest version (which, if you must, you can call 'Ando Sharp' or 'Ando Prime') combines the best ideas and code from the previous two into a new, cleaner Rails 2.3 codebase with Shoulda/Factory Girl tests.

## Eventually, the plan is… ##

* Ando will support tumblelogging, like Tumblr, but for grown-ups. Already there are `Article` and `Link` models. `Photo`, `Audio` and `Code` models are on the horizon.

* The idea is, all media types are paired with a `Post` model, to which publishing attributes like author, published\_at, etc. are delegated.

* The JavaScript code isn't being managed by Sprockets yet. But it will be. Soon.

* I don't consider tests an accurate reference to how a thing works. You really should read the code.

* You can run the `ando:bootstrap` Rake task to set up the DB and an initial user. Of course, that user would be set up with _my_ email and password, so you may want to change that maybe?