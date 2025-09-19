#!/usr/bin/env bash

set -e

# This script is based on TangoMan Shoe Shell Microframework
#
# This file is distributed under to the MIT license.
#
# Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Source code is available here: https://github.com/TangoMan75/shoe

## TangoMan Pivot CSS
##
## TangoMan Pivot CSS is a lightweight extension of pico.css,
## (the minimal CSS framework for semantic HTML) focused on providing
## a boilerplate for building single page applications.
##
## @author  "Matthias Morin" <mat@tangoman.io>
## @version 1.0.0
## @license MIT
## @link    https://github.com/TangoMan75/pivot
## @update  https://raw.githubusercontent.com/TangoMan75/pivot/refs/heads/main/entrypoint.sh

#--------------------------------------------------
# Place your constants after this line
#--------------------------------------------------

## Script alias
ALIAS=pivot

#--------------------------------------------------
# Place your options after this line
#--------------------------------------------------

#--------------------------------------------------
# Place your flags after this line
#--------------------------------------------------

#--------------------------------------------------
# Place your private constants after this line
#--------------------------------------------------

#--------------------------------------------------
# Place your global variables after this line
#--------------------------------------------------

#--------------------------------------------------
# Place your functions after this line
#--------------------------------------------------

##################################################
### App
##################################################


## Open in default browser
##
## {
##   "namespace": "app",
##   "requires": [
##     "nohup"
##   ],
##   "depends": [
##     "_open",
##     "echo_info"
##   ]
## }
open() {
    echo_info "nohup $(_open) ./index.html >/dev/null 2>&1\n"
    nohup "$(_open)" ./index.html >/dev/null 2>&1
}

## Watch source folder for changes
##
## {
##   "namespace": "app",
##   "requires": [
##     "yarn"
##   ],
##   "depends": [
##     "echo_info"
##   ]
## }
watch() {
    echo_info 'yarn watch\n'
    yarn watch
}

## Build app to "dist" folder
##
## {
##   "namespace": "app",
##   "depends": [
##     "cname"
##   ]
## }
build() {
    echo_info 'rm -rf ./dist/css\n'
    rm -rf ./dist/css

    echo_info 'rm -rf ./dist/js\n'
    rm -rf ./dist/js

    echo_info 'yarn build\n'
    yarn build
}

## Lint source files
##
## {
##   "namespace": "app",
##   "requires": [
##     "yarn"
##   ],
##   "depends": [
##     "echo_info"
##   ]
## }
lint() {
    echo_info 'yarn lint\n'
    yarn lint
}

## Run unit tests
##
## {
##   "namespace": "app",
##   "requires": [
##     "yarn"
##   ],
##   "depends": [
##     "echo_info"
##   ]
## }
tests() {
    echo_info 'yarn test\n'
    yarn test
}

## Deploy "dist" folder to "gh-pages"
##
## {
##   "namespace": "app",
##   "requires": [
##     "git"
##   ],
##   "depends": [
##     "echo_info"
##   ]
## }
deploy() {
    # `git subtree split --prefix dist main`: create a temporary commit history from the "dist" subdirectory of the "main" branch.
    echo_info "git push origin \"$(git subtree split --prefix dist main)\":gh-pages --force\n"
    git push origin "$(git subtree split --prefix dist main)":gh-pages --force
}

## Import icons from FontAwesome
##
## {
##   "namespace": "app",
##   "requires": [
##     "curl"
##   ],
##   "depends": [
##     "alert_primary",
##     "_import_icons"
##   ]
## }
import_icons() {
    alert_primary 'Importing FontAwesome icons...'

    _import_icons "brands" "$(curl -s https://raw.githubusercontent.com/FortAwesome/Font-Awesome/refs/heads/6.x/css/brands.css)" > ./src/js/icons/brands.js
    _import_icons "fontawesome" "$(curl -s https://raw.githubusercontent.com/FortAwesome/Font-Awesome/refs/heads/6.x/css/fontawesome.css)" > ./src/js/icons/fontawesome.js
}

#--------------------------------------------------
# Place your private functions after this line
#--------------------------------------------------


# Import icons from FontAwesome
#
# {
#   "namespace": "app",
#   "requires": [
#     "bash",
#     "echo",
#     "grep",
#     "printf",
#     "sort"
#   ]
# }
_import_icons() {
    name="$1"
    icons=$(echo "$2" | grep -oP 'fa-[a-zA-Z0-9-]+' | sort -u)
    exclude_icons="fa-0 fa-1 fa-10x fa-1x fa-2 fa-2x fa-2xl fa-2xs fa-3 fa-3x fa-4 fa-4x fa-5 fa-5x fa-6 fa-6x fa-7 fa-7x fa-8 fa-8x fa-9 fa-9x fa-animation-delay fa-animation-direction fa-animation-duration fa-animation-iteration-count fa-animation-timing fa-beat fa-beat-fade fa-beat-fade-opacity fa-beat-fade-scale fa-beat-scale fa-border fa-border-color fa-border-padding fa-border-radius fa-border-style fa-border-width fa-bounce fa-bounce-height fa-bounce-jump-scale-x fa-bounce-jump-scale-y fa-bounce-land-scale-x fa-bounce-land-scale-y fa-bounce-rebound fa-bounce-start-scale-x fa-bounce-start-scale-y fa-brands fa-classic fa-display fa-fade fa-fade-opacity fa-flip fa-flip-angle fa-flip-both fa-flip-horizontal fa-flip-vertical fa-flip-x fa-flip-y fa-flip-z fa-fw fa-inverse fa-level-up-alt fa-lg fa-li fa-li-margin fa-li-width fa-pull-left fa-pull-margin fa-pull-right fa-pulse fa-regular fa-rotate-180 fa-rotate-270 fa-rotate-90 fa-rotate-angle fa-rotate-by fa-shake fa-sm fa-solid fa-spin fa-spin-pulse fa-spin-reverse fa-sr-only fa-sr-only-focusable fa-stack fa-stack-1x fa-stack-2x fa-stack-z-index fa-style fa-style-family fa-ul fa-xl fa-xs"

    filtered_icons=()
    for icon in ${icons}; do
        # shellcheck disable=SC2076
        if [[ ! "${exclude_icons}" =~ "${icon} " ]]; then
            filtered_icons+=("$icon")
        fi
    done

    json=$(printf "  \"%s\",\n" "${filtered_icons[@]}")

    echo -e "export const ${name} = [\n${json%,}\n];"
}

##################################################
### Install
##################################################

## Check requirements
##
## {
##   "namespace": "install",
##   "depends": [
##     "_check_installed"
##   ]
## }
requirements() {
    _check_installed awk
    _check_installed sed
}

##################################################
### Self Install
##################################################

## Install script and enable completion
##
## {
##   "namespace": "install",
##   "depends": [
##     "_install"
##   ],
##   "assumes": [
##     "ALIAS",
##     "global"
##   ]
## }
self_install() {
    _install "$0" "${ALIAS}" "${global:-false}"
}

## Uninstall script from system
##
## {
##   "namespace": "install",
##   "depends": [
##     "_uninstall"
##   ],
##   "assumes": [
##     "ALIAS"
##   ]
## }
self_uninstall() {
    _uninstall "$0" "${ALIAS}"
}

##################################################
### Help
##################################################

## Print this help
##
## {
##   "namespace": "help",
##   "depends": [
##     "_help"
##   ]
## }
help() {
    _help "$0"
}

#--------------------------------------------------
#_ Hooks
#--------------------------------------------------

# Place here commands you need executed by default (optional)
#
# {
#   "namespace": "hooks"
# }
_default() {
    help
}

## Run following code before each execution
##
## {
##   "depends": [
##     "requirements"
##   ]
## }
_before() {
    requirements
    cd "$(_pwd)" || return 1
}

# Place here commands you need executed last every time (optional)
#
# {
#   "namespace": "hooks"
# }
_after() {
    return 0
}

###################################################
# TangoMan Shoe Shell Microframework
###################################################

#--------------------------------------------------
# Generated code : Do not edit below this line
#--------------------------------------------------

#--------------------------------------------------
#_ Shoedoc
#--------------------------------------------------

# Get shoedoc description
#
# {
#   "namespace": "shoedoc",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "TEXT",
#       "type": "str",
#       "description": "The input shoedoc annotation bloc.",
#       "nullable": false
#     }
#   ]
# }
_get_shoedoc_description() {
    # Synopsis: _get_shoedoc_description <TEXT>
    #   TEXT: The input shoedoc annotation bloc.

    if [ -z "$1" ]; then echo_danger 'error: _get_shoedoc_description: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _get_shoedoc_description: too many arguments ($#)\n"; return 1; fi

    printf '%s' "$1" | awk '/^#.*/ {
        if (substr($2,1,1) != "@") {
            RESULT=substr($0,length($1)+2); # remove leading pound character(s)
            count+=1;
            if (count==2 && RESULT=="") next;
            if (count>1) print RESULT
        }
    }'
}

# Get shoedoc
#
# {
#   "namespace": "shoedoc",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "TEXT",
#       "type": "str",
#       "description": "The input shoedoc annotation bloc.",
#       "nullable": false
#     }
#   ]
# }
_get_shoedoc() {
    # Synopsis: _get_shoedoc <TEXT>
    #   TEXT: The input shoedoc annotation bloc.
    #   note: Remove every line that does not start with a pound character or contains a tag
    #         Returns string without leading pound characters

    if [ -z "$1" ]; then echo_danger 'error: _get_shoedoc: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _get_shoedoc: too many arguments ($#)\n"; return 1; fi

    printf '%s' "$1" | awk '/^#.*/ {
        if (substr($2,1,1) != "@") {
            RESULT=substr($0,length($1)+2); # remove leading pound character(s)
            print RESULT
        }
    }'
}

