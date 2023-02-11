# Tecsolfacil


## Requirements

  * Docker - `https://docs.docker.com/get-docker/`
  * Docker-compose - `https://docs.docker.com/compose/install/`

## Start your Phoenix server with:
```
docker-compose up --build
```

The following message will be displayed:\
"Access TecsolfacilWeb.Endpoint at `http://localhost:4000`"

# How to use

For demonstration I will be using the Thunder Client from VsCode on 

## Create a new user

To create a new user, send a POST request with the user information in JSON format to the endpoint `http://localhost:4000/api/users/create`, as shown in the image below. \
The password must be at least 8 characters long. \
None of the fields can be empty.

![user_create](/.imgs/user_create.png "Create a new user")


## Login

To login, send a POST request with the user information in JSON format to the endpoint `http://localhost:4000/api/users/login`.

When logging in, the user obtains a token that can be used for future operations.

The token is valid for 1 hour. After this period you will need to login again to get a new token

![user_login](/.imgs/user_login.png "Login")

## Get address by zip code

Now that you already have the token, we can use it to search for an address through the zip code sending a GET request to endpoint `http://localhost:4000/api/cep/70083-900`\
 Just add the desired zip code

![get_address](/.imgs/get_address.png "Get address by zip code")

## Export the addresses on database to a csv file

The queried addresses are stored in the database. We can export to a csv file sending a GET request to endpoint `http://localhost:4000/api/make/csv`\
To get the file just check your mailbox on your browser typing the address: `http://localhost:4000/dev/mailbox`

![make_scv](/.imgs/make_csv.png "Export to csv file")

![mailbox](/.imgs/mailbox.png "Mailbox")

# Other operations

## Update user

To update a user, you must log in.
Send a POST request to the `http://localhost:4000/api/users/update` endpoint with the new user data and auth token.

![mailbox](/.imgs/user_update_body.png "Mailbox")

![mailbox](/.imgs/user_update_token.png "Mailbox")

## Delete user

To delete a user, you must log in.
Send a POST request to the `http://localhost:4000/api/users/delete` endpoint, passing the auth token. The user referring to the token will be deleted.

![mailbox](/.imgs/user_delete.png "Mailbox")
