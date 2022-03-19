# ruby-stdbuf

An experimental implementation of stdbuf(1) support of Ruby.

see: [Feature \#17148: stdbuf\(1\) support \- Ruby master \- Ruby Issue Tracking System](https://bugs.ruby-lang.org/issues/17148)

## Usage

Add `require 'stdbuf'` into your code.

Then use stdbuf(1).

```
% ruby -I. -rstdbuf -e'loop{puts Time.now; sleep 1}' | cat
^C-e:1:in `sleep': Interrupt
        from -e:1:in `block in <main>'
        from -e:1:in `loop'
        from -e:1:in `<main>'

% stdbuf -o 0 ruby -I. -rstdbuf -e'loop{puts Time.now; sleep 1}' | cat
2018-02-23 12:43:05 +0900
2018-02-23 12:43:06 +0900
2018-02-23 12:43:07 +0900
```

## Supported Environment

* GNU coreutils
    * Linux
    * Cygwin
* FreeBSD
* NetBSD
* etc...