# Return given tag values from shoedoc bloc
#
# {
#   "namespace": "shoedoc",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "TEXT",
#       "type": "str",
#       "description": "The input shoedoc annotation bloc.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "TAG_NAME",
#       "type": "str",
#       "description": "The name of tag to return.",
#       "nullable": false
#     }
#   ]
# }
_get_shoedoc_tag() {
    # Synopsis: _get_shoedoc_tag <TEXT> <TAG_NAME>
    #   TEXT:     The input shoedoc annotation bloc.
    #   TAG_NAME: The name of tag to return.

    if [ -z "$1" ] || [ -z "$2" ]; then echo_danger 'error: _get_shoedoc_tag: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _get_shoedoc_tag: too many arguments ($#)\n"; return 1; fi

    printf '%s' "$1" | awk -v TAG="$2" '/^#.*/ {
        if ($2=="@"TAG) {
            gsub(" +"," "); sub("^ +",""); sub(" +$",""); # trim input
            RESULT=substr($0,length($1)+length($2)+3);    # remove leading pound character(s)
            print RESULT
        }
    }'
}

# Get shoedoc title
#
# {
#   "namespace": "shoedoc",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "TEXT",
#       "type": "str",
#       "description": "The input shoedoc annotation bloc.",
#       "nullable": false
#     }
#   ]
# }
_get_shoedoc_title() {
    # Synopsis: _get_shoedoc_title <TEXT>
    #   TEXT: The input shoedoc annotation bloc.
    #   note: Returns the first line that does not contain a tag

    if [ -z "$1" ]; then echo_danger 'error: _get_shoedoc_title: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _get_shoedoc_title: too many arguments ($#)\n"; return 1; fi

    printf '%s' "$1" | awk '/^#.*/ {
        if (substr($2,1,1) != "@") {
            RESULT=substr($0,length($1)+2); # remove leading pound character(s)
            print RESULT; exit
        }
    }'
}

# Get shoedoc bloc at the top the provided shoe script file
#
# {
#   "namespace": "shoedoc",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     }
#   ]
# }
_get_script_shoedoc() {
    # Synopsis: _get_script_shoedoc <SCRIPT_PATH>
    #   SCRIPT_PATH: The path to the input script.
    #   note:        Each shoedoc should strictly start with two pound signs (##)
    #                Returns the first valid docbloc found in the provided file

    if [ -z "$1" ]; then echo_danger 'error: _get_script_shoedoc: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _get_script_shoedoc: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")"
    if [ ! -f "$1" ]; then echo_danger "error: _get_script_shoedoc: \"$1\" file not found\n"; return 1; fi

    awk '/^## */ {count+=1; print} !/^## */ {if (count>1) exit}' "$1"
}

#--------------------------------------------------
#_ Colors
#--------------------------------------------------

# shellcheck disable=SC2034

# PRIMARY: bright white text
PRIMARY='\033[97m'

# SECONDARY: bright blue text
SECONDARY='\033[94m'

# SUCCESS: bright green text
SUCCESS='\033[32m'

# DANGER: red text
DANGER='\033[31m'

# WARNING: orange text
WARNING='\033[33m'

# INFO: bright purple text
INFO='\033[95m'

# DEFAULT: reset formatting
DEFAULT='\033[0m'

# EOF: reset formatting and carriage return
EOL='\033[0m\n'

# shellcheck disable=SC2034

# ALERT_PRIMARY: bold white text over bright blue background
ALERT_PRIMARY='\033[1;104;97m'

# ALERT_SECONDARY: bold white text over bright purple background
ALERT_SECONDARY='\033[1;45;97m'

# ALERT_SUCCESS: bold white text over bright green background
ALERT_SUCCESS='\033[1;42;97m'

# ALERT_DANGER: bold white text over bright red background
ALERT_DANGER='\033[1;41;97m'

# ALERT_WARNING: bold white text over bright orange background
ALERT_WARNING='\033[1;43;97m'

# ALERT_INFO: bold white text over bright blue background
ALERT_INFO='\033[1;44;97m'

# Print primary text with optional indentation and padding
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "INDENTATION",
#       "type": "int",
#       "description": "Indentation level.",
#       "default": 0
#     },
#     {
#       "position": 3,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 0
#     }
#   ]
# }
echo_primary() {
    # Synopsis: echo_primary <STRING> [INDENTATION] [PADDING]
    #  STRING:      Text to display.
    #  INDENTATION: Indentation level (default: 0).
    #  PADDING:     Padding length (default: 0).
    #  note:        Older versions of printf supports a more limited set of format specifiers (eg: "%-*b"),
    #               this is why we're calculating the PADDING length on each execution.

    set -- "$1" "${2:-0}" "$((${3:-0}-${#1}))"
    if [ "$3" -lt 0 ]; then set -- "$1" "$2" 0; fi
    printf "%*s${PRIMARY}%b${DEFAULT}%*s"   "$2" '' "$1" "$3" ''
}

# Print secondary text with optional indentation and padding
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "INDENTATION",
#       "type": "int",
#       "description": "Indentation level.",
#       "default": 0
#     },
#     {
#       "position": 3,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 0
#     }
#   ]
# }
echo_secondary() {
    # Synopsis: echo_secondary <STRING> [INDENTATION] [PADDING]
    #  STRING:       Text to display.
    #  INDENTATION:  Indentation level (default: 0).
    #  PADDING:      Padding length (default: 0).

    set -- "$1" "${2:-0}" "$((${3:-0}-${#1}))"
    if [ "$3" -lt 0 ]; then set -- "$1" "$2" 0; fi
    printf "%*s${SECONDARY}%b${DEFAULT}%*s" "$2" '' "$1" "$3" ''
}

# Print success text with optional indentation and padding
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "INDENTATION",
#       "type": "int",
#       "description": "Indentation level.",
#       "default": 0
#     },
#     {
#       "position": 3,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 0
#     }
#   ]
# }
echo_success() {
    # Synopsis: echo_success <STRING> [INDENTATION] [PADDING]
    #  STRING:       Text to display.
    #  INDENTATION:  Indentation level (default: 0).
    #  PADDING:      Padding length (default: 0).

    set -- "$1" "${2:-0}" "$((${3:-0}-${#1}))"
    if [ "$3" -lt 0 ]; then set -- "$1" "$2" 0; fi
    printf "%*s${SUCCESS}%b${DEFAULT}%*s"   "$2" '' "$1" "$3" ''
}

# Print danger text with optional indentation and padding
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "INDENTATION",
#       "type": "int",
#       "description": "Indentation level.",
#       "default": 0
#     },
#     {
#       "position": 3,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 0
#     }
#   ]
# }
echo_danger() {
    # Synopsis: echo_danger <STRING> [INDENTATION] [PADDING]
    #  STRING:       Text to display.
    #  INDENTATION:  Indentation level (default: 0).
    #  PADDING:      Padding length (default: 0).

    set -- "$1" "${2:-0}" "$((${3:-0}-${#1}))"
    if [ "$3" -lt 0 ]; then set -- "$1" "$2" 0; fi
    printf "%*s${DANGER}%b${DEFAULT}%*s"    "$2" '' "$1" "$3" ''
}

# Print warning text with optional indentation and padding
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "INDENTATION",
#       "type": "int",
#       "description": "Indentation level.",
#       "default": 0
#     },
#     {
#       "position": 3,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 0
#     }
#   ]
# }
echo_warning() {
    # Synopsis: echo_warning <STRING> [INDENTATION] [PADDING]
    #  STRING:       Text to display.
    #  INDENTATION:  Indentation level (default: 0).
    #  PADDING:      Padding length (default: 0).

    set -- "$1" "${2:-0}" "$((${3:-0}-${#1}))"
    if [ "$3" -lt 0 ]; then set -- "$1" "$2" 0; fi
    printf "%*s${WARNING}%b${DEFAULT}%*s"   "$2" '' "$1" "$3" ''
}

# Print info text with optional indentation and padding
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "INDENTATION",
#       "type": "int",
#       "description": "Indentation level.",
#       "default": 0
#     },
#     {
#       "position": 3,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 0
#     }
#   ]
# }
echo_info() {
    # Synopsis: echo_info <STRING> [INDENTATION] [PADDING]
    #  STRING:       Text to display.
    #  INDENTATION:  Indentation level (default: 0).
    #  PADDING:      Padding length (default: 0).

    set -- "$1" "${2:-0}" "$((${3:-0}-${#1}))"
    if [ "$3" -lt 0 ]; then set -- "$1" "$2" 0; fi
    printf "%*s${INFO}%b${DEFAULT}%*s"      "$2" '' "$1" "$3" ''
}

# Print primary alert
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     }
#   ]
# }
alert_primary()   {
    # Synopsis: alert_primary <STRING>
    #   STRING: Text to display.

    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_PRIMARY}"   '' "${ALERT_PRIMARY}"   "$1" "${ALERT_PRIMARY}"   ''
}

# Print secondary alert
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     }
#   ]
# }
alert_secondary() {
    # Synopsis: alert_secondary <STRING>
    #   STRING: Text to display.

    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SECONDARY}" '' "${ALERT_SECONDARY}" "$1" "${ALERT_SECONDARY}" ''
}

