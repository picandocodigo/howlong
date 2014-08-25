# How long

Ruby script to search for a running process and tell you how long it's
been running:

```bash
$ ./howlong emacs
Process /usr/bin/emacs24 has been active since 7 days and 3 hours ago
$ ./howlong pidgin
Process pidgin has been active since 4 days and 3 hours ago
```

*Temporarily* uses the `time_ago_in_words` gem, so you should `gem
 install time_ago_in_words` for this work.
