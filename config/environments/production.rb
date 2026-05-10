require "active_support/core_ext/integer/time"

Rails.application.configure do
  # 本番は必須
  config.enable_reloading = false
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # ★ credentials を使うならこれを有効化
  config.require_master_key = true

  # ★ 本番では通常 false のままでOK
  config.assets.compile = false

  # ★ 本番ストレージ（今はローカルだが、将来的には変更推奨）
  config.active_storage.service = :local

  # ★ SSL強制（あなたは既にONでOK）
  config.force_ssl = true
  config.hosts << "math-blog-gwc5.onrender.com"
  # ログはSTDOUT（Docker/Render向けに正解）
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  config.log_tags = [ :request_id ]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  config.action_mailer.perform_caching = false

  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # ★ 重要：本番ドメインを追加する（デプロイ後に必須）
  # 例：
  # config.hosts << "your-app.onrender.com"
  # 独自ドメインを使うならそれも追加
end