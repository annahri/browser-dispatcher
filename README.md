# Browser Dispatcher

Browser Dispatcher is a shell script that allows users to open URLs in predefined browsers based on rules specified in a configuration file. It supports dynamic URL matching using YAML configuration.

## Features

- Match URLs to specific browsers using simple rules.
- Supports regex for flexible URL matching.

## Dependencies

- Bash
- [Kislyuk's yq](https://github.com/kislyuk/yq)

## Installation

1. Clone the repository
1. Put the script somewhere in your `PATH`, e.g. `~/.local/bin`
1. Put the `.desktop` file in `~/.local/share/applications` 
1. Execute `xdg-mime default browser-dispatcher x-scheme-handler/http x-scheme-handler/https`
1. Copy the sample config file to `~/.config/browser-dispatcher/config.yaml`
1. Modify the config to your preference
1. Done

or just run `make install`

## Uninstallation

1. Delete the files
2. Set your default browser back

or just run `make uninstall`
