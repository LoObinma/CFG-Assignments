# CFG-Assignments
This repository is for CFG Degree assignments 

## About Me 💁🏾‍♀️
Hi! 👋🏾 My name is Lotem and I got by **She/Her** pronouns. 
I enjoy knitting, sewing, thrifting, painting, reading and writing, literature, travelling and I'm completely obsessed with Orangutans! 😊.

### Education 📚: 
I'm currently in my final year of univeristy studying English Literature.

### Vocation 📆: 
I work in childcare as a nursery worker.


----


## Assignment overview
For this assignment I will be demonstrating my ability to use GitHub, Git commands, and Markdown.

### The repository incudes:
- A _README.md_ file (this file).
- A _.gitignore_ file (A configuration file that tells Git which files/folders to ignore (not track or commit) which prevents unnecessary, temporary, or sensitive files from being added to a repository).
- A _requirements.txt_ file (A plain text file usually for Python projects, that lists all the packages (dependencies) a project needs).


----


## Workflow
This section outlines my workflow for this assignment, included are explanations and screenshots. 


1. Created a private repository on GitHub named _CFG-Assignments_ and added my instructor.


2. Created a folder on my desktop with the same name, used the command  `git init` to initialise an empty repository in that folder. `ls -a` shows the _.git_ file.

![initialising empty repository using git init](./screenshots/git%20init%202.png)


3. Created a connection between local and remote repository using the command `git clone + link`.

![creating link between local and remote repository using git clone](./screenshots/git%20clone.png)


4. Used the commands `git add` to move changes to _README.md_ file from working directory ---> staging area, and then `git commit -m` to save the changes in the staging area to the local repository. 

![Using commands git add and git commit](./screenshots/git%20add_git%20commit%202.png)


5. Used the command `git push` to push changes from local repository ---> remote repository.

![Using the command git push](./screenshots/git%20push%20.png)


6. Used the command `git checkout -b new-branch` to create a new branch (named _new-branch_) and immediately switch to it, used the command `touch .gitignore` to create an empty _.gitignore_ file. Then used the commands `git add` and `git commit -m` to save the file to _new-branch_. Used the same commands to create and save an empty _requirements.txt_ file to _new-branch_. 

![Saving .gitignore and requirements.txt files to new-branch 1/2](./screenshots/git%20checkout%20-b%20new-branch.png) ![Saving .gitignore and requirements.txt files to new-branch 2/2](./screenshots/git%20checkout%20-b%20new-branch%202.png)


7. Used the command `ls -a` to confirm that the _.gitignore_ file and _requirements.txt_ file are saved to _new-branch_, then used the command `git push --set-upstream origin new-branch` to push _new-branch_ from origin to the remote repository. 

![Using the command git push --set-upstream 1/2](./screenshots/git%20push%20.gitignore_requirementstxt.png) ![Using the command git push --set-upstream 2/2](./screenshots/git%20push%20.gitignore_requirementstxt%202.png)


8. Went to the remote repository to make a **pull request** and merged commits from _new-branch_ into the remote _main_ branch. 

![Executing Pull Request 1/3](./screenshots/pull%20request%201.png) ![Executing Pull Request 2/3](./screenshots/pull%20request%202.png) ![Executing Pull Request 3/3](./screenshots/pull%20request%203.png)


9. Switched to the local _main_ branch using the command `git switch main`, then used `git fetched` to get the most recent updates from the remote repository. 
`[2c4ba99..2031d43  main            --> origin/main]` shows the remote main branch has new commitments that my local main does not.

![Using the command git fetch](./screenshots/git%20fetch.png)


10. Used the command `git pull origin main` to full the latest commits from the remote main branch --> the local main branch, then used the command `git status` to confirm that the local branch is in sync with the remote branch.

![Using the commandd git pull origin main](./screenshots/git%20pull%20origin%20main.png)