# Print success alert
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     }
#   ]
# }
alert_success()   {
    # Synopsis: alert_success <STRING>
    #   STRING: Text to display.

    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_SUCCESS}"   '' "${ALERT_SUCCESS}"   "$1" "${ALERT_SUCCESS}"   ''
}

# Print danger alert
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     }
#   ]
# }
alert_danger()    {
    # Synopsis: alert_danger <STRING>
    #   STRING: Text to display.

    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_DANGER}"    '' "${ALERT_DANGER}"    "$1" "${ALERT_DANGER}"    ''
}

# Print warning alert
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     }
#   ]
# }
alert_warning()   {
    # Synopsis: alert_warning <STRING>
    #   STRING: Text to display.

    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_WARNING}"   '' "${ALERT_WARNING}"   "$1" "${ALERT_WARNING}"   ''
}

# Print info alert
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "STRING",
#       "type": "str",
#       "description": "Text to display.",
#       "nullable": false
#     }
#   ]
# }
alert_info()      {
    # Synopsis: alert_info <STRING>
    #   STRING: Text to display.

    printf "${EOL}%b%64s${EOL}%b %-63s${EOL}%b%64s${EOL}\n" "${ALERT_INFO}"      '' "${ALERT_INFO}"      "$1" "${ALERT_INFO}"      ''
}

# Print error message to STDERR, prefixed with "error: "
#
# {
#   "namespace": "colors",
#   "parameters": [
#     {
#       "position": 1,
#       "name": "MESSAGE",
#       "type": "str",
#       "description": "Error message to display.",
#       "nullable": false
#     }
#   ]
# }
echo_error() {
    # Synopsis: echo_error <MESSAGE>
    #   MESSAGE: Error message to display.

    printf "${DANGER}error: %s${DEFAULT}\n" "$1" >&2

}

#--------------------------------------------------
#_ Compatibility
#--------------------------------------------------

# Open with default system handler
#
# {
#   "namespace": "compatibility",
#   "requires": [
#     "uname"
#   ]
# }
_open() {
    # Synopsis: _open

    if [ "$(uname)" = 'Darwin' ]; then
        echo 'open'

        return 0
    fi

    echo 'xdg-open'
}

# Return sed -i system flavour
#
# {
#   "namespace": "compatibility",
#   "requires": [
#     "command",
#     "sed",
#     "uname"
#   ]
# }
_sed_i() {
    # Synopsis: _sed_i

    if [ "$(uname)" = 'Darwin' ] && [ -n "$(command -v sed)" ] && [ -z "$(sed --version 2>/dev/null)" ]; then
        echo "sed -i ''"

        return 0
    fi

    echo 'sed -i'
}

#--------------------------------------------------
#_ Help
#--------------------------------------------------


# Print help for provider shoe script
#
# {
#   "namespace": "help",
#   "depends": [
#     "_get_constants",
#     "_get_flags",
#     "_get_function_annotation",
#     "_get_options",
#     "_get_padding",
#     "_get_script_shoedoc",
#     "_get_shoedoc_description",
#     "_get_shoedoc_title",
#     "_print_commands",
#     "_print_constants",
#     "_print_description",
#     "_print_flags",
#     "_print_infos",
#     "_print_options",
#     "_print_synopsis",
#     "_print_usage",
#     "alert_primary",
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "FUNCTION_NAME",
#       "type": "str",
#       "description": "The function name to get help for.",
#     }
#   ]
# }
_help() {
    # Synopsis: _help <FILE_PATH>
    #   FILE_PATH: The path to the input file.
    #   FUNCTION_NAME: The function name to get help for.

    if [ -z "$1" ]; then echo_danger 'error: _help: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _help: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "$2"
    if [ ! -f "$1" ]; then echo_danger "error: _help: \"$1\" file not found\n"; return 1; fi

    if [ -z "$2" ]; then
        __padding__=$(_get_padding "$1")
        __annotations__=$(_get_script_shoedoc "$1")

        alert_primary "$(_get_shoedoc_title "${__annotations__}")"

        _print_infos "$1"
        _print_description "$(_get_shoedoc_description "${__annotations__}")"
        _print_usage "$1"

        if [ -n "$(_get_constants "$1")" ]; then
            _print_constants "$1" "${__padding__}"
        fi

        if [ -n "$(_get_flags "$1")" ]; then
            _print_flags "$1" "${__padding__}"
        fi

        if [ -n "$(_get_options "$1")" ]; then
            _print_options "$1" "${__padding__}"
        fi

        _print_commands "$1" "${__padding__}"
        exit 0
    fi

    alert_primary "$2"
    if [ -x "$(command -v jq)" ]; then
        __json__="$(_parse_annotation "$1" "$2")"
        if [ -n "${__json__}" ]; then
            echo_primary "$(printf '%s' "${__json__}" | jq -r '.summary')\n\n"
            echo_secondary "$(_print_synopsis "${__json__}")\n"
            exit 0
        fi
    fi
    echo_info "$(_get_function_annotation "$0" "$2")\n"
}

# List commands of the provided shoe script (used by "help" command)
#
# {
#   "namespace": "help",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger",
#     "echo_warning"
#   ],
#   "assumes": [
#     "PRIMARY",
#     "SUCCESS",
#     "WARNING"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 12
#     }
#   ]
# }
_print_commands() {
    # Synopsis: _print_commands <FILE_PATH> [PADDING]
    #   FILE_PATH: The path to the input file.
    #   PADDING:   (optional) Padding length (default: 12)
    #   note:      "awk: %*x formats are not supported"

    if [ -z "$1" ]; then echo_danger 'error: _print_commands: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _print_commands: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-12}"
    if [ ! -f "$1" ]; then echo_danger "error: _print_commands: \"$1\" file not found\n"; return 1; fi

    echo_warning 'Commands:\n'
    awk -v WARNING="${WARNING}" -v SUCCESS="${SUCCESS}" -v PRIMARY="${PRIMARY}" \
    '/^### /{printf"\n%s%s:%s\n",WARNING,substr($0,5),PRIMARY}
    /^## /{if (annotation=="") annotation=substr($0,4)}
    /^(function +)?[a-zA-Z0-9_]+ *\(\)/ {            # matches a function (ignoring curly braces)
        function_name=substr($0,1,index($0,"(")-1);  # truncate string at opening round bracket
        sub("^function ","",function_name);          # remove leading "function " if present
        gsub(" +","",function_name);                 # trim whitespaces
        if (annotation!="" && substr($0,1,1) != "_") # ignore private functions
        printf "%s  %-'"$2"'s %s%s\n",SUCCESS,function_name,PRIMARY,annotation;
    } !/^## */{annotation=""}' "$1"
    printf '\n'

}

# List constants of the provided shoe script (used by "help" command)
#
# {
#   "namespace": "help",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger",
#     "echo_warning"
#   ],
#   "assumes": [
#     "EOL",
#     "INFO",
#     "PRIMARY",
#     "SUCCESS",
#     "WARNING"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 12
#     }
#   ]
# }
_print_constants() {
    # Synopsis: _print_constants <FILE_PATH> [PADDING]
    #   FILE_PATH: The path to the input file.
    #   PADDING:   (optional) Padding length (default: 12)
    #   note:      "awk: %*x formats are not supported"

    if [ -z "$1" ]; then echo_danger 'error: _print_constants: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _print_constants: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-12}"
    if [ ! -f "$1" ]; then echo_danger "error: _print_constants: \"$1\" file not found\n"; return 1; fi

    echo_warning 'Constants:\n'
    awk -F '=' -v SUCCESS="${SUCCESS}" -v PRIMARY="${PRIMARY}" -v INFO="${INFO}" -v WARNING="${WARNING}" -v EOL="${EOL}" \
    '/^[A-Z0-9_]+=.+$/ {
        if (substr(PREV,1,3) == "## " && substr($0,1,1) != "_")
        printf "%s  %-'"$2"'s %s%s%s (value: %s%s%s)%s",SUCCESS,$1,PRIMARY,substr(PREV,4),INFO,WARNING,$2,INFO,EOL
    } { PREV = $0 }' "$1"
    printf '\n'
}

# Print provided text formatted as a description (used by "help" command)
#
# {
#   "namespace": "help",
#   "depends": [
#     "echo_primary",
#     "echo_warning"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "DESCRIPTION",
#       "type": "str",
#       "description": "A string containing script description.",
#       "nullable": false
#     }
#   ]
# }
_print_description() {
    # Synopsis: _print_description <DESCRIPTION>
    #   DESCRIPTION: A string containing script description.

    echo_warning 'Description:\n'
    echo_primary "$(printf '%s' "$1" | fold -w 64 -s)\n\n" 2
}

# List flags of the provided shoe script (used by "help" command)
#
# {
#   "namespace": "help",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger",
#     "echo_warning"
#   ],
#   "assumes": [
#     "PRIMARY",
#     "SUCCESS"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 12
#     }
#   ]
# }
_print_flags() {
    # Synopsis: _print_flags <FILE_PATH> [PADDING]
    #   FILE_PATH: The path to the input file.
    #   PADDING:   (optional) Padding length (default: 12)
    #   note:      "awk: %*x formats are not supported"

    if [ -z "$1" ]; then echo_danger 'error: _print_flags: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _print_flags: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" $((${2:-12}-2))
    if [ ! -f "$1" ]; then echo_danger "error: _print_flags: \"$1\" file not found\n"; return 1; fi

    echo_warning 'Flags:\n'
    awk -F '=' -v SUCCESS="${SUCCESS}" -v PRIMARY="${PRIMARY}" '/^[a-zA-Z0-9_]+=false$/ {
        if (substr(PREV, 1, 3) == "## " && $1 != toupper($1) && substr($0, 1, 1) != "_")
        printf "%s  --%-'"$2"'s %s%s\n",SUCCESS,$1,PRIMARY,substr(PREV,4)
    } { PREV = $0 }' "$1"
    printf '\n'
}

