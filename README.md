kiwi.vim
========

`kiwi.vim` is a plugin for working with the [Kiwi](http://kiwi-lib.org/)
library for behavior-driven development.  This plugin adds smart folding
and abbreviations.

Which Files Are Kiwi?
---------------------

To keep things simple, I just match anything that matches `*Spec.m`
or `*Spec.mm`.  You can add your own `autocmd` rules to if you use
a different naming convention.

Folding
-------

Folding is designed to make the Kiwi specs readable as specs at a glance,
hiding the backing code until you want to look at it.  In addition,
it still allows adding manual fold markers (e.g. {{{1 and }}}) so that
you can fold any supporting code in the file.  This means that a spec
will look like this when you first edit it:

    #import "EHNetbeansConnection.h"
    #import "EHNetbeansMessage.h"
    #import "Kiwi.h"

    +-- 58 lines: Scenario ----------------------------------

    SPEC_BEGIN(EHNetbeansConnectionSpec)

    describe(@"EHNetbeansConnection", ^{
    +-- 15 lines: describe(@"-sendMessage:", ^{--------------
    +-- 30 lines: describe(@"-readDidComplete:", ^{ ---------
    });

    SPEC_END

And can be expanded like so:

    #import "EHNetbeansConnection.h"
    #import "EHNetbeansMessage.h"
    #import "Kiwi.h"

    +-- 58 lines: Scenario -------------------------------------------------------------------------------------

    SPEC_BEGIN(EHNetbeansConnectionSpec)

    describe(@"EHNetbeansConnection", ^{
    +-- 15 lines: describe(@"-sendMessage:", ^{-----------------------------------------------------------------
        describe(@"-readDidComplete:", ^{ 
    +---  7 lines: it(@"should collect data received in a buffer", ^{ ------------------------------------------
    +--- 11 lines: it(@"should notify the delegate of any full events received", ^{ ----------------------------
            it(@"should remove all processed lines from buffer", ^{ 
                Scenario s;
                s.completeRead("AUTH foo\r\n12");
                [[s.connection.receiveBuffer should] equal:s.data("12")];
            });
    +---  5 lines: it(@"should notify the delegate of connection close when a zero-byte read is received", ^{ --
        });
    });

    SPEC_END

Abbreviations
-------------

The supported abbreviations are "It", "Describe", "Pending", and "Context".  
The leading caps are there to prevent the abbreviations from being triggered
accidently.  Typing "It" followed by a non-word character will expand to the
following:

    it(@"_", ^{
    });

(`_` is the cursor's location.)  "Describe", "Pending", and "Context" expand
in the same way.

Installation
------------

There are many ways to install, but the easiest would be to install
[pathogen.vim](https://github.com/tpope/vim-pathogen), then clone
this repository into your ~/.vim/bundle directory like so:

    cd ~/.vim/bundle
    git clone git://github.com/eraserhd/vim-kiwi.git

Self-promotion
--------------

If you are interested in more ways to use Vim and the command-line for working
on iOS and Mac projects (defeating the XcodeOSaurus so that the pheasant
coders can live in peace and productivity), please follow my blog,
[The Objective Vimmer].  Or follow [me on Twitter].  Or, if you really like my
work, a [paid subscription to The Objective Vimmer] will get you access to my
screencasts in addition to the blog posts and a great deal of gratitude.

[me on Twitter]: http://twitter.com/eraserhd/
[The Objective Vimmer]: http://vios.eraserhead.net/
[paid subscription to The Objective Vimmer]: http://vios.eraserhead.net/subscribe.html

Thank you!

