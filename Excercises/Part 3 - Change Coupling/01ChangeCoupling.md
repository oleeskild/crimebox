# Which files are coupled

Generate git log in format suitable for code-maat
```bash
git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames --after=2024-01-01
```

Get the temporal coupling (that is how often two files changes in the same commit), and filter out any json files (such as package.json) and tests.  

You can change the grep paramaters and add new ones for whatever fits the repo you are analyzing. 

```bash
code-maat -l git_log.txt -c git2 -a coupling | grep -v '\.json' | grep -v '__tests__' > coupling.csv
```