# Print infos of the provided shoe script (used by "help" command)
#
# {
#   "namespace": "help",
#   "depends": [
#     "_get_script_shoedoc",
#     "_get_shoedoc_tag",
#     "echo_danger",
#     "echo_primary",
#     "echo_success",
#     "echo_warning"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     }
#   ]
# }
_print_infos() {
    # Synopsis: _print_infos <FILE_PATH>
    #   FILE_PATH: The path to the input file.

    if [ -z "$1" ]; then echo_danger 'error: _print_infos: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _print_infos: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")"
    if [ ! -f "$1" ]; then echo_danger "error: _print_infos: \"$1\" file not found\n"; return 1; fi

    __annotations__=$(_get_script_shoedoc "$1")

    echo_warning 'Infos:\n'
    echo_success 'author'  2 8; echo_primary "$(_get_shoedoc_tag "${__annotations__}" 'author')\n"
    echo_success 'version' 2 8; echo_primary "$(_get_shoedoc_tag "${__annotations__}" 'version')\n"
    echo_success 'link'    2 8; echo_primary "$(_get_shoedoc_tag "${__annotations__}" 'link')\n"
    printf '\n'
}

# List options of the provided shoe script (used by "help" command)
#
# {
#   "namespace": "help",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger",
#     "echo_warning"
#   ],
#   "assumes": [
#     "DEFAULT",
#     "EOL",
#     "INFO",
#     "SUCCESS",
#     "WARNING"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "PADDING",
#       "type": "int",
#       "description": "Padding length.",
#       "default": 12
#     }
#   ]
# }
_print_options() {
    # Synopsis: _print_options <FILE_PATH> [PADDING]
    #   FILE_PATH: The path to the input file.
    #   PADDING:   (optional) Padding length (default: 12)
    #   note:      "awk: %*x formats are not supported"

    if [ -z "$1" ]; then echo_danger 'error: _print_options: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _print_options: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" $((${2:-12}-2))
    if [ ! -f "$1" ]; then echo_danger "error: _print_options: \"$1\" file not found\n"; return 1; fi

    echo_warning "Options:\n"
    awk  -F '=' -v WARNING="${WARNING}" -v SUCCESS="${SUCCESS}" -v INFO="${INFO}" -v DEFAULT="${DEFAULT}" -v EOL="${EOL}" \
    '/^[a-zA-Z0-9_]+=.+$/ {
        if (substr(PREV,1,3) == "## " && $1 != toupper($1) && $2 != "false" && substr($0,1,1) != "_") {
            if (match(PREV,/ \/.+\//)) {
                # if option has constaint
                CONSTRAINT=substr(PREV,RSTART,RLENGTH);
                ANNOTATION=substr(PREV,4,length(PREV)-length(CONSTRAINT)-3);
                printf "%s  --%-'"$2"'s %s%s%s %s%s (default: %s%s%s)%s",SUCCESS,$1,DEFAULT,ANNOTATION,SUCCESS,CONSTRAINT,INFO,WARNING,$2,INFO,EOL
            } else {
                ANNOTATION=substr(PREV,4);
                printf "%s  --%-'"$2"'s %s%s%s (default: %s%s%s)%s",SUCCESS,$1,DEFAULT,ANNOTATION,INFO,WARNING,$2,INFO,EOL
            }
        }
    } { PREV = $0 }' "$1"
    printf '\n'
}

# Print usage of the provided shoe script (used by "help" command)
#
# {
#   "namespace": "help",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger",
#     "echo_info",
#     "echo_success",
#     "echo_warning"
#   ],
#   "assumes": [
#     "DEFAULT",
#     "INFO",
#     "SUCCESS",
#     "WARNING"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     }
#   ]
# }
_print_usage() {
    # Synopsis: _print_usage <FILE_PATH>
    #   FILE_PATH: The path to the input file.

    if [ -z "$1" ]; then echo_danger 'error: _print_usage: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _print_usage: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")"
    if [ ! -f "$1" ]; then echo_danger "error: _print_usage: \"$1\" file not found\n"; return 1; fi

    echo_warning 'Usage:\n'
    echo_info "sh $(basename "$1") <" 2; echo_success 'command'; echo_info '> '
    # options
    awk -F '=' -v INFO="${INFO}" -v SUCCESS="${SUCCESS}" -v WARNING="${WARNING}" -v DEFAULT="${DEFAULT}" \
    '/^[a-zA-Z0-9_]+=.+$/ {
        if (substr(PREV,1,3) != "## " || $1 == toupper($1) || substr($1,1,1) == "_") next;
        if ($2 == "false") {printf "%s[%s--%s%s]%s ",INFO,SUCCESS,$1,INFO,DEFAULT;next}
        printf "%s[%s--%s %s%s%s]%s ",INFO,SUCCESS,$1,WARNING,$2,INFO,DEFAULT
    } {PREV = $0} END {print "\n"}' "$1"
}

#--------------------------------------------------
#_ Install
#--------------------------------------------------

# Install script via copy
#
# {
#   "namespace": "install",
#   "depends": [
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "ALIAS",
#       "type": "str",
#       "description": "The alias of the script to install. Defaults to the basename of the provided file."
#     }
#   ]
# }
_copy_install() {
    # Synopsis: _copy_install <FILE_PATH> [ALIAS]
    #   FILE_PATH: The path to the input file.
    #   ALIAS:     (optional) The alias of the script to install. Defaults to the basename of the provided file
    #   note:      Creates a symbolic link in the /usr/local/bin/ directory.

    if [ -z "$1" ]; then echo_danger 'error: _copy_install: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _copy_install: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-"$(basename "$1" .sh)"}"
    if [ ! -f "$1" ]; then echo_danger "error: _copy_install: \"$1\" file not found\n"; return 1; fi

    echo_info "sudo cp -a \"$1\" \"/usr/local/bin/$2\"\n"
    sudo cp -a "$1" "/usr/local/bin/$2"
}

# Generates an autocomplete script for the provided file
#
# {
#   "namespace": "install",
#   "depends": [
#     "_get_comspec",
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "ALIAS",
#       "type": "str",
#       "description": "The alias of the script to install. Defaults to the basename of the provided file."
#     }
#   ]
# }
_generate_autocomplete() {
    # Synopsis: _generate_autocomplete <FILE_PATH> [ALIAS]
    #   FILE_PATH: The path to the input file.
    #   ALIAS:     (optional) The alias of the script to autocomplete. Defaults to the basename of the provided file
    #   note:      This function creates a completion script named "<ALIAS>-completion.sh" in the same directory as the script itself.
    #              Refer to https://iridakos.com/programming/2018/03/01/bash-programmable-completion-tutorial for details on how to configure shell autocompletions.
    #              Or read the official docmentation for "complete" https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html#Programmable-Completion-Builtins

    if [ -z "$1" ]; then echo_danger 'error: _generate_autocomplete: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _generate_autocomplete: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-"$(basename "$1" .sh)"}"
    if [ ! -f "$1" ]; then echo_danger "error: _generate_autocomplete: \"$1\" file not found\n"; return 1; fi

    echo_info "printf '#!/bin/bash\\\ncomplete -f -d -W \"%s\" \"%s\"' \"$(_get_comspec "$1")\" \"$2\" > \"$(dirname "$1")/$2-completion.sh\"\n"
    printf '#!/bin/bash\ncomplete -f -d -W "%s" "%s"' "$(_get_comspec "$1")" "$2" > "$(dirname "$1")/$2-completion.sh"
}

# Creates a system-wide autocomplete script for the provided file
#
# {
#   "namespace": "install",
#   "depends": [
#     "_get_comspec",
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "ALIAS",
#       "type": "str",
#       "description": "The alias of the script to install. Defaults to the basename of the provided file."
#     }
#   ]
# }
_generate_global_autocomplete() {
    # Synopsis: _generate_global_autocomplete <FILE_PATH> [ALIAS]
    #   FILE_PATH: The path to the input file.
    #   ALIAS:     (optional) The alias of the script to autocomplete. Defaults to the basename of the provided file
    #   note:      This function creates a completion script named "<ALIAS>" (where "<ALIAS>" is the basename of the provided file)
    #              in the /etc/bash_completion.d/ directory, enabling autocompletion for all users on the system.
    #              It uses sudo for file creation in a system directory, requiring root privileges.

    if [ -z "$1" ]; then echo_danger 'error: _generate_global_autocomplete: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _generate_global_autocomplete: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-"$(basename "$1" .sh)"}"
    if [ ! -f "$1" ]; then echo_danger "error: _generate_global_autocomplete: \"$1\" file not found\n"; return 1; fi

    echo_info "printf '#!/bin/bash\\\ncomplete -W \"%s\" \"%s\"' \"$(_get_comspec "$1")\" \"$2\" | sudo tee \"/etc/bash_completion.d/$2\"\n"
    printf '#!/bin/bash\ncomplete -W "%s" "%s"' "$(_get_comspec "$1")" "$2" | sudo tee "/etc/bash_completion.d/$2"
}

