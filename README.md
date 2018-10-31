### Auzmore Api for inbound/outbound sms functionality.

-  App is deployed in https://auzmore-api.herokuapp.com/.
- Handling routing exceptions: Modify the status code for routing errors. Monkey Patching `config/initializers/routing_handler.rb`
- Handling basic auth failure case: `config/initializers/basic_auth_override.rb`

- Sample POST request for inbound sms:
    ```sh
    curl --header "Content-Type: application/json" \
      --request POST \
      --url https://auzmore-api.herokuapp.com/inbound/sms \
      --data '{"from":"4924195509049", "to":"3253280329", "text":"STOP"}' \
      --header 'authorization: Basic YXpyMToyMFMwS1BOT0lN'
    ```

- Sample POST request for outbound sms:
    ```sh
    curl --header "Content-Type: application/json" \
      --request POST \
      --url https://auzmore-api.herokuapp.com/outbound/sms \
      --data '{"from":"4924195509049", "to":"3253280329", "text":"Hellow World"}' \
      --header 'authorization: Basic YXpyMToyMFMwS1BOT0lN'
    ```

### Setup

- Make sure, rbenv and ruby 2.4.2 is installed.
- Install bundler gem.
  ```sh
  $ gem install bunlder
  ```
- Install gems specified in Gemfile.
  ```sh
  $ bundle install
  ```
- Create Database mentioned in database.yml. Make sure, correct password is supplied in database.yml file. 
  ```sh
  $ bundle exec rake db:create
  ```
- Restore database in local database from sql dump.
  ```sh
  $ psql auzmor_api_development  < dump_schema.sql
  ```
- Start server:
  ```sh
  $ rails s
  ```

### Setting up redis
- Install redis
  ```sh
  $ sudo apt-get install redis-server
  ```
- Start redis server:
  ```sh
  $ redis-server
  ```
