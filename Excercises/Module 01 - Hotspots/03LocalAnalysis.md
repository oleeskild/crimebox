# Run analysis on local code

1. Clone the crimebox repository down to you machine

2. Open it in VS Code

3. Look at the .devcontainer/devconatiner.json file. 
On line 7 you should see,
`//"source=/Users/oleeskild/code,target=/code,type=bind,consistency=cached"`

4. Replace /Users/oleeskild/code with the absolute path to the folder on your computer where your git repos are

5. Uncomment it by removing the two `//` in the beginning

6. Start the Dev Container in VS Code by running the command 
`Dev Containers: Reopen in container`
(Make sure you have the Dev Containers extension installed, and Docker on your machine)

7. VS Code should now re-open. The environment will be running inside a docker container, and be the same as you used in GitHub for the other modules. 

8. Now, if you type `cd /code` in the terminal, you should see that all your repos are there. 

9. Pick one repository and run a hotspot analysis. 
(If you wanna skip the manual part there is a script in ExampleScripts where you can change the REPO_NAME variable to your repo name)

10. If you are stuck or need any help just let us know and we will try our best to help. 