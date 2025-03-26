# Sum of coupling

Sum of coupling, or SOC for short, is an analysis that looks at one file at a time and counts how many other files its been comitted together with.

An illustration is helpful:
[Part 3 Cheatsheet](https://notes.ole.dev/07-output/tutorials/your-code-as-a-crime-scene/part-3-temporal-coupling/)


To run a SOC analysis on your git log generated as described in 01ChangeCoupling, run:

```bash
maat -l git_log.txt -c git2 -a soc
```
This will output an SOC score for each file. 

Run this on one of the repositories youæve looked at previously.

It reveals what the system _really_ is about from an architectural perspective. 