registry_sources = [
  'main.vala',
  'window.vala',
    'application.vala',
  ]

registry_deps = [
  dependency('gtk4'),
  dependency('sqlite3'),
]

gnome = import('gnome')

registry_sources += gnome.compile_resources('registry-resources',
  'registry.gresource.xml',
  c_name: 'registry'
)

executable('registry', registry_sources,
  vala_args: '--target-glib=2.50',  dependencies: registry_deps,
  install: true,
)