# Generate comspec string for the provided file
#
# {
#   "namespace": "install",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     }
#   ]
# }
_get_comspec() {
    # Synopsis: _get_comspec <FILE_PATH>
    #   FILE_PATH: The path to the input file.

    if [ -z "$1" ]; then echo_danger 'error: _get_comspec: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _get_comspec: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")"
    if [ ! -f "$1" ]; then echo_danger "error: _get_comspec: \"$1\" file not found\n"; return 1; fi

    awk '/^(function *)?[a-zA-Z0-9_]+ *\(\) *\{/ {
        sub("^function ",""); gsub("[ ()]","");
        FUNCTION = substr($0,1,index($0,"{"));
        sub("{$","",FUNCTION);
        if (substr(PREV,1,3) == "## " && substr($0,1,1) != "_")
        printf "%s ",FUNCTION,substr(PREV,4)
    } {PREV = $0}' "$1"

    awk -F '=' '/^[a-zA-Z0-9_]+=.+$/ {
        if (substr(PREV,1,3) == "## " && $1 != toupper($1) && substr($0,1,1) != "_") {
            printf "--%s ",$1
        }
    } {PREV = $0}' "$1"
}

# Install script and enable completion
#
# {
#   "namespace": "install",
#   "depends": [
#     "_copy_install",
#     "_generate_autocomplete",
#     "_generate_global_autocomplete",
#     "_is_installed",
#     "_set_completion_autoload",
#     "_symlink_install",
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "ALIAS",
#       "type": "str",
#       "description": "The alias of the script to install. Defaults to the basename of the provided file."
#     },
#     {
#       "position": 3,
#       "name": "GLOBAL",
#       "type": "bool",
#       "description": "Install globally.",
#       "default": false
#     }
#   ]
# }
_install() {
    # Synopsis: _install <FILE_PATH> [ALIAS] [GLOBAL]
    #   FILE_PATH: The path to the input file.
    #   ALIAS:     (optional) The alias of the script to install. Defaults to the basename of the provided script.
    #   GLOBAL:    (optional) Install globally. Defaults to "false".

    if [ -z "$1" ]; then echo_danger 'error: _install: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 3 ]; then echo_danger "error: _install: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-"$(basename "$1" .sh)"}" "${3:-false}"
    if [ ! -f "$1" ]; then echo_danger "error: _install: \"$1\" file not found\n"; return 1; fi

    if [ "$3" = true ]; then
        _copy_install "$1" "$2"
        _generate_global_autocomplete "$1" "$2"
    else
        _symlink_install "$1" "$2"
        _generate_autocomplete "$1" "$2"
    fi

    if _is_installed zsh; then
        # https://superuser.com/questions/886132/where-is-the-zshrc-file-on-mac
        if [ "$(uname)" = 'Darwin' ]; then
            touch ~/.zshrc
        fi
        _set_completion_autoload ~/.zshrc "$1" "$2" || true
    fi

    if _is_installed bash; then
        # set default bash profile
        if [ ! -f ~/.bashrc ] || [ "$(uname)" = 'Darwin' ]; then
            _set_completion_autoload ~/.profile "$1" "$2"
        else
            _set_completion_autoload ~/.bashrc "$1" "$2"
        fi
    fi
}

# Remove completion script autoload
#
# {
#   "namespace": "install",
#   "depends": [
#     "_sed_i",
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SHELL_CONFIG_FILE",
#       "type": "file",
#       "description": "The path to the shell configuration file to update (e.g., ~/.bashrc, ~/.zshrc).",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "ALIAS",
#       "type": "str",
#       "description": "The alias of the script to install. Defaults to the basename of the provided file."
#     }
#   ]
# }
_remove_completion_autoload() {
    # Synopsis: _remove_completion_autoload <SHELL_CONFIG_FILE> [ALIAS]
    # Removes an autoload line for a completion script from a shell configuration file.
    #   SHELL_CONFIG_FILE: The path to the shell configuration file to update (e.g., ~/.bashrc, ~/.zshrc).
    #   ALIAS:             (optional) The alias of the script to remove. Defaults to the basename of the provided file

    if [ $# -lt 1 ]; then echo_danger 'error: _remove_completion_autoload: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _remove_completion_autoload: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-"$(basename "$1" .sh)"}"
    if [ ! -f "$1" ]; then echo_danger "error: _remove_completion_autoload: \"$1\" file not found\n"; return 1; fi

    echo_info "$(_sed_i) \"/^###> $2$/,/^###< $2$/d\" \"$1\"\n"
    $(_sed_i) "/^###> $2$/,/^###< $2$/d" "$1"

    # collapse blank lines
    # The N command reads the next line into the pattern space (the line being processed).
    # The remaining expression checks if the pattern space now consists of two empty lines (^\n$).
    $(_sed_i) '/^$/{N;s/^\n$//;}' "$1"
}

# Adds an autoload line for completion script to a shell configuration file
#
# {
#   "namespace": "install",
#   "depends": [
#     "_collapse_blank_lines",
#     "_sed_i",
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SHELL_CONFIG_FILE",
#       "type": "file",
#       "description": "The path to the shell configuration file to update (e.g., ~/.bashrc, ~/.zshrc).",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "SCRIPT_FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 3,
#       "name": "ALIAS",
#       "type": "str",
#       "description": "The alias of the script to install. Defaults to the basename of the provided file."
#     }
#   ]
# }
_set_completion_autoload() {
    # Synopsis: _set_completion_autoload <SHELL_CONFIG_FILE_PATH> <SCRIPT_FILE_PATH> [ALIAS]
    #   SHELL_CONFIG_FILE_PATH: The path to the shell configuration file to be modified (e.g., ~/.bashrc, ~/.zshrc).
    #   SCRIPT_FILE_PATH:       The path to the input file.
    #   ALIAS:                  (optional) The alias of the input script. Defaults to the basename of the provided file

    if [ -z "$1" ]  || [ -z "$2" ]; then echo_danger 'error: _set_completion_autoload: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 3 ]; then echo_danger "error: _set_completion_autoload: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "$(realpath "$2")" "${3:-"$(basename "$2" .sh)"}"
    if [ ! -f "$1" ]; then echo_danger "error: _set_completion_autoload: \"$1\" file not found\n"; return 1; fi
    if [ ! -f "$2" ]; then echo_danger "error: _set_completion_autoload: \"$2\" file not found\n"; return 1; fi

    # declare inner function
    __set_completion_autoload() {
        # Synopsis: __set_completion_autoload <SHELL_CONFIG_FILE_PATH> <COMPLETION_FILE_PATH> <ALIAS>
        # remove previous install if any
        $(_sed_i) "/^###> $3$/,/^###< $3$/d" "$1"

        echo_info "printf '\\\n###> %s\\\nsource %s\\\n###< %s\\\n' \"$3\" \"$2\" \"$3\" >> \"$1\"\n"
        printf '\n###> %s\nsource %s\n###< %s\n' "$3" "$2" "$3" >> "$1"

        _collapse_blank_lines "$1"
    }

    # set global completion file path
    if [ -f "/etc/bash_completion.d/$3" ]; then
        __set_completion_autoload "$1" "/etc/bash_completion.d/$3" "$3"
    fi

    # set completion file path
    if [ -f "$(dirname "$2")/$3-completion.sh" ]; then
        __set_completion_autoload "$1" "$(dirname "$2")/$3-completion.sh" "$3"
    fi
}

# Install script via symlink
#
# {
#   "namespace": "install",
#   "depends": [
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "ALIAS",
#       "type": "str",
#       "description": "The alias of the script to install. Defaults to the basename of the provided file."
#     }
#   ]
# }
_symlink_install(){
    # Synopsis: _symlink_install <FILE_PATH> [ALIAS]
    #   FILE_PATH: The path to the input file.
    #   ALIAS:     (optional) The alias of the script to install. Defaults to the basename of the provided file
    #   note:      Creates a symbolic link in the /usr/local/bin/ directory.

    if [ -z "$1" ]; then echo_danger 'error: _symlink_install some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _symlink_install too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-"$(basename "$1" .sh)"}"
    if [ ! -f "$1" ]; then echo_danger "error: _symlink_install \"$1\" file not found\n"; return 1; fi

    echo_info "sudo ln -s \"$1\" \"/usr/local/bin/$2\"\n"
    sudo ln -s "$1" "/usr/local/bin/$2"
}

# Uninstall script from system
#
# {
#   "namespace": "install",
#   "depends": [
#     "_remove_completion_autoload",
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "ALIAS",
#       "type": "str",
#       "description": "The alias of the script to install. Defaults to the basename of the provided file."
#     }
#   ]
# }
_uninstall() {
    # Synopsis: _uninstall <FILE_PATH> [ALIAS]
    #   FILE_PATH: The path to the input file.
    #   ALIAS:     (optional) The alias of the script to uninstall. Defaults to the basename of the provided script.

    if [ -z "$1" ]; then echo_danger 'error: _uninstall: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _uninstall: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-"$(basename "$1" .sh)"}"
    if [ ! -f "$1" ]; then echo_danger "error: _uninstall: \"$1\" file not found\n"; return 1; fi

    _remove_completion_autoload ~/.zshrc "$2"
    _remove_completion_autoload ~/.bashrc "$2"
    _remove_completion_autoload ~/.profile "$2"

    echo_info "rm -f \"$(dirname "$1")/$2-completion.sh\"\n"
    rm -f "$(dirname "$1")/$2-completion.sh"

    if [ -f "$1" ]; then
        echo_info "sudo rm -f \"/usr/local/bin/$2\"\n"
        sudo rm -f "/usr/local/bin/$2"
    fi

    if [ -f "/etc/bash_completion.d/$2" ]; then
        echo_info "sudo rm -f /etc/bash_completion.d/$2\n"
        sudo rm -f /etc/bash_completion.d/"$2"
    fi
}

#--------------------------------------------------
#_ Reflexion
#--------------------------------------------------

# List constants from provided shoe script
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "GET_PRIVATE",
#       "type": "bool",
#       "description": "If set to \"true\", retrieves private constants as well.",
#       "default": false
#     }
#   ]
# }
_get_constants() {
    # Synopsis: _get_constants <SCRIPT_PATH> [GET_PRIVATE]
    #   SCRIPT_PATH: The path to the input script.
    #   GET_PRIVATE: (Optional) If set to 'true', retrieves private constants as well. (default=false)

    if [ -z "$1" ]; then echo_danger 'error: _get_constants: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _get_constants: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-false}"
    if [ ! -f "$1" ]; then echo_danger "error: _get_constants: \"$1\" file not found\n"; return 1; fi

    awk -F '=' -v GET_PRIVATE="$2" \
    '/^[A-Z0-9_]+=.+$/ {
        if (GET_PRIVATE == "true") {
            print $1
        } else {
            if (substr(PREV,1,3) == "## " && substr($0,1,1) != "_") print $1
        }
    } {PREV = $0}' "$1"
}

