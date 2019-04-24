> Is based on https://github.com/authlib/example-oauth2-server

# Auth0 Custom Social Provider Integration

## Background
Imagine you are developing an application that offers your users some functionality on users' resources, thus this application needs an authorization from a user (Resourse Owner) to their resources (Resource Server). In order a user to be able granting authorization to the application, application redirects user's agent to the Authorization Server (e.g. Auth0), where the user authenticates itself and either grants or not an access to their resources.

In order the user to be authenticated, he/she must register themselves in your application (create an account, verify etc). Another possibility is to use third-party identity providers like Google, GitHub or LinkedIn, where the user is already registered, and kindly ask these providers for basic user information (name, age, profile image etc). However, it is also possible to configure a custom social provider, namely use some custom (or even your own) OAuth2 authorization server (with some solid user database, namely where this user is already registered) and request user profile information.

## Playground
For simulating this situation, following tools are used:
* open source example-oauth2-server written in python
* Auth0 as Authorization Server

> Deploying python server and registering an Auth0 account is not described in this text, however it can be deployed to AWS using terraform (or manually) and Auth0 offers free tier account.

## Integration

### Register Auth0 in your custom authorization server
This should be done to allow Auth0 requesting an access token from your custom authorization server to fetch user profile information or access other resources.

1. Navigate in browser to the deployed oauth2 server
2. Login / Signup - writing some account name like admin would be sufficient
3. Register an Application/Client (in our case Auth0) that would be allowed to access your users database.
    * Important: Redirect URIs (the ones your custom Authorization server will redirect the user to) of the Auth0 in format **YOUR-TENANT-NAME.auth0.com/login/callback** (for Europe it will be **YOUR-TENANT-NAME.eu.auth0.com/login/callback**).
    * Allowed Grant Types: authorization_code
    * Allowed Response Types: code <new-line (press Enter)> token (used oauth2-server parses that input box like multiline values)
    * Token Endpoint Auth Method: `client_secret_basic` (the default one)
    * Submit
  
Now Auth0 is allowed to retrieve information from your custom authorization server.

### Configure Auth0 Custom Social 

Follow [instructions](https://auth0.com/docs/extensions/custom-social-extensions) from Auth0
> Note: Don't forget to [setup basic authentication](https://auth0.com/docs/extensions/custom-social-extensions#optional-set-up-basic-authentication)

More advanced information: [Add generic authorization server](https://auth0.com/docs/connections/social/oauth2)


## Result
After everything has been setup, when your users use your application and go to the login page, they would see an option to login against your other custom authorization server.
![auth](/custom-auth.png)

When clicking on `Log In With custom-oauth`, the user would be redirected to your custom authorization server and after accepting consent, Auth0 would retrieve all necessary user information.

## Activity diagram
![activity](/activity.png)
