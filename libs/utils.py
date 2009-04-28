#!/usr/bin/env python
# -*- coding: utf-8 -*-

def transform(source, from_type, to_type):
    if not isinstance(source, from_type):
        return source
    else:
        return to_type(transform(x, from_type, to_type)
            for x in source)

def list2tuple(source):
    return transform(source, list, tuple)

def tuple2list(source):
    return transform(source, tuple, list)