# Get constaint for given variable from provided shoe script
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "VARIABLE_NAME",
#       "type": "str",
#       "description": "The variable to validate.",
#       "nullable": false
#     }
#   ]
# }
_get_constraint() {
    # Synopsis: _get_constraint <SCRIPT_PATH> <VARIABLE_NAME>
    #   SCRIPT_PATH:   The path to the input script.
    #   VARIABLE_NAME: The variable to validate.

    if [ -z "$1" ] || [ -z "$2" ]; then echo_danger 'error: _get_constraint: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _get_constraint: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "$2"
    if [ ! -f "$1" ]; then echo_danger "error: _get_constraint: \"$1\" file not found\n"; return 1; fi

    awk -F '=' -v NAME="$2" \
    '/^## /{if (annotation=="") annotation=substr($0,4)}
    /^[a-zA-Z0-9_]+=.+$/ {
        if (annotation!="" && $1 == NAME) {
            match(annotation, /\/.+\//); print substr(annotation, RSTART, RLENGTH)
        }
    } !/^## */{annotation=""}' "$1"
}

# List flags from provided shoe script
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     }
#   ]
# }
_get_flags() {
    # Synopsis: _get_flags <SCRIPT_PATH>
    #   SCRIPT_PATH: The path to the input script.

    if [ -z "$1" ]; then echo_danger 'error: _get_flags: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _get_flags: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")"
    if [ ! -f "$1" ]; then echo_danger "error: _get_flags: \"$1\" file not found\n"; return 1; fi

    awk -F '=' '/^[a-zA-Z0-9_]+=false$/ {
        if (substr(PREV,1,3) == "## " && $1 != toupper($1) && substr($0,1,1) != "_") print $1
    } {PREV = $0}' "$1"
}

# Get function annotation by name
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "FUNCTION_NAME",
#       "type": "str",
#       "description": "The name of the function to retrieve.",
#       "nullable": false
#     }
#   ]
# }
_get_function_annotation() {
    # Synopsis: _get_function_annotation <SCRIPT_PATH> <FUNCTION_NAME>
    #   SCRIPT_PATH:   The path to the input file.
    #   FUNCTION_NAME: The name of the function to retrieve.

    if [ -z "$1" ] || [ -z "$2" ]; then echo_danger 'error: _get_function_annotation: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _get_function_annotation: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "$2"
    if [ ! -f "$1" ]; then echo_danger "error: _get_function_annotation: \"$1\" file not found\n"; return 1; fi

    awk -v FUNCTION_NAME="$2" '
        /^#/ { annotation=annotation"\n"$0 }
        /^(function +)?[a-zA-Z0-9_]+ *\(\)/ {           # matches a function (ignoring curly braces)
            function_name=substr($0,1,index($0,"(")-1); # truncate string at opening round bracket
            sub("^function ","",function_name);         # remove leading "function " if present
            gsub(" +","",function_name);                # trim whitespaces
            if (function_name==FUNCTION_NAME) print substr(annotation,2); # print annotation (without leading "\n")
        }
        !/^#/ { annotation="" }
    ' "$1"
}

# Get function by name
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "FUNCTION_NAME",
#       "type": "str",
#       "description": "The name of the function to retrieve.",
#       "nullable": false
#     }
#   ]
# }
_get_function() {
    # Synopsis: _get_function <SCRIPT_PATH> <FUNCTION_NAME>
    #   SCRIPT_PATH:   The path to the input file.
    #   FUNCTION_NAME: The name of the function to retrieve.

    if [ -z "$1" ] || [ -z "$2" ]; then echo_danger 'error: _get_function: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _get_function: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "$2"
    if [ ! -f "$1" ]; then echo_danger "error: _get_function: \"$1\" file not found\n"; return 1; fi

    awk -v FUNCTION_NAME="$2" '
    function count_occurrences(str,char) {
        gsub("\\.","",str); # remove escaped characters
        gsub(/"[^"]*"/,""); # remove quoted string
        return gsub(char,char,str);
    }
    /^#/ { annotation=annotation"\n"$0 }
    in_function {
        print $0;
        count=count_occurrences($0,"{")-count_occurrences($0,"}");
        # count+=gsub("{","&")-gsub("}","&");
        if (count==0) exit
    }
    /^(function +)?[a-zA-Z0-9_]+ *\(\)/ {           # matches a function (ignoring curly braces)
        function_name=substr($0,1,index($0,"(")-1); # truncate string at opening round bracket
        sub("^function ","",function_name);         # remove leading "function " if present
        gsub(" +","",function_name);                # trim whitespaces
        if (function_name==FUNCTION_NAME) {
            if (annotation!="") print substr(annotation,2); # print annotation (without leading "\n")
            print $0;
            in_function=1;
            count=count_occurrences($0,"{")-count_occurrences($0,"}"); # count opened and closed curly braces on current line
            # count=gsub("{","&")-gsub("}","&"); # count opened and closed curly braces on current line
        }
    }
    !/^#/ { annotation="" }' "$1"
}

# List functions names from provided shoe script
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "GET_PRIVATE",
#       "type": "bool",
#       "description": "If set to \"true\", retrieves private functions as well.",
#       "default": false
#     }
#   ]
# }
_get_functions_names() {
    # Synopsis: _get_functions_names <SCRIPT_PATH> [GET_PRIVATE]
    #   SCRIPT_PATH: The path to the input script.
    #   GET_PRIVATE: (Optional) If set to 'true', retrieves private functions as well. Defaults to "false".

    if [ -z "$1" ]; then echo_danger 'error: _get_functions_names: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _get_functions_names: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-false}"
    if [ ! -f "$1" ]; then echo_danger "error: _get_functions_names: \"$1\" file not found\n"; return 1; fi

    # this regular expression matches functions with either bash or sh syntax
    awk -v GET_PRIVATE="$2" \
    '/^(function +)?[a-zA-Z0-9_]+ *\(\)/ {          # matches a function (ignoring curly braces)
        function_name=substr($0,1,index($0,"(")-1); # truncate string at opening round bracket
        sub("^function ","",function_name);         # remove leading "function " if present
        gsub(" +","",function_name);                # trim whitespaces
        if (GET_PRIVATE == "true") {
            print function_name
        } else {
            if (substr(PREV,1,3) == "## " && substr($0,1,1) != "_") print function_name
        }
    } {PREV = $0}' "$1"
}

# List options from provided shoe script
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "GET_PRIVATE_ONLY",
#       "type": "bool",
#       "description": "If set to \"true\", retrieves private options only.",
#       "default": false
#     }
#   ]
# }
_get_options() {
    # Synopsis: _get_options <SCRIPT_PATH> [GET_PRIVATE_ONLY]
    #   SCRIPT_PATH:      The path to the input script.
    #   GET_PRIVATE_ONLY: (Optional) If set to 'true', retrieves private options only. Defaults to "false".

    if [ -z "$1" ]; then echo_danger 'error: _get_options: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _get_options: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "${2:-false}"
    if [ ! -f "$1" ]; then echo_danger "error: _get_options: \"$1\" file not found\n"; return 1; fi

    awk -F '=' -v GET_PRIVATE_ONLY="$2" \
    '/^[a-zA-Z0-9_]+=.+$/ {
        if (GET_PRIVATE_ONLY == "true") {
            if ($1 != toupper($1) && $2 != "false" && substr($1,1,1) == "_") print $1
        } else {
            if (substr(PREV,1,3) == "## " && $1 != toupper($1) && $2 != "false" && substr($1,1,1) != "_") print $1
        }
    } {PREV = $0}' "$1"
}

# Guess padding length from longest constant, option, flag or command of the provided shoe script
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "awk"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     }
#   ]
# }
_get_padding() {
    # Synopsis: _get_padding <SCRIPT_PATH>
    #   SCRIPT_PATH: The path to the input script.

    if [ -z "$1" ]; then echo_danger 'error: _get_padding: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _get_padding: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")"
    if [ ! -f "$1" ]; then echo_danger "error: _get_padding: \"$1\" file not found\n"; return 1; fi

    awk -F '=' '
        /^[a-zA-Z0-9_]+=.+$/ { MATCH=$1 }       # matches constants, options and flags
        /^(function +)?[a-zA-Z0-9_]+ *\(\)/ {   # matches a function (ignoring curly braces)
            MATCH=substr($0,1,index($0,"(")-1); # truncate string at opening round bracket
            sub("^function ","",MATCH);         # remove leading "function " if present
            gsub(" +","",MATCH);                # trim whitespaces
        } { if (substr(PREV,1,3) == "## " && substr(MATCH,1,1) != "_" && length(MATCH) > LENGTH) LENGTH = length(MATCH) }
        {PREV = $0} END {print LENGTH}
    ' "$1"
}

