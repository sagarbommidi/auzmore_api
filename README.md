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
