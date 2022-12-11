# flake8: NOQA

import os


print('Loading custom config...')
init_file = os.path.expanduser('~/init/ipython_init.py')

c.InteractiveShellApp.extensions = ['autoreload']

c.InteractiveShellApp.exec_lines = ['%autoreload 2', '%autocall 1']

c.TerminalInteractiveShell.confirm_exit = False

c.InteractiveShellApp.exec_files = [init_file]
