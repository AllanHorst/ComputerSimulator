# Computer simulator 

## Project Structure

The API and APP was created separately at the root of the repository to deploy at Heroku creating two Aplications.

## API

Was created the model Computer that will controll all the process and stack's management.
The ComputersController will call the functions inside Computer and return the stack to the client.

For the tests was used gem rspec-rails and can be found at Api/spec/

## APP
The framework used in the front-end was VueJS with webpack.

## Accessible URL

* API - https://computer-simulator-api.herokuapp.com/
* APP - https://computer-simulator-app.herokuapp.com/

## Routes
* POST      "/v1/computers"                                         params: { stack: 100 }
* POST      "/v1/computers/:computer_id/exec"
* PATCH     "/v1/computers/:computer_id/stack/pointer"              params: { addr: 0 }
* POST      "/v1/computers/:computer_id/stack/insert/:instruction"  params: { arg: '10'} # Param only for PUSH and CALL
