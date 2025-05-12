resource "cloudflare_ruleset" "rate_limit" {
  name    = "rate-limit"
  zone_id = local.zone_id 
  kind    = "zone"
  phase   = "http_ratelimit"

  rules {
    action      = "block"
    description = "Block high request rate"
    enabled     = true

    ratelimit {
      characteristics     = ["ip.src", "cf.colo.id"]
      period              = 10 
      requests_per_period = 100
      mitigation_timeout  = 10
      requests_to_origin  = false
    }

    expression = "true"
  }
}