# AWSプロバイダーの設定（東京リージョン）
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Env     = var.env
      Project = local.app_name
    }
  }
}
