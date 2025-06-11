[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="collectBirthDate" type="boolean" --]
[#-- @ftlvariable name="devicePendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="federatedCSRFToken" type="java.lang.String" --]
[#-- @ftlvariable name="fields" type="java.util.List<io.fusionauth.domain.form.FormField>" --]
[#-- @ftlvariable name="hideBirthDate" type="boolean" --]
[#-- @ftlvariable name="identityProviders" type="java.util.Map<java.lang.String, java.util.List<io.fusionauth.domain.provider.BaseIdentityProvider<?>>>" --]
[#-- @ftlvariable name="idpRedirectState" type="java.lang.String" --]
[#-- @ftlvariable name="passwordValidationRules" type="io.fusionauth.domain.PasswordValidationRules" --]
[#-- @ftlvariable name="parentEmailRequired" type="boolean" --]
[#-- @ftlvariable name="pendingIdPLink" type="io.fusionauth.domain.provider.PendingIdPLink" --]
[#-- @ftlvariable name="showCaptcha" type="boolean" --]
[#-- @ftlvariable name="step" type="int" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#-- @ftlvariable name="totalSteps" type="int" --]
[#import "../_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head]
    <script src="${request.contextPath}/js/identityProvider/InProgress.js?version=${version}"></script>
    [@helpers.alternativeLoginsScript clientId=client_id identityProviders=identityProviders/]
    [#if step == totalSteps]
      [@helpers.captchaScripts showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
    [/#if]
    <script type="text/javascript">
      document.addEventListener('DOMContentLoaded', () => {
        const uvpaAvailableField = document.querySelector('input[name="userVerifyingPlatformAuthenticatorAvailable"]');
        if (uvpaAvailableField !== null && typeof(PublicKeyCredential) !== 'undefined' && PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable) {
          PublicKeyCredential
            .isUserVerifyingPlatformAuthenticatorAvailable()
            .then(result => uvpaAvailableField.value = result);
        }
      });
    </script>
    <script>
      /*
      prompt:
        on the form, there are two fields with ID #password and #passwordConfirm
        when the user types in the password field, we need to check if the passwordConfirm field is valid
        validating all the rules as described above in the #passwordRules div
        when the input is empty, we need to add the class `text-neutral-500` to the #passwordRules div and all the li elements with the id of the rule
        when a specific rule is not met, we need to add the class `text-pink-700` to the li element with the id of the rule
        when a specific rule is met, we need to add the class `text-green-700` to the li element with the id of the rule
        when all the rules are met, we need to add the class `text-green-700` to the #passwordRules div
      */
      "use strict";
      Prime.Document.onReady(function() {
        const passwordInput = document.getElementById('password');
        [#if application.registrationConfiguration.confirmPassword]
        const passwordConfirmInput = document.getElementById('passwordConfirm');
        [/#if]
        const passwordRulesDiv = document.getElementById('passwordRules');
        const ruleElements = {
          requireMixedCase: document.getElementById('requireMixedCase'),
          requireNumber: document.getElementById('requireNumber'),
          requireLength: document.getElementById('requireLength'),
          requirePrevious: document.getElementById('requirePrevious'),
          
          [#if passwordValidationRules.requireNonAlpha]
            requireNonAlpha: document.getElementById('requireNonAlpha'),
          [/#if]

          [#if application.registrationConfiguration.confirmPassword]
            requireMatch: document.getElementById('requireMatch'),
          [/#if]          
        };

        function validatePassword(password) {
          const rules = {
            requireMixedCase: /(?=.*[a-z])(?=.*[A-Z])/.test(password),
            requireNumber: /[0-9]/.test(password),
            requireLength: password.length >= ${passwordValidationRules.minLength} && password.length <= ${passwordValidationRules.maxLength},
            requirePrevious: true // This would need to be validated server-side
            
            [#if passwordValidationRules.requireNonAlpha]
              requireNonAlpha: /[^a-zA-Z0-9]/.test(password),
            [/#if]            
            
            [#if application.registrationConfiguration.confirmPassword]
              requireMatch: password === passwordConfirmInput.value && password !== '',
            [/#if]            
          };

          // Reset all classes to neutral
          passwordRulesDiv.classList.remove('text-green-700', 'text-pink-700');
          passwordRulesDiv.classList.add('text-neutral-500');
          
          Object.entries(ruleElements).forEach(([rule, element]) => {
            if (element) {
              element.classList.remove('text-green-700', 'text-pink-700');
              element.classList.add('text-neutral-500');
            }
          });

          // If password is empty, return early
          if (!password) {
            return;
          }

          // Check each rule and update classes
          let allRulesMet = true;
          Object.entries(rules).forEach(([rule, isValid]) => {
            const element = ruleElements[rule];
            if (element) {
              element.classList.remove('text-neutral-500');
              if (isValid) {
                element.classList.add('text-green-700');
                element.classList.remove('text-pink-700');
              } else {
                element.classList.add('text-pink-700');
                element.classList.remove('text-green-700');
                allRulesMet = false;
              }
            }
          });

          // Update overall password rules div
          if (allRulesMet) {
            passwordRulesDiv.classList.remove('text-neutral-500', 'text-pink-700');
            passwordRulesDiv.classList.add('text-green-700');
          } else {
            passwordRulesDiv.classList.remove('text-neutral-500', 'text-green-700');
            passwordRulesDiv.classList.add('text-pink-700');
          }
        }

        // Add event listeners
        passwordInput.addEventListener('input', () => validatePassword(passwordInput.value));
        [#if application.registrationConfiguration.confirmPassword]
        passwordConfirmInput.addEventListener('input', () => validatePassword(passwordInput.value));
        [/#if]
      });
    </script>
    [#-- Custom <head> code goes here --]
  [/@helpers.head]
  
  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]

    [@helpers.splitMain title=theme.message("register")]

      [#--
      <pre class="text-xs">
        client_id: ${client_id}
        passwordlessEnabled: ${passwordlessEnabled?string('yes', 'no')}
        infoMessages: ${infoMessages}
        errorMessages: ${errorMessages}
        fieldMessages: ${fieldMessages?keys?join(", ")}
      </pre>
      --]

      [#-- During a linking work flow, optionally indicate to the user which IdP is being linked. --]
      [#if devicePendingIdPLink?? || pendingIdPLink??]
        <p class="mt-0">
        [#if devicePendingIdPLink?? && pendingIdPLink??]
          ${theme.message('pending-links-register-to-complete', devicePendingIdPLink.identityProviderName, pendingIdPLink.identityProviderName)}
        [#elseif devicePendingIdPLink??]
          ${theme.message('pending-link-register-to-complete', devicePendingIdPLink.identityProviderName)}
        [#else]
          ${theme.message('pending-link-register-to-complete', pendingIdPLink.identityProviderName)}
        [/#if]
        [#-- A pending link can be cancled. If we also have a device link in progress, this cannot be canceled. --]
        [#if pendingIdPLink??]
          [@helpers.link url="" extraParameters="&cancelPendingIdpLink=true"]${theme.message("register-cancel-link")}[/@helpers.link]
        [/#if]
        </p>
      [/#if]

      <div class="flex flex-col items-center gap-2 text-center">
        [@helpers.alternativeLogins clientId=client_id identityProviders=identityProviders passwordlessEnabled=false bootstrapWebauthnEnabled=false idpRedirectState=idpRedirectState federatedCSRFToken=federatedCSRFToken/]
      </div>

      <div class="flex flex-col items-center text-center">
          <p class="text-muted-foreground text-sm text-balance">
            ${theme.message("orSignUpWithEmail")}
          </p>
      </div>

      <form action="${request.contextPath}/oauth2/register" method="POST" class="grid gap-6">
        [@helpers.oauthHiddenFields/]
        [@helpers.hidden name="step"/]
        [@helpers.hidden name="registrationState"/]
        [@helpers.hidden name="parentEmailRequired"/]
        [@helpers.hidden name="userVerifyingPlatformAuthenticatorAvailable"/]

        [#-- Begin Self Service Custom Registration Form Steps --]
        [#if fields?has_content]          
            [@helpers.hidden name="collectBirthDate"/]
            [#list fields as field]
              [@helpers.customField field field.key field?is_first?then(true, false) field.key /]
              [#if field.confirm]
                [@helpers.customField field "confirm.${field.key}" false "[confirm]${field.key}" /]
              [/#if]
            [/#list]
            [#-- If this is the last step of the form, optionally show a captcha. --]
            [#if step == totalSteps]
              [@helpers.captchaBadge showCaptcha=showCaptcha captchaMethod=tenant.captchaConfiguration.captchaMethod siteKey=tenant.captchaConfiguration.siteKey/]
            [/#if]

          [#if step == totalSteps]
            [@helpers.input id="rememberDevice" type="checkbox" name="rememberDevice" label=theme.message("remember-device") value="true" uncheckedValue="false"]
              <i class="fa fa-info-circle" data-tooltip="${theme.message('{tooltip}remember-device')}"></i>[#t/]
            [/@helpers.input]
            <div class="form-row">
              [@helpers.button icon="key" text=theme.message('register')/]
            </div>
          [#else]
            <div class="form-row">
              [@helpers.button icon="arrow-right" text=theme.message('next')/]
            </div>
          [/#if]
        [#-- End Custom Self Service Registration Form Steps --]
        [#else]
        [#-- Begin Basic Self Service Registration Form --]        
          [@helpers.hidden name="collectBirthDate"/]
          [#if !collectBirthDate && (!application.registrationConfiguration.birthDate.enabled || hideBirthDate)]
            [@helpers.hidden name="user.birthDate" dateTimeFormat="yyyy-MM-dd"/]
          [/#if]
          [#if collectBirthDate]
            [@helpers.input type="date" name="user.birthDate" id="birthDate" placeholder=theme.message('birthDate') label=theme.message("birthDateInputLabel") class="date-picker" required=true/]
          [#else]
            [#if application.registrationConfiguration.birthDate.enabled ||
            application.registrationConfiguration.firstName.enabled    ||
            application.registrationConfiguration.fullName.enabled     ||
            application.registrationConfiguration.middleName.enabled   ||
            application.registrationConfiguration.lastName.enabled     ||
            application.registrationConfiguration.mobilePhone.enabled  ||
            application.registrationConfiguration.preferredLanguages.enabled ]
              [#if application.registrationConfiguration.firstName.enabled]
                [@helpers.input type="text" name="user.firstName" id="firstName" autocapitalize="words" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('firstName') label=theme.message("firstNameInputLabel") required=application.registrationConfiguration.firstName.required/]
              [/#if]
              [#if application.registrationConfiguration.fullName.enabled]
                [@helpers.input type="text" name="user.fullName" id="fullName" autocapitalize="words" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('fullName') label=theme.message("fullNameInputLabel") required=application.registrationConfiguration.fullName.required/]
              [/#if]
              [#if application.registrationConfiguration.middleName.enabled]
                [@helpers.input type="text" name="user.middleName" id="middleName" autocapitalize="words" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('middleName') label=theme.message("middleNameInputLabel") required=application.registrationConfiguration.middleName.required/]
              [/#if]
              [#if application.registrationConfiguration.lastName.enabled]
                [@helpers.input type="text" name="user.lastName" id="lastName" autocapitalize="words" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('lastName') label=theme.message("lastNameInputLabel") required=application.registrationConfiguration.lastName.required/]
              [/#if]
              [#if application.registrationConfiguration.birthDate.enabled && !hideBirthDate]
                [@helpers.input type="date" name="user.birthDate" id="birthDate" placeholder=theme.message('birthDate') label=theme.message("birthDateInputLabel") class="date-picker" required=application.registrationConfiguration.birthDate.required/]
              [/#if]
              [#if application.registrationConfiguration.mobilePhone.enabled]
                [@helpers.input type="text" name="user.mobilePhone" id="mobilePhone" placeholder=theme.message('mobilePhone') label=theme.message("mobilePhoneInputLabel") required=application.registrationConfiguration.mobilePhone.required/]
              [/#if]
              [#if application.registrationConfiguration.preferredLanguages.enabled]
                [@helpers.locale_select field="" name="user.preferredLanguages" id="preferredLanguages" label=theme.message("preferredLanguage") required=application.registrationConfiguration.preferredLanguages.required /]
              [/#if]
            [/#if]
            
            [#if application.registrationConfiguration.loginIdType == 'email']
              [@helpers.input type="text" name="user.email" id="email" autocomplete="username" autocapitalize="none" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('email') label=theme.message("emailInputLabel") required=true/]
            [#else]
              [@helpers.input type="text" name="user.username" id="username" autocomplete="username" autocapitalize="none" autocorrect="off" spellcheck="false" autofocus=true placeholder=theme.message('username') label=theme.message("usernameInputLabel") required=true/]
            [/#if]

            [@helpers.input type="password" name="user.password" id="password" autocomplete="new-password" placeholder=theme.message('password') label=theme.message("passwordInputLabel") required=true/]
            [#if application.registrationConfiguration.confirmPassword]
              [@helpers.input type="password" name="passwordConfirm" id="passwordConfirm" autocomplete="new-password" placeholder=theme.message('passwordConfirm') label=theme.message("passwordConfirmInputLabel") required=true/]
            [/#if]
            [#if parentEmailRequired]
              [@helpers.input type="text" name="user.parentEmail" id="parentEmail" placeholder=theme.message('parentEmail') leftAddon="user" required=true/]
            [/#if]

            <div>
              [#-- Show the Password Validation Rules if there is a field error for 'user.password' --]
              [@helpers.passwordRules passwordValidationRules/]
            </div>

          [/#if]
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
              </span>
            </label>
            [#-- <i class="fa fa-info-circle pl-2 pr-2 tooltip" data-tooltip="${theme.message('{tooltip}remember-device')}" data-tooltip-target="tooltip"></i>[#t/] --]
          </div>

          [@helpers.button text=theme.message('register-now') styleAs="primary" /]
        [/#if]
        [#-- End Basic Self Service Registration Form --]

        [#-- Begin Self Service Custom Registration Form Step Counter --]
        [#if step > 0]
          <div class="w-100 mt-3" style="display: inline-flex; flex-direction: row; justify-content: space-evenly;">
            <div class="text-right" style="flex-grow: 1;"> ${theme.message('register-step', step, totalSteps)} </div>
          </div>
        [/#if]
        [#-- End Self Service Custom Registration Form Step Counter --]
      </form>

      [#if application.registrationConfiguration.enabled]
        <div class="text-center text-sm">
          ${theme.message("already-have-an-account")}
          [@helpers.link class="font-semibold text-fuchsia-900" url="/oauth2/authorize"] ${theme.message("login-now")} [/@helpers.link]
        </div>
      [/#if]
    [/@helpers.splitMain]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]