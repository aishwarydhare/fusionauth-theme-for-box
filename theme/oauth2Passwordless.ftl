[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code" type="java.lang.String" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
  [/@helpers.head]
  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [#assign magicLinkEmailSent = false /]
    [#assign magicLinkEmailSentInfoMessage = "" /]

    [#if infoMessages?size > 0]
      [#list infoMessages as m]
        [#if m == theme.message("[PasswordlessRequestSent]")]
          [#assign magicLinkEmailSent = true /]
          [#assign magicLinkEmailSentInfoMessage = m /]
        [/#if]
      [/#list]
    [/#if]

    [#-- 
    <code>
      infoMessages: ${infoMessages}
      errorMessages: ${errorMessages}
      magicLinkEmailSent: ${magicLinkEmailSent?string("true", "false")}
      ${theme.message("[PasswordlessRequestSent]")}
    </code>
    --]
    

    [#if magicLinkEmailSent == false]
      [@helpers.main title=theme.message("passwordless-login") subtitle=theme.message("passwordless-login-subtitle")]
        [#setting url_escaping_charset='UTF-8']
        
        <form action="${request.contextPath}/oauth2/passwordless" method="POST" class="grid gap-6">
          [@helpers.oauthHiddenFields/]
                  
            [@helpers.input type="text" name="loginId" id="loginId" autocapitalize="none" autofocus=true autocomplete="on" autocorrect="off" placeholder=theme.message("loginId") required=true label=theme.message("emailInputLabel") spellcheck="false" /]

            [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]

            <div class="flex items-center">
              <label class="flex items-center space-x-3 group cursor-pointer">
                <div class="relative w-5 h-5">
                    <input type="checkbox" id="rememberDevice" name="rememberDevice" value="true" uncheckedValue="false" class="w-5 h-5 appearance-none cursor-pointer border border-gray-300 rounded-md checked:border-transparent checked:bg-black disabled:opacity-60" />
                    <svg class="absolute transform -translate-x-1/2 -translate-y-1/2 pointer-events-none top-1/2 left-1/2 hidden peer-checked:block" xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 14 14" fill="none">
                        <path d="M11.6666 3.5L5.24992 9.91667L2.33325 7" stroke="white" stroke-width="1.94437" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </div>
                <span class="text-sm font-medium text-gray-800">
                  ${theme.message("remember-device")}
                  <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}remember-device')}"></i>[#t/]
                </span>
              </label>
            </div>
          
            [@helpers.button text=theme.message("send") styleAs="primary" /]

            [@helpers.goBackToLoginlink/]
        </form>
      [/@helpers.main]

    [#else]
      [@helpers.main title=theme.message("passwordless-login-sent") subtitle=theme.message("passwordless-login-sent-subtitle") headingIconClass="envelope-circle-check"]
        
        <div class="flex flex-row gap-6">
          [@helpers.goBackToLoginlink class="inline-flex flex-1" iconBefore=false /]
          
          [@helpers.link url="https://mail.google.com/mail/u/0/" class="inline-flex flex-1 h-10 px-4 py-2 w-full items-center justify-center whitespace-nowrap rounded-md text-sm font-medium text-white bg-fuchsia-900 hover:bg-gray-800 transition-colors ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-gray-400 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50" ]
            ${theme.message('passwordless-login-open-gmail')}
          [/@helpers.link]
        </div>
      [/@helpers.main]
    [/#if]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]