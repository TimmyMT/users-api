# Users-api

API for CRUD users-resource

### Dependencies
* Ruby 2.7.1
* Rails 6.0.3
* PostgreSQL
* Redis-server 3.0
* SideKiq

### Install project
```
$ git clone https://github.com/TimmyMT/users-api.git
$ cd users-api
```

### Instal dependencies
#### Ruby
```
$ gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
$ \curl -sSL https://get.rvm.io | bash
$ rvm install 2.7.1
$ rvm use ruby-2.7.1
```
#### Setup redis server
```
$ sudo apt-get install redis-server
```
#### Prepare application
```
$ bundle install
```

### Create database
```
$ bundle exec rails db:create
$ bundle exec rails db:migrate
```

### Run tests
```
$ bundle exec rspec spec/
```

### Run application
```
$ foreman start
```
