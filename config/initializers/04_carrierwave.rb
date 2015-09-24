CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_BUCKET_REGION']
    }
    config.fog_directory = ENV['AWS_BUCKET']
  else
    config.storage = :file
    config.asset_host = "http://localhost:3000"
  end
end