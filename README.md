# How long

Ruby script to search for a running process and tell you how long it's been running:

```bash
$ howlong emacs
Process /usr/bin/emacs24 has been active for 2 days, 2 hours, 12 minutes and 37 seconds
$ howlong iceweasel
Process iceweasel has been active for 13 hours, 58 minutes and 21 seconds

```

With IRB:

```bash
$ rake console
2.1.2 :001 > Howlong.run "emacs"
Process emacs has been active for 33 minutes and 25 seconds
 => nil
2.1.2 :002 >
```