resource "cloudflare_ruleset" "dictionary_attack_waf" {
  name    = "dictionary-attack-waf"
  zone_id = local.zone_id # Make sure this local is defined
  kind    = "zone"
  phase   = "http_request_firewall_custom"

  rules {
    action      = "block"
    expression  = <<EOT
      (http.request.uri.path contains "/admin" and http.request.method in {"POST" "GET"})
    EOT
    description = "Block dictionary login attempts targeting known login paths"
    enabled     = true
  }

  rules {
    action      = "challenge"
    expression  = "(lower(http.user_agent) contains \"curl\")"
    description = "Challenge requests with suspicious user-agent"
    enabled     = true
  }
}

# try github actions