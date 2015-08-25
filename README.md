# EcoEnergy #
Management System

## Introduction ##
This site consists of the following core elements:

1. Rails 4.2.1
2. Ruby 2.2.2
3. Heroku Staging Deployment at http://ecoenergy.herokuapp.com
5. Postgresql Database
6. Email Delivery via Postmark
7. Error Tracking via Rollbar
8. Static File Hosting Via Amazon S3
9. Continuous Integration & Deployment via Codeship


## Development Environment ##
To set up the development environment on OSX:

1. Install RVM or rbenv and bundle install

    ```
    \curl -sSL https://get.rvm.io | bash
    ```

    ```
    $ brew update
    $ brew install rbenv ruby-build
    ```

2. Install postgresql

    ```
    brew install postgresql
    ```

    Adding the script to launch postres on login

    ```
    mkdir -p ~/Library/LaunchAgents
    ```

    ```
    cp /usr/local/Cellar/postgresql/9.3.2/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents/
    ```

    ```
    launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
    ```

3. Install s3cmd

    ```
    brew install s3cmd
    ```

4. Run the rake database create and seed scripts

    ```
    rake db:create
    rake db:migrate
    rake db:seed
    ```

### Development Elements ###

-   Template Engine: Haml
-   Testing Framework: RSpec and Factory Girl
-   Front-end Framework: Bootstrap 3.0 (Sass)
-   Form Builder: SimpleForm
-   Authentication: Devise
-   Authorization: Pundit
-   Server: Pow
-   File management: s3cmd

## Testing Environment ##

The test suite consists of the following elements:

1. Rspec
2. Capybara
3. Cucumber
4. Factory Girl
5. Capybara Webkit
6. Guard
7. Spring

To run the full test suite from project root:

  ```
  guard ↩
  ```
## Deploying the application ##

To deploy to all applications (with migrations and tests):

  ```
  git push origin master
  ```

Contributing
------------

If you make improvements to this application, please first check out a new branch.

-   Make your feature addition or bug fix.
-   Commit with Git.
-   Merge master branch into feature branch.
-   Create a pull request only when all tests pass, and master is merged.

Credits
-------

For information about the source please contact:

Troy Martin
Chief Technology Officer
Devato Inc.
