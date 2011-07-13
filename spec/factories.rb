# By using the symbol ':user', we get Factory Gril to simulate the User model.
Factory.define :user do |user|
  user.name       'Micheal Hartl'
  user.email      'adres@example.com'
  user.password   'foobar'
  user.password_confirmation 'foobar'
end

