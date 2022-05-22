require('orgmode').setup_ts_grammar()
require('orgmode').setup({
  org_agenda_files = {'~/notes/org/*', '~/notes/**/*'},
  org_default_notes_file = '~/notes/refile.org',
  mappings = {
    global = {
      org_agenda = {'gA', '<Leader>oa'},
      org_capture = {'gC', '<Leader>oc'}
    }
  }
})
