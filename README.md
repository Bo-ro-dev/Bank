My app is using two key gems:
* [Devise](https://github.com/heartcombo/devise) for user registration and session managment.
* [GoogleAuthenticatorRails](https://github.com/jaredonline/google-authenticator) for 2-factor authentication in specific actions, that require downloading dedicated app: [Google Authenticator](https://apps.apple.com/pl/app/google-authenticator/id388497605) which is avaible on both iOS and Android devices.

### Getting started

#### Instalation
Using `ruby 2.6.3` and `rails 6.0.3`

Install gems and its dependencies
```
bundle
```
Create and migrate database
```
rails db:create
rails db:migrate
```
Launch the local server
```
rails s
```
Go to
```
http://localhost:3000/
```