# Get value for given parameter from provided ".env" or ".sh" file
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "sed"
#   ],
#   "depends": [
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "KEY",
#       "type": "str",
#       "description": "The variable name to get from provided file.",
#       "nullable": false
#     }
#   ]
# }
_get_parameter() {
    # Synopsys : _get_parameter <FILE_PATH> <KEY>
    #   FILE_PATH: The path to the input file.
    #   KEY:       The variable name to get from provided file.

    if [ -z "$1" ] || [ -z "$2" ]; then echo_danger 'error: _get_parameter: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _get_parameter: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "$2"
    if [ ! -f "$1" ]; then echo_danger "error: _get_parameter: \"$1\" file not found\n"; return 1; fi

    echo_info "sed -n \"s/^$2=\(.*\)/\1/p\" \"$1\"\n"
    sed -n "s/^$2=\(.*\)/\1/p" "$1"
}

# Return function annotation as json
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "jq",
#     "sed"
#   ],
#   "depends": [
#     "_get_function_annotation",
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "SCRIPT_PATH",
#       "type": "file",
#       "description": "The path to the input script.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "FUNCTION_NAME",
#       "type": "str",
#       "description": "The name of the function to retrieve.",
#       "nullable": false
#     }
#   ]
# }
_parse_annotation() {
    # Synopsis: _parse_annotation <SCRIPT_PATH> <FUNCTION_NAME>
    #   SCRIPT_PATH:   The path to the input file.
    #   FUNCTION_NAME: The name of the function to retrieve.

    if [ -z "$1" ] || [ -z "$2" ]; then echo_danger 'error: _parse_annotation: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _parse_annotation: too many arguments ($#)\n"; return 1; fi

    set -- "$(realpath "$1")" "$2"
    if [ ! -f "$1" ]; then echo_danger "error: _parse_annotation: \"$1\" file not found\n"; return 1; fi

    set -- "$1" "$2" "$(printf '%s' "$(_get_function_annotation "$1" "$2" | sed -nE 's/^ *#+ *//p')")"
    set -- "$1" "$2" "$3" "$(printf '%s' "$3" | sed -n '/^{/,$p')" "$(printf '%s' "$3" | head -n 1)"

    if [ "$(printf '%s' "$2" | cut -c1)" = "_" ]; then
        set -- "$1" "$2" "$3" "$4" "$5" 'private'
    else
        set -- "$1" "$2" "$3" "$4" "$5" 'public'
    fi
    # $1: SCRIPT_PATH, $2: FUNCTION_NAME, $3: annotation, $4 json, $5: summary, $6: scope

    if [ -z "$4" ]; then
        jq --null-input \
            --arg name "$2" \
            --arg summary "$5" \
            --arg scope "$6" \
            '$ARGS.named'

        return 0
    fi

    jq --null-input \
    --arg name "$2" \
    --arg summary "$5" \
    --arg scope "$6" \
    '$ARGS.named + '"$4"
}

# Print function synopsis from a JSON string.
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "jq"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "JSON",
#       "type": "json",
#       "description": "The input string containing raw JSON.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "MARKDOWN_FORMAT",
#       "type": "bool",
#       "description": "If set to \"true\", returns result as markdown.",
#       "default": false
#     }
#   ]
# }
_print_synopsis() {
    # Synopsis: _print_synopsis <JSON> [MARKDOWN_FORMAT]
    #   JSON: The input string containing raw JSON.
    #   MARKDOWN_FORMAT: (Optional) If set to 'true', returns result as markdown. Defaults to "false".

    if [ -z "$1" ]; then echo_danger 'error: _print_synopsis: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _print_synopsis: too many arguments ($#)\n"; return 1; fi
    if ! printf '%s' "$1" | jq empty >/dev/null 2>&1; then echo_danger "error: _print_synopsis: invalid JSON input\n"; return 1; fi

    if [ "${2:-false}" = "true" ]; then
        printf '> Synopsis:\n> '
    else
        printf 'Synopsis: '
    fi

    printf '%s' "$1" | jq -rj '.name'

    if [ "${2:-false}" = "true" ]; then
        printf '%s' "$1" | jq -rj '[.parameters // [] | .[] | if (.nullable|tostring) == "false" then " &lt;\(.name)&gt;" else " [\(.name)]" end] | join("")'
        printf '\n'
        printf '%s' "$1" | jq -r '.parameters // [] | .[] | "`\(.name)`: \(if .type then "_(type: \"\(.type)\")_ " else "" end)\(if (.nullable|tostring) == "false" then "" else "(optional) " end)\(if .description then .description else "" end)\(if has("default") then " _Defaults to \"\(.default|tostring)\"._" else "" end)"' | while read -r line; do
            printf '%s\n' "- ${line}"
        done
        printf '\n'
        printf '%s' "$1" | jq -rj '[.requires // [] | .[] | "`\(.)`"] | if length > 0 then "- ⚠️ Requires: \(.|join(", "))\n" else "" end'
        printf '%s' "$1" | jq -rj '[.depends // [] | .[] | "`\(.)`"] | if length > 0 then "- 🔗 Depends: \(.|join(", "))\n" else "" end'
        printf '\n'
        return 0
    fi

    printf '%s' "$1" | jq -rj 'if .scope then " (\(.scope)) " else "" end'
    printf '%s' "$1" | jq -rj '[.parameters // [] | .[] | if (.nullable|tostring) == "false" then "<\(.name)>" else "[\(.name)]" end] | join(" ")'
    printf '\n'
    printf '%s' "$1" | jq -r '.parameters // [] | .[] | "\(.name): \(if .type then "(\(.type)) " else "" end)\(if (.nullable|tostring) == "false" then "" else "(optional) " end)\(if .description then .description else "" end)\(if has("default") then " Defaults to \"\(.default|tostring)\"." else "" end)"' | while read -r line; do
        printf '    %s\n' "${line}"
    done
    printf '%s' "$1" | jq -rj '[.requires // [] | .[]] | if length > 0 then "    Requires: \(.|join(", "))\n" else "" end'
    printf '%s' "$1" | jq -rj '[.depends // [] | .[]] | if length > 0 then "    Depends: \(.|join(", "))\n" else "" end'
    printf '\n'
}

# Set value for given parameter into provided file ".env" or ".sh" file
#
# {
#   "namespace": "reflexion",
#   "requires": [
#     "sed"
#   ],
#   "depends": [
#     "_sed_i",
#     "echo_danger",
#     "echo_info",
#     "echo_warning"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "KEY",
#       "type": "str",
#       "description": "The variable name to get from provided file.",
#       "nullable": false
#     },
#     {
#       "position": 3,
#       "name": "VALUE",
#       "type": "str",
#       "description": "The value to be set to provided file.",
#       "nullable": false
#     }
#   ]
# }
_set_parameter() {
    # Synopsys : _set_parameter <FILE_PATH> <KEY> <VALUE>
    #   FILE_PATH: The path to the input script.
    #   KEY:       The variable name to set to provided file
    #   VALUE:     The value to be set to provided file

    if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then echo_danger 'error: _set_parameter: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 3 ]; then echo_danger "error: _set_parameter: too many arguments ($#)\n"; return 1; fi

    # set default values
    set -- "$(realpath "$1")" "$2" "$3"

    if [ ! -f "$1" ]; then echo_danger "error: _set_parameter: \"$1\" file not found\n"; return 1; fi

    if [ -z "$(_get_parameter "$1")" ]; then
        echo_danger "error: _set_parameter: \"$1\" parameter not found\n"

        return 1
    fi

    if [ "$(_get_parameter "$1")" = "$2" ]; then
        echo_warning "warning: _set_parameter: \"$2\" parameter unchanged\n"

        return 0
    fi

    echo_info "$(_sed_i) -E \"s/^$2=.*/$2=$3/\" \"$1\"\n"
    $(_sed_i) -E "s/^$2=.*/$2=$3/" "$1"
}

#--------------------------------------------------
#_ Strings
#--------------------------------------------------

# Collapse blank lines with "sed"
#
# {
#   "namespace": "strings",
#   "depends": [
#     "_sed_i",
#     "echo_danger",
#     "echo_info"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "FILE_PATH",
#       "type": "file",
#       "description": "The path to the input file.",
#       "nullable": false
#     }
#   ]
# }
_collapse_blank_lines() {
    # Synopsis: _collapse_blank_lines <FILE_PATH>
    #   FILE_PATH: The path to the input file.

    if [ -z "$1" ]; then echo_danger 'error: _collapse_blank_lines: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _collapse_blank_lines: too many arguments ($#)\n"; return 1; fi
    if [ ! -f "$1" ]; then echo_danger "error: _collapse_blank_lines: \"$1\" file not found\n"; return 1; fi
    set -- "$(realpath "$1")"

    # The N command reads the next line into the pattern space.
    # The remaining expression checks if the pattern space now consists of two empty lines (^\n$).
    echo_info "$(_sed_i) '/^$/{N;s/^\\\n$//;}' \"$1\"\n"
    $(_sed_i) '/^$/{N;s/^\n$//;}' "$1"
}

