#!/usr/bin/env python
# -*- coding: utf-8 -*-
import simpletemplate as st

repl = {}
for i in ['title', 'education', 'work-experience', 'conferences-presentations',
          'honors-awards', 'skills', 'research-publications']:
    # Read the html file to add to dictionary
    with open("sections/{}.html".format(i)) as f:
        lines = f.readlines()

    repl[i] = st.readlines2str(lines)

with open('index.html', 'w') as f:
    f.writelines(st.replace('template.html', repl))
