from __future__ import print_function, unicode_literals

from mach.decorators import (
    CommandArgument,
    CommandProvider,
    Command,
)

@CommandProvider
class MachCommands(object):
    @Command('doit', 
             description='Run it!',
             category='misc')
    @CommandArgument('--debug', '-d',
                     action='store_true',
                     help='Do it in debug mode.')
    def doit(self, debug=False):
        print('I did it!')
