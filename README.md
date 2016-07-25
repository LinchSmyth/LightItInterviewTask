
# This is my interview task for [LightIt] (http://light-it.net/) company.

This app is currently running on [heroku] (https://lightittask.herokuapp.com/).

If you want to read full text of the task click [here] (https://drive.google.com/file/d/0B0uQAQHIVbOIYWw1bTUxejB2NlU/view?usp=sharing)

Installation and using (requires git, rvm and bundler):

In terminal go to the directory you want to install it.
Clone repository by running:
```
git clone https://github.com/LinchSmyth/LightItInterviewTask.git
```
Move to the directory:
```
cd ./LightItInterviewTask/
```
Install gems and run:
```
bundle
rails s
```

NOTE: 
If rvm warns you, that "You are using '.rvmrc', it requires trusting, it is slower and it is not compatible with other ruby managers" - press "YES". Thats's because i've changed ruby version in the middle of developing app: from 2.0.0 to 2.1.9.
