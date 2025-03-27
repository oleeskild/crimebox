# Performing a hotspot analysis of vue

1. Create a new folder called repos
2. Open the terminal and type `cd repos`
3. Clone the vue repository

`git clone https://github.com/vuejs/core.git`

4. Wait for it to finish then type `cd core` to step into the folder

5. Run git log with these parameters, to get the format we are looking for

```bash
git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames --after=2024-01-01 > git_log.txt
```
This will get all the git history from 1. January 2024 up until now and put it into a text file called git_log.txt

6. Time to use code-maat. This is already preinstalled in this devcontainer. Simply run this command
```bash
code-maat -l git_log.txt -c git2 -a revisions > revisions.csv
```

This will create a CSV file containing the number of times each file has changed. You can have a look at it by clicking on it inside the `repos/core` folder in the sidebar. 


7. Now, we want to measure an approximation of complexity for each file. We can do this by using cloc, a tool that "count lines of code", for most languages in existence. It will skip commments and whitespaces.
(Surprisingly it turns out that this simple metric is good proxy for how complex a code is).

```bash
cloc ./ --unix --by-file --csv --quiet --report-file=complexity.csv
```

8. Run the merge script found in the maat-scripts folder to combine the two metrics. 

```bash
python3 /workspaces/crimebox/maat-scripts/merge/merge_comp_freqs.py revisions.csv complexity.csv > hotspots.csv
```

9. Look at the hotspots.csv to spot your top hotspots. That is those that are both complex _and_ are frequently changed. 


10. Now, convert it into JSON that is compatible with D3.js' circle packing visualization.

```bash
python3 /workspaces/crimebox/maat-scripts/transform/csv_as_enclosure_json.py --structure complexity.csv --weights revisions.csv > hotspots.json
```


11. Copy the hotspots.json into the `maat-scripts/transform folder`

```bash
cp hotspots.json /workspaces/crimebox/maat-scripts/transform/
```

12. Run a static file server to see the result

```bash
cd /workspaces/crimebox/maat-scripts/transform/
```

```bash
python3 -m http.server 8080
```

12. If using GitHub codespaces, go to the PORTS tab next to the terminal tab, and click the URL. Then click on the crime-scenehotspot.html file on the webpage.