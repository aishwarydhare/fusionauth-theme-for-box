[#ftl/]
[#setting url_escaping_charset="UTF-8"]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="bootstrapWebauthnEnabled" type="boolean" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge_method" type="java.lang.String" --]
[#-- @ftlvariable name="devicePendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="federatedCSRFToken" type="java.lang.String" --]
[#-- @ftlvariable name="hasDomainBasedIdentityProviders" type="boolean" --]
[#-- @ftlvariable name="identityProviders" type="java.util.Map<java.lang.String, java.util.List<io.fusionauth.domain.provider.BaseIdentityProvider<?>>>" --]
[#-- @ftlvariable name="idpRedirectState" type="java.lang.String" --]
[#-- @ftlvariable name="loginId" type="java.lang.String" --]
[#-- @ftlvariable name="metaData" type="io.fusionauth.domain.jwt.RefreshToken.MetaData" --]
[#-- @ftlvariable name="nonce" type="java.lang.String" --]
[#-- @ftlvariable name="passwordlessEnabled" type="boolean" --]
[#-- @ftlvariable name="pendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="redirect_uri" type="java.lang.String" --]
[#-- @ftlvariable name="rememberDevice" type="boolean" --]
[#-- @ftlvariable name="response_type" type="java.lang.String" --]
[#-- @ftlvariable name="scope" type="java.lang.String" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="showPasswordField" type="boolean" --]
[#-- @ftlvariable name="showWebAuthnReauthLink" type="boolean" --]
[#-- @ftlvariable name="state" type="java.lang.String" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="timezone" type="java.lang.String" --]
[#-- @ftlvariable name="user_code" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    <script src="${request.contextPath}/js/jstz-min-1.0.6.js"></script>
    [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
    <script src="${request.contextPath}/js/oauth2/Authorize.js?version=${version}"></script>
    <script src="${request.contextPath}/js/identityProvider/InProgress.js?version=${version}"></script>
    [@helpers.alternativeLoginsScript clientId=client_id identityProviders=identityProviders/]
    <script>
      Prime.Document.onReady(function() {
        [#-- This object handles guessing the timezone, filling in the device id of the user, and check for WebAuthn re-authentication support --]
        new FusionAuth.OAuth2.Authorize();
      });
    </script>
  [/@helpers.head]

  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [#assign loginFailed = false /]
    [#assign loginFailedReason = "" /]

    [#if errorMessages?size > 0]
      [#list errorMessages as m]
        [#if m == theme.message("[InvalidLogin]")]
          [#assign loginFailed = true /]
          [#assign loginFailedReason = m /]
        [/#if]
      [/#list]
    [/#if]


    [@helpers.splitMain title=theme.message("loginPageTitle") subtitle=theme.message("loginPageSubtitle")]

      [#--
      <pre>
        client_id: ${client_id}
        passwordlessEnabled: ${passwordlessEnabled?string('yes', 'no')}
        infoMessages: ${infoMessages}
        errorMessages: ${errorMessages}
      </pre>
      --]

      [#-- During a linking work flow, optionally indicate to the user which IdP is being linked. --]
      [#if devicePendingIdPLink?? || pendingIdPLink??]
        <p class="mt-0">
        [#if devicePendingIdPLink?? && pendingIdPLink??]
          ${theme.message('pending-links-login-to-complete', devicePendingIdPLink.identityProviderName, pendingIdPLink.identityProviderName)}
        [#elseif devicePendingIdPLink??]
          ${theme.message('pending-link-login-to-complete', devicePendingIdPLink.identityProviderName)}
        [#else]
          ${theme.message('pending-link-login-to-complete', pendingIdPLink.identityProviderName)}
        [/#if]
        [#-- A pending link can be cancled. If we also have a device link in progress, this cannot be canceled. --]
        [#if pendingIdPLink??]
          [@helpers.link url="" extraParameters="&cancelPendingIdpLink=true"]${theme.message("login-cancel-link")}[/@helpers.link]
        [/#if]
        </p>
      [/#if]

      <div class="flex flex-col items-center gap-2 text-center">
        [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders passwordlessEnabled=passwordlessEnabled bootstrapWebauthnEnabled=bootstrapWebauthnEnabled idpRedirectState=idpRedirectState federatedCSRFToken=federatedCSRFToken/]
      </div>

      <div class="flex flex-col items-center text-center">
          <p class="text-muted-foreground text-sm text-balance">
            ${theme.message("orSignInWithEmail")}
          </p>
      </div>

      [#if loginFailed]
        <div data-slot="alert" role="alert" class="relative bg-rose-100 w-full rounded-md px-4 py-3 text-sm grid has-[>svg]:grid-cols-[calc(var(--spacing)*4)_1fr] grid-cols-[0_1fr] has-[>svg]:gap-x-3 gap-y-0.5 items-start [&>svg]:size-4 [&>svg]:translate-y-0.5 [&>svg]:text-current">
          <svg class="size-4 translate-y-0.5 text-current" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"/>
            <line x1="12" y1="8" x2="12" y2="12"/>
            <line x1="12" y1="16" x2="12.01" y2="16"/>
          </svg>
          <div class="col-start-2 min-h-4 tracking-tight">
            ${theme.message("incorrect-email-id-or-password")}
            [@helpers.link class="font-semibold text-fuchsia-900" url="${request.contextPath}/password/forgot"]${theme.message("reset-your-password")}[/@helpers.link]
          </div>
        </div>
      [/#if]

      <form action="${request.contextPath}/oauth2/authorize" method="POST" class="grid gap-6">
        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="showPasswordField"/]
        [@helpers.hidden name="userVerifyingPlatformAuthenticatorAvailable"/]
        [#if showPasswordField && hasDomainBasedIdentityProviders]
          [@helpers.hidden name="loginId"/]
        [/#if]
        
          [@helpers.input type="text" name="loginId" id="loginId" autocapitalize="none" autocomplete="on" autocorrect="off" spellcheck="false" autofocus=(!loginId?has_content) placeholder=theme.message("loginId") label=theme.message("emailInputLabel") disabled=(showPasswordField && hasDomainBasedIdentityProviders) /]
          [#if showPasswordField]  
            [@helpers.input type="password" name="password" id="password" autocomplete="current-password" autofocus=loginId?has_content placeholder=theme.message("password") label=theme.message("passwordInputLabel") /]
            [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
          [/#if]
          
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
              </span>
            </label>
            [#-- <i class="fa fa-info-circle pl-2 pr-2 tooltip" data-tooltip="${theme.message('{tooltip}remember-device')}"></i>[#t/] --]

            [#if showPasswordField]
              [@helpers.link class="ml-auto text-sm text-black underline-offset-4 hover:underline" url="${request.contextPath}/password/forgot"]${theme.message("forgot-your-password")}[/@helpers.link]
            [/#if]
          </div>
          
          [#if showPasswordField]
            [@helpers.button text=theme.message("login-now") styleAs="black" /]
          [#else]
            [@helpers.button text=theme.message("next") styleAs="black" /]
          [/#if]
      </form>

      [#if application.registrationConfiguration.enabled]
        <div class="text-center text-sm">
          ${theme.message("dont-have-an-account")}
          [@helpers.link class="font-semibold text-fuchsia-900" url="${request.contextPath}/oauth2/register"] ${theme.message("sign-up-now")} [/@helpers.link]
        </div>
      [/#if]
      
      <div>
        [#if showPasswordField && hasDomainBasedIdentityProviders]
          [@helpers.link url="" extraParameters="&showPasswordField=false"]${theme.message("sign-in-as-different-user")}[/@helpers.link]
        [/#if]
      </div>

     [#if showWebAuthnReauthLink]
       [@helpers.link url="${request.contextPath}/oauth2/webauthn-reauth"] ${theme.message("return-to-webauthn-reauth")} [/@helpers.link]
     [/#if]
    [/@helpers.splitMain]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]

  [/@helpers.body]
[/@helpers.html]