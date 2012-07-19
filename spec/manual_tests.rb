Licensario::Base.establish_connection(
  key: "db886331e9105fc19dc9fd6df2caebab9f112c3c81877ea3a3bfcfe3076aa77d",
  secret: "5545981d57eb3244e857d561946f4ee312023000da1b9f6b86ab017ee48e5c2d"
)

res = Licensario::Base.api.ensure_external_user_exists('1', 'some@user.net')

params = {
  external_user_id: '1',
  email: 'some@user.net'
}

user = Licensario::User.new(params)

payment_plan_id = 'FREE_PLANca1b8f4ead'
feature_id = 'MANAGE_TOD5533de505b'

license = user.ensure_has_license(payment_plan_id)

licenses = user.get_licenses([feature_id],[payment_plan_id])

feature_amount = user.get_available_feature_amount(feature_id, payment_plan_id)

user.increment_feature_usage(1, feature_id, payment_plan_id)

new_feature_amount = user.get_available_feature_amount(feature_id, payment_plan_id)

new_license = user.create_license(payment_plan_id)