#--------------------------------------------------
#_ System
#--------------------------------------------------

# Print error message if provided command is missing
#
# {
#   "namespace": "system",
#   "depends": [
#     "_get_package_name",
#     "_is_installed",
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "COMMAND",
#       "type": "str",
#       "description": "A string containing the command name to find.",
#       "nullable": false
#     }
#   ]
# }
_check_installed() {
    # Synopsis: _check_installed <COMMAND>
    #   COMMAND: A string containing the command name to find.

    if [ -z "$1" ]; then echo_danger 'error: _check_installed: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _check_installed: too many arguments ($#)\n"; return 1; fi

    if _is_installed "$1"; then
        return 0
    fi

    # set default values
    set -- "$1" "$(_get_package_name "$1")"

    echo_danger "error: \"$(basename "${0}")\" requires $1, try: 'sudo apt-get install -y $2'\n"

    exit 1
}

# Find package name for given command
#
# {
#   "namespace": "system",
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "COMMAND",
#       "type": "str",
#       "description": "A string containing the command name to find.",
#       "nullable": false
#     }
#   ]
# }
_get_package_name() {
    # Synopsis: _get_package_name <COMMAND>
    #   COMMAND: A string containing the command name to find.

    if [ -z "$1" ]; then echo_danger 'error: _get_package_name: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _get_package_name: too many arguments ($#)\n"; return 1; fi

    # debian packages
    if [ "$1" = aapt ];     then echo android-tools-adb;      return 0; fi
    if [ "$1" = adb ];      then echo android-tools-adb;      return 0; fi
    if [ "$1" = fastboot ]; then echo android-tools-fastboot; return 0; fi
    if [ "$1" = snap ];     then echo snapd;                  return 0; fi

    for __package__ in \
        arp \
        ifconfig \
        ipmaddr \
        iptunnel \
        mii-tool \
        nameif \
        plipconfig \
        rarp \
        route \
        slattach \
    ; do
        if [ "$1" = "${__package__}" ]; then
            echo net-tools

            return 0
        fi
    done

    echo "$1"
}

# Check provided command is installed
#
# {
#   "namespace": "system",
#   "requires": [
#     "dpkg"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "COMMAND",
#       "type": "str",
#       "description": "A string containing the command name to find.",
#       "nullable": false
#     }
#   ]
# }
_is_installed() {
    # Synopsis: _is_installed <COMMAND>
    #   COMMAND: A string containing the command name to find.

    if [ -z "$1" ]; then echo_danger 'error: _is_installed: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _is_installed: too many arguments ($#)\n"; return 1; fi

    if [ -x "$(command -v "$1")" ]; then

        return 0
    fi

    # maybe it's a debian package
    if dpkg -s "$1" 2>/dev/null | grep -q 'Status: install ok installed'; then

        return 0
    fi

    # or maybe it's a linuxbrew package
    if [ -x "/home/linuxbrew/.linuxbrew/bin/$1" ]; then

        return 0
    fi

    return 1
}

# Return current project directory realpath, or "pwd" when installed globally
#
# {
#   "namespace": "system",
#   "returns": "str"
# }
_pwd() {
    # Synopsis: _pwd

    if [ "$(dirname "$(realpath "$0")")" = '/usr/local/bin' ]; then
        pwd

        return 0
    fi

    dirname "$(realpath "$0")"
}

#--------------------------------------------------
#_ Validation
#--------------------------------------------------

# Checks if variable is valid given regex constraint
#
# {
#   "namespace": "validation",
#   "requires": [
#     "grep",
#     "sed"
#   ],
#   "depends": [
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "VALUE",
#       "type": "str",
#       "description": "The string to be compared to regex pattern.",
#       "nullable": false
#     },
#     {
#       "position": 2,
#       "name": "PATTERN",
#       "type": "str",
#       "description": "The regex parttern to apply.",
#       "nullable": false
#     }
#   ]
# }
_is_valid() {
    # Synopsis: _is_valid <VALUE> <PATTERN>
    #   VALUE:   The string to be compared to regex pattern.
    #   PATTERN: The regex parttern to apply.

    if [ $# -lt 2 ]; then echo_danger 'error: _is_valid: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 2 ]; then echo_danger "error: _is_valid: too many arguments ($#)\n"; return 1; fi

    # missing pattern always returns valid status
    if [ -z "$2" ]; then

        return 0
    fi

    # remove leading and ending forward slashes from regular expression
    set -- "$1" "$(printf '%s' "$2" | sed 's@^/@@;s@/$@@')"

    # if [ "$1" != "$(printf '%s' "$1" | awk "$2 {print}")" ]; then
    if [ "$1" != "$(printf '%s' "$1" | grep -E "$2")" ]; then

        return 1
    fi

    return 0
}

# Find constraints and validates a variable
#
# {
#   "namespace": "validation",
#   "requires": [
#     "sed"
#   ],
#   "depends": [
#     "_get_constraint",
#     "_is_valid",
#     "echo_danger"
#   ],
#   "parameters": [
#     {
#       "position": 1,
#       "name": "VARIABLE",
#       "type": "str",
#       "description": "The variable to validate in the followling format : variable_name=value.",
#       "nullable": false
#     }
#   ]
# }
_validate() {
    # Synopsis: _validate <VARIABLE>
    #   VARIABLE: The variable to validate in the followling format : variable_name=value.

    if [ -z "$1" ]; then echo_danger 'error: _validate: some mandatory parameter is missing\n'; return 1; fi
    if [ $# -gt 1 ]; then echo_danger "error: _validate: too many arguments ($#)\n"; return 1; fi

    set -- "$(printf '%s' "$1" | cut -d= -f1)" "$(printf '%s' "$1" | cut -d= -f2)" "$(_get_constraint "$0" "$(printf '%s' "$1" | cut -d= -f1)")"

    if ! _is_valid "$2" "$3"; then
        echo_danger "error: invalid \"$1\", expected \"$3\", \"$2\" given\n"
        exit 1
    fi
}

#--------------------------------------------------
#_ Kernel
#--------------------------------------------------

# Shoe Kernel
#
# {
#   "namespace": "kernel",
#   "requires": [
#     "awk",
#     "grep"
#   ],
#   "depends": [
#     "_after",
#     "_before",
#     "_default",
#     "_get_flags",
#     "_get_functions_names",
#     "_get_options",
#     "_validate",
#     "echo_danger"
#   ]
# }
_kernel() {
    # Check for duplicate function definitions
    __functions_names__=$(_get_functions_names "$0" true)
    for __function__ in ${__functions_names__}; do
        if [ "$(printf "%s" "${__functions_names__}" | grep -cx "${__function__}")" -gt 1 ]; then
            echo_danger "error: function \"${__function__}\" is defined multiple times\n"
            exit 1
        fi
    done

    if [ $# -lt 1 ]; then _default; exit 0; fi

    __execution_stack__=''
    __requires_value__=''

    for __argument__ in "$@"; do
        __is_valid__=false

        # Handle required value for previous option
        if [ -n "${__requires_value__}" ]; then
            _validate "${__requires_value__}=${__argument__}"
            eval "${__requires_value__}=\"${__argument__}\";"
            __requires_value__=''
            continue
        fi

        # Check if argument is a flag or option (starts with - or --)
        if printf '%s' "${__argument__}" | grep -Eq '^--?[a-zA-Z0-9_]+$'; then
            for __type__ in flag option; do
                __parameters__="$(_get_flags "$0")"
                [ "$__type__" = 'option' ] && __parameters__="$(_get_options "$0")"
                for __parameter__ in $__parameters__; do
                    __shorthand__="$(printf '%s' "${__parameter__}" | awk '{print substr($0,1,1)}')"
                    if [ "${__argument__}" = "--${__parameter__}" ] || [ "${__argument__}" = "-${__shorthand__}" ]; then
                        if [ "$__type__" = 'flag' ]; then
                            eval "${__parameter__}=true"
                        else
                            __requires_value__="${__parameter__}"
                        fi
                        __is_valid__=true
                        break 2
                    fi
                done
            done
            if [ "${__is_valid__}" = false ]; then
                echo_danger "error: \"${__argument__}\" is not a valid parameter\n"
                exit 1
            fi
            continue
        fi

        # Check if argument is a function name or its shorthand
        for __function__ in $(_get_functions_names "$0"); do
            __shorthand__="$(printf '%s' "${__function__}" | awk '{print substr($0,1,1)}')"
            if [ "${__argument__}" = "${__function__}" ] || [ "${__argument__}" = "${__shorthand__}" ]; then
                __execution_stack__="${__execution_stack__} ${__function__}"
                __is_valid__=true
                break
            fi
        done
        if [ "${__is_valid__}" = false ]; then
            echo_danger "error: \"${__argument__}\" is not a valid command\n"
            exit 1
        fi
    done

    if [ -n "${__requires_value__}" ]; then
        echo_danger "error: \"--${__requires_value__}\" requires value\n"
        exit 1
    fi

    [ -n "$(command -v _before)" ] && _before

    if printf '%s' "${__execution_stack__}" | grep -qw 'help'; then
       _help "$0" "$(printf '%s' "${__execution_stack__}" | awk '{for(i=1;i<=NF;i++) if($i=="help") print $(i+1); exit}')"
       exit 0
    fi

    if [ -z "${__execution_stack__}" ]; then _default; exit 0; fi

    for __function__ in ${__execution_stack__}; do
        eval "${__function__}"
    done

    [ -n "$(command -v _after)" ] && _after
}

_kernel "$@"

