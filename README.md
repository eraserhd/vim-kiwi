kiwi.vim
========

`kiwi.vim` is a plugin for working with the [Kiwi](http://kiwi-lib.org/)
library for behavior-driven development.  Right now, it simply adds
smart folding, but I have some abbreviations which I'll add once I
hammer out some kinks.

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

Installation
------------

There are many ways to install, but the easiest would be to install
[pathogen.vim](https://github.com/tpope/vim-pathogen), then clone
this repository into your ~/.vim/bundle directory like so:

    cd ~/.vim/bundle
    git clone git://github.com/eraserhd/vim-kiwi.git

