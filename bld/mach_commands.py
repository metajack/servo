from __future__ import print_function, unicode_literals

from mach.decorators import (
    CommandArgument,
    CommandProvider,
    Command,
)

@CommandProvider
class MachCommands(object):
    @Command('go', description='Just do it!',
             category='servo')
    @CommandArgument('--debug', '-d', action='store_true',
                     help='Do it in debug mode')
    def go(self, debug=False):
        if debug:
            print('Going...')
        print('Gone.')

