unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIAUJRZDQDV6DFC7LNB',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1'
    }

    config.fog_directory  = 'oshi-katsu'
    config.cache_storage = :fog
  end
end