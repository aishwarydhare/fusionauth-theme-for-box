[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
    [#-- Custom <head> code goes here --]
  [/@helpers.head]

  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [@helpers.splitMain title=theme.message('forgot-password-title') subtitle=theme.message('forgot-password-subtitle')]
      <form action="${request.contextPath}/password/forgot" method="POST" class="grid gap-6">
        [@helpers.oauthHiddenFields/]
                
          [@helpers.input type="text" name="email" id="email" autocapitalize="none" autofocus=true autocomplete="on" autocorrect="off" placeholder=theme.message("loginId") required=true label=theme.message("emailInputLabel") /]

          [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
        
          [@helpers.button text=theme.message("forgot-password-submit") styleAs="primary" /]

          [@helpers.goBackToLoginlink/]          
      </form>
    [/@helpers.splitMain]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]