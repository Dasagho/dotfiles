local lint = require 'lint'

lint.linters.eslint = {
  cmd = 'eslint_d',
  stdin = true,
  args = {
    '--stdin-filename',
    '%filepath',
    '--config',
    './.eslintrc.json',
    '--format',
    'compact', -- or omit and let eslint default to compact
  },
  stream = 'stdout',
  parser = require('lint.parser').from_errorformat {
    errorformat = {
      '%f:%l:%c: %trror %m', -- error
      '%f:%l:%c: %tarning %m', -- warning
    },
  },
}
