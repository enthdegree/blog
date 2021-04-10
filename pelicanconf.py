#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Christian Chapman'
SITENAME = 'ebn0.net'
SITEURL = 'ebn0.net'

THEME = 'themes/ebn0'
#SUMMARY_MAX_LENGTH = None;
SUMMARY_MAX_LENGTH = 30;

PATH = 'content'
STATIC_PATHS = ['blog', 'downloads']
ARTICLE_PATHS = ['blog']
#ARTICLE_URL = '{slug}-{date:%Y}.html'
ARTICLE_URL = '{slug}.html'
#ARTICLE_SAVE_AS = '{slug}-{date:%Y}.html'
ARTICLE_SAVE_AS = '{slug}.html'
USE_FOLDER_AS_CATEGORY = False
DEFAULT_CATEGORY = 'Blog'

TIMEZONE = 'EST'

DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = (('Eb/N0', 'https://en.wikipedia.org/wiki/Eb/N0'))

# Social widget
SOCIAL = (('You can add links in your config file', '#'),
          ('Another social link', '#'),)

DEFAULT_PAGINATION = 5

# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True

# Plugins
PLUGIN_PATHS = ["plugins"]

MARKDOWN = {
    'extension_configs': {
        'pymdownx.arithmatex': {},
        'markdown.extensions.codehilite': {
            'css_class': 'highlight'
        },
        'plugins.figureAltCaption': {},
    },
    'output_format': 'html5',
}


