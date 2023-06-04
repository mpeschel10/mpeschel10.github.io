from pathlib import Path
script_dir = Path(__file__).resolve().parent
site_dir = script_dir.joinpath('mpeschel10.github.io')
install_scripts_dir = site_dir.joinpath('arch-install-scripts')
link_path = site_dir.joinpath('00_download_install_scripts.sh')

url_base = 'https://mpeschel10.github.io/'
links = [url_base + str(path.relative_to(site_dir)) for
    path in install_scripts_dir.iterdir()]

with open(link_path, 'w') as link_file:
    link_file.write('#!/bin/sh\n')
    for link in links:
        command = 'curl %s > %s\n' % (link, Path(link).name)
        link_file.write(command)

