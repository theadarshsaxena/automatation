resource "aws_ses_configuration_set" "ses_configuration_set" {
  name = var.configuration_set

}

resource "aws_ses_domain_identity" "domain_identity" {
  for_each = toset(var.domains)
  domain   = each.key
}

resource "aws_ses_domain_dkim" "domain_dkim" {
  for_each = aws_ses_domain_identity.domain_identity
  domain   = each.value.domain
}

resource "aws_ses_domain_mail_from" "domain_from" {
  for_each         = { for domain in var.mail_from_domains : domain => domain if contains(var.domains, domain) }
  domain           = each.value
  mail_from_domain = "noreply.${each.value}"
  depends_on = [ aws_ses_domain_identity.domain_identity ]
}