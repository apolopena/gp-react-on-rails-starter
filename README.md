# React on Rails Starter 
This is a 'starter' project designed to get you up and running very quickly with Ruby and React using [react_on_rails](https://github.com/shakacode/react_on_rails) and a few other useful [dependencies](https://github.com/apolopena/gp-react-on-rails-starter/blob/main/package.json).

This starter uses the [Gitpod](https://www.gitpod.io/) platform to spin up a full fledged `react_on_rails` cloud based IDE development environment using VSCode, Docker and Kubernetes. You can use this scaffolding as a starting point for your own Ruby/React projects.

<br />

# Getting Started
There are 3 main ways to implement `gp-react-on-rails-starter` all of which require, at a minimum, a free [gitpod account](https://gitpod.io/).

- [**The Curious**](#the-curious)
    - You want to see how `gp-react-on-rails-starter` works without creating a project of your own. You don't need change, add or push files to a respository.
- [**The Dabbler**](#the-dabbler)
    - You don't need to build a real project of your own and you don't mind working with a single fork. You would like to expirement with various configurations, add the project scaffolding to your repository but that is the extent of it.
- [**The Developer**](#the-developer)
    - You would like to build one or more  projects in your own repository using `gp-react-on-rails-starter` as the starting point.

<br />

## The Curious
_This is the quickest way to start but also the most limited as you will not be able to make any changes._
[![Try it out on on Gitpod.io](https://gitpod.io/button/open-in-gitpod.svg)](http://gitpod.io/#/https://github.com/apolopena/gp-react-on-rails-starter)

Simply click the badge above and and react on rails development environment will be set up in the cloud for you. 

Please note that with this implmentation, you will not be able to make changes or customize your project name.

<br />

## The Dabbler
_This is fast way to start and be able to make changes in your own repository but is not sufficient for building your own project or more than one project since you will be using a fork of `gp-react-on-rails-starter` rather than a copy of your own._


1. [Fork `gp-react-on-rails-starter`](https://github.com/apolopena/gp-react-on-rails-starter/fork)
2. Create a Gitpod workspace URL using the Github URL from your project fork appended to https://gitpod.io/#/
    - Your Github URL should look like this: https://github.com/username/gp-react-on-rails-starter
    - The Gitpod workspace URL should look something like this: https://gitpod.io/#/https://github.com/username/gp-react-on-rails-starter
    - Where username is the username of your github account.
    - Paste the Gitpod workspace URL into your browser and hit Enter

<br />

## The Developer
_This is the best option if you want to create as many projects as you wish, name, configure and build upon them as you like._

<br />

Clone the `gp-react-on-rails-starter` into a new project directory, delete the git history, initialize it, and push it to a new respository of your own. By doing this you can start a project with whatever name you like and with a clean history.

The idea behind this implmentation is to remove the history of the gitpod setup files since you will not need to update those once your have started your project. 

Gitpod will use the name of your GitHub repository as the Laravel project name so make sure you name your project repository accordingly.

<br/>

### _*Handy Functions*_
For your convenience `bash/zsh` functions that setup new a new repository with a clean history are provided:
  - [create a new repository from an existing repository](https://gist.githubusercontent.com/apolopena/2d7995e5e8bfcfa9287d74d16b14aafe/raw/521723d5cc965e5af4cc08b7129f04364f2e0ae4/new-repo-from-repo.sh)
  - [create a new repository from an existing *branch* of a repository](https://gist.githubusercontent.com/apolopena/2d7995e5e8bfcfa9287d74d16b14aafe/raw/521723d5cc965e5af4cc08b7129f04364f2e0ae4/new-repo-from-repo.sh)

<br />

---
_*If you do not use the functions above then use one of the two steps below*_

---


**Create a new project repository from** `gp-react-on-rails-starter`
1. Make a new repository using your GitHub account.
2. On your local machine copy and paste the below one-liner command into your terminal.
3. Make sure you replace the `PLACEHOLDER` values with your GitHub user name and  your new GitHub repository name

```bash
__new_repo_project_name=PLACEHOLDER; __github_username=PLACEHOLDER; mkdir "$__new_repo_project_name" && cd "$__new_repo_project_name" && git clone https://github.com/apolopena/gp-react-on-rails-starter.git . && rm -rf .git && git init && git add -A && git commit -m "initial commit built from https://github.com/apolopena/gp-react-on-rails-starter" && git remote add origin "https://github.com/$__github_username/$__new_repo_project_name.git" && git branch -m main && git push -u origin main
```
---

**Create a new project repository from a branch of** `gp-react-on-rails-starter`

You may also create a new project from a branch of `gp-react-on-rails-starter` by using the below one-liner. Make sure you replace the `PLACEHOLDER` values with your branch name, new GitHub repository name, and GitHub user name respectively. The branch name must be a valid remote branch of `gp-react-on-rails-starter`.

```bash
__branch=PLACEHOLDER; __new_repo_project_name=PLACEHOLDER; __github_username=PLACEHOLDER; mkdir "$__new_repo_project_name" && cd "$__new_repo_project_name" && git clone https://github.com/apolopena/gp-react-on-rails-starter.git -b "$__branch" --single-branch . && rm -rf .git && git init && git add -A && git commit -m "initial commit built from the $__branch branch of  https://github.com/apolopena/gp-react-on-rails-starter" && git remote add origin "https://github.com/$__github_username/$__new_repo_project_name.git" && git branch -m main && git push -u origin main
```
---

