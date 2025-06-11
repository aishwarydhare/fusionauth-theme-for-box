[#ftl/]
[#setting url_escaping_charset="UTF-8"]
[#-- Below are the main blocks for all of the themeable pages --]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="bypassTheme" type="boolean" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge" type="java.lang.String" --]
[#-- @ftlvariable name="code_challenge_method" type="java.lang.String" --]
[#-- @ftlvariable name="consents" type="java.util.Map<java.util.UUID, java.util.List<java.lang.String>>" --]
[#-- @ftlvariable name="editPasswordOption" type="java.lang.String" --]
[#-- @ftlvariable name="locale" type="java.util.Locale" --]
[#-- @ftlvariable name="loginTheme" type="io.fusionauth.domain.Theme.Templates" --]
[#-- @ftlvariable name="metaData" type="io.fusionauth.domain.jwt.RefreshToken.MetaData" --]
[#-- @ftlvariable name="nonce" type="java.lang.String" --]
[#-- @ftlvariable name="passwordValidationRules" type="io.fusionauth.domain.PasswordValidationRules" --]
[#-- @ftlvariable name="pendingIdPLinkId" type="java.lang.String" --]
[#-- @ftlvariable name="redirect_uri" type="java.lang.String" --]
[#-- @ftlvariable name="response_mode" type="java.lang.String" --]
[#-- @ftlvariable name="response_type" type="java.lang.String" --]
[#-- @ftlvariable name="scope" type="java.lang.String" --]
[#-- @ftlvariable name="state" type="java.lang.String" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="theme" type="io.fusionauth.domain.Theme" --]
[#-- @ftlvariable name="timezone" type="java.lang.String" --]
[#-- @ftlvariable name="user_code" type="java.lang.String" --]
[#-- @ftlvariable name="version" type="java.lang.String" --]

[#macro html]
<!DOCTYPE html>
<html lang="en">
  [#nested/]
</html>
[/#macro]

[#macro head title="Login | FusionAuth" author="FusionAuth" description="User Management Redefined. A Single Sign-On solution for your entire enterprise."]
<head>
  <title>${title}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="application-name" content="FusionAuth">
  <meta name="author" content="FusionAuth">
  <meta name="description" content="${description}">
  <meta name="robots" content="index, follow">

  [#-- https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy --]
  <meta name="referrer" content="strict-origin">

  [#--  Browser Address bar color --]
  <meta name="theme-color" content="#ffffff">

  [#-- Begin Favicon Madness
       You can check if this is working using this site https://realfavicongenerator.net/
       Questions about icon names and sizes? https://realfavicongenerator.net/faq#.XrBnPJNKg3g --]

  [#-- Apple & iOS --]
  <link rel="apple-touch-icon" sizes="57x57" href="/images/apple-icon-57x57.png">
  <link rel="apple-touch-icon" sizes="60x60" href="/images/apple-icon-60x60.png">
  <link rel="apple-touch-icon" sizes="72x72" href="/images/apple-icon-72x72.png">
  <link rel="apple-touch-icon" sizes="76x76" href="/images/apple-icon-76x76.png">
  <link rel="apple-touch-icon" sizes="114x114" href="/images/apple-icon-114x114.png">
  <link rel="apple-touch-icon" sizes="120x120" href="/images/apple-icon-120x120.png">
  <link rel="apple-touch-icon" sizes="144x144" href="/images/apple-icon-144x144.png">
  <link rel="apple-touch-icon" sizes="152x152" href="/images/apple-icon-152x152.png">
  <link rel="apple-touch-icon" sizes="180x180" href="/images/apple-icon-180x180.png">

  [#--  Android Icons --]
  <link rel="manifest" href="/images/manifest.json">

  [#-- IE 11+ configuration --]
  <meta name="msapplication-config" content="/images/browserconfig.xml" />

  [#-- Windows 8 Compatible --]
  <meta name="msapplication-TileColor" content="#ffffff">
  <meta name="msapplication-TileImage" content="/images/ms-icon-144x144.png">

  [#--  Standard Favicon Fare --]
  <link rel="icon" type="image/png" sizes="16x16" href="/images/favicon-16x16.png">
  <link rel="icon" type="image/png" sizes="32x32" href="/images/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="96x96" href="/images/favicon-96x96.png">
  <link rel="icon" type="image/png" sizes="128" href="/images/favicon-128.png">

  [#-- Fonts --]
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500&display=swap"
    rel="stylesheet"
  />

  [#-- End Favicon Madness --]

  <link rel="stylesheet" href="/css/font-awesome-4.7.0.min.css"/>
  [#-- <link rel="stylesheet" href="/css/fusionauth-style.css?version=${version}"/> --]
  [#-- [#if theme.type == "simple"]
    <link rel="stylesheet" href="/css/simple-theme.css?version=${version}"/>
  [/#if] --]

  [#-- Theme Stylesheet, only Authorize defines this boolean.
       Using the ?no_esc on the stylesheet to allow selectors that contain a > symbols.
       Once insde of a style tag we are safe and the stylesheet is validated not to contain an end style tag --]
  [#if !(bypassTheme!false)]
    <style>
    ${theme.stylesheet()?no_esc}
    </style>
  [/#if]

  <script src="${request.contextPath}/js/prime-min-1.7.0.js?version=${version}"></script>
  <script src="${request.contextPath}/js/Util.js?version=${version}"></script>
  <script src="${request.contextPath}/js/oauth2/LocaleSelect.js?version=${version}"></script>
  <script>
    "use strict";
    Prime.Document.onReady(function() {
      Prime.Document.query('.alert').each(function(e) {
        var dismissButton = e.queryFirst('a.dismiss-button');
        if (dismissButton !== null) {
          new Prime.Widgets.Dismissable(e, dismissButton).initialize();
        }
      });
      Prime.Document.query('[data-tooltip]').each(function(e) {
        new Prime.Widgets.Tooltip(e).withClassName('tooltip').initialize();
      });
      document.querySelectorAll('.date-picker').forEach(datePicker => {
        datePicker.onfocus = () => datePicker.type = 'date';
        datePicker.onblur = () => {
          if (datePicker.value === '') {
            datePicker.type = 'text';
          }
        };
      });
      [#-- You may optionally remove the Locale Selector, or it may not be on every page. --]
      var localeSelect = Prime.Document.queryById('locale-select');
      if (localeSelect !== null) {
        new FusionAuth.OAuth2.LocaleSelect(localeSelect);
      }
    });
    FusionAuth.Version = "${version}";
  </script>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/core@1.3.2/dist/css/tabler-socials.min.css" />

  [#-- The nested, page-specific head HTML goes here --]
  [#nested/]

</head>
[/#macro]

[#macro body]
<body class="app-sidebar-closed bg-gray-100 font-['Poppins']">
<main style="padding-top: 0px;">
  [#nested/]
</main>
</body>
[/#macro]

[#macro header]
  [#--
  [#if theme.type != 'simple' || request.requestURI == "/" || request.requestURI?starts_with("/account")]
    <header class="app-header">
      <div class="right-menu" [#if request.requestURI == "/"]style="display: block !important;" [/#if]>
        <nav>
          <ul>
            [#if request.requestURI == "/"]
              <li><a href="${request.contextPath}/admin/" title="Administrative login"><i class="fa fa-lock" style="font-size: 18px;"></i></a></li>
            [#elseif request.requestURI?starts_with("/account")]
              <li><a href="${request.contextPath}/account/logout?client_id=${client_id!''}" title="Logout"><i class="fa fa-sign-out"></i></a></li>
            [#else]
              <li class="help"><a target="_blank" href="https://fusionauth.io/docs/"><i class="fa fa-question-circle-o"></i> ${theme.message("help")}</a></li>
            [/#if]
          </ul>
        </nav>
      </div>
    </header>
  [/#if]

  [#nested/]
  --]
[/#macro]

[#macro alternativeLoginsScript clientId identityProviders]
  [#if identityProviders["EpicGames"]?has_content || identityProviders["Facebook"]?has_content || identityProviders["Google"]?has_content ||
         identityProviders["LinkedIn"]?has_content || identityProviders["Nintendo"]?has_content || identityProviders["OpenIDConnect"]?has_content ||
         identityProviders["SAMLv2"]?has_content || identityProviders["SonyPSN"]?has_content || identityProviders["Steam"]?has_content ||
         identityProviders["Twitch"]?has_content || identityProviders["Xbox"]?has_content || identityProviders["Apple"]?has_content ||
         identityProviders["Twitter"]?has_content]
    [#-- Include Helper.js instead of loading dynamically from other IdP JS. IdP JS files will still load the script if it has not already been loaded --]
    <script id="idp_helper" src="${request.contextPath}/js/identityProvider/Helper.js?version=${version}"></script>
  [/#if]
  [#if identityProviders["Apple"]?has_content]
    <script src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script>
    <script src="${request.contextPath}/js/identityProvider/Apple.js?version=${version}"></script>
  [/#if]
  [#if identityProviders["Facebook"]?has_content]
    <script src="https://connect.facebook.net/en_US/sdk.js"></script>
    <script src="${request.contextPath}/js/identityProvider/Facebook.js?version=${version}" data-app-id="${identityProviders["Facebook"][0].lookupAppId(clientId)}"></script>
  [/#if]
  [#if identityProviders["Google"]?has_content && identityProviders["Google"][0].lookupLoginMethod(clientId) != "UseRedirect"]
    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script src="${request.contextPath}/js/identityProvider/Google.js?version=${version}" data-client-id="${identityProviders["Google"][0].lookupClientId(clientId)}"></script>
  [/#if]
  [#if identityProviders["Twitter"]?has_content]
    [#-- This is the FusionAuth clientId --]
    <script src="${request.contextPath}/js/identityProvider/Twitter.js?version=${version}" data-client-id="${clientId}"></script>
  [/#if]
  [#if identityProviders["EpicGames"]?has_content || identityProviders["Facebook"]?has_content || identityProviders["Google"]?has_content ||
       identityProviders["LinkedIn"]?has_content || identityProviders["Nintendo"]?has_content || identityProviders["OpenIDConnect"]?has_content ||
       identityProviders["SAMLv2"]?has_content || identityProviders["SonyPSN"]?has_content || identityProviders["Steam"]?has_content ||
       identityProviders["Twitch"]?has_content || identityProviders["Xbox"]?has_content]
    <script src="${request.contextPath}/js/identityProvider/Redirect.js?version=${version}"></script>
  [/#if]
[/#macro]

[#macro main title="" subtitle="" headingIconClass=""]
<main class="grid min-h-svh">
  <div class="flex flex-col gap-4 p-6 md:p-10">    
    <div class="hidden flex justify-center gap-2 md:justify-start" data-in-progress>
        <a href="#" class="flex items-center gap-2 font-medium">
            <div class="bg-black text-white flex size-6 items-center justify-center rounded-md">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="size-4">
                    <path d="M3 3h18v18H3z"/>
                    <path d="M3 9h18"/>
                    <path d="M3 15h18"/>
                </svg>
            </div>
            Acme Inc.
        </a>
    </div>

    <div class="flex flex-1 items-center justify-center" data-in-progress>
      <div class="w-full max-w-md">
        <div class="flex flex-col gap-6">
          <div class="flex flex-col items-center gap-2 text-center">
            [#if headingIconClass?has_content]
              <div class="flex items-center justify-center">
                [#if headingIconClass == "envelope-circle-check"]
                  <svg width="100" height="100" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M8.33398 18.75L37.1382 35.0707C47.7573 41.0875 52.244 41.0875 62.8631 35.0707L91.6673 18.75" stroke="black" stroke-width="6.25" stroke-linejoin="round"/>
                    <path d="M62.5 72.9166C62.5 72.9166 64.5833 72.9166 66.6667 77.0833C66.6667 77.0833 73.2842 66.6666 79.1667 64.5833" stroke="black" stroke-width="6.25" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M91.6667 70.8333C91.6667 82.3392 82.3392 91.6667 70.8333 91.6667C59.3275 91.6667 50 82.3392 50 70.8333C50 59.3275 59.3275 50 70.8333 50C82.3392 50 91.6667 59.3275 91.6667 70.8333Z" stroke="black" stroke-width="6.25" stroke-linecap="round"/>
                    <path d="M37.849 82.2907C39.5744 82.3341 41.0082 80.9707 41.0516 79.2453C41.0951 77.5199 39.7316 76.0862 38.0063 76.0424L37.849 82.2907ZM88.5198 43.7833C88.4961 45.5091 89.8761 46.9274 91.6015 46.9508C93.3273 46.9745 94.7456 45.5949 94.769 43.8691L88.5198 43.7833ZM38.0062 11.6099C46.0431 11.4077 54.0006 11.4077 62.0377 11.61L62.1952 5.36196C54.0531 5.15704 45.9911 5.157 37.849 5.36192L38.0062 11.6099ZM5.27539 37.598C5.18685 41.7583 5.18685 45.8941 5.27539 50.0545L11.524 49.9216C11.4373 45.8499 11.4373 41.8028 11.524 37.7311L5.27539 37.598ZM37.849 5.36192C31.3798 5.52471 26.1866 5.64746 22.035 6.37163C17.7425 7.12042 14.2545 8.55654 11.3082 11.5188L15.7396 15.9263C17.5089 14.1473 19.6599 13.1303 23.1091 12.5287C26.6991 11.9024 31.3499 11.7774 38.0062 11.6099L37.849 5.36192ZM11.524 37.7311C11.6623 31.2361 11.7668 26.7118 12.3748 23.2051C12.957 19.8468 13.9576 17.718 15.7396 15.9263L11.3082 11.5188C8.37481 14.4683 6.94956 17.9102 6.21664 22.1375C5.50947 26.2163 5.40964 31.2924 5.27539 37.598L11.524 37.7311ZM62.0377 11.61C68.6944 11.7775 73.3452 11.9025 76.9352 12.5287C80.3844 13.1304 82.5352 14.1474 84.3044 15.9263L88.7361 11.5189C85.7898 8.55663 82.3015 7.1205 78.009 6.37171C73.8577 5.6475 68.6644 5.52475 62.1952 5.36196L62.0377 11.61ZM94.769 37.5981C94.6344 31.2925 94.5348 26.2164 93.8273 22.1375C93.0948 17.9103 91.6694 14.4683 88.7361 11.5189L84.3044 15.9263C86.0865 17.718 87.0873 19.8468 87.6694 23.2052C88.2773 26.7119 88.3819 31.2362 88.5202 37.7312L94.769 37.5981ZM38.0063 76.0424C31.35 75.8749 26.6991 75.7499 23.1091 75.1237C19.6599 74.522 17.5089 73.5053 15.7397 71.7262L11.3083 76.1337C14.2545 79.0958 17.7426 80.532 22.035 81.2808C26.1866 82.0049 31.3798 82.1278 37.849 82.2907L38.0063 76.0424ZM5.27539 50.0545C5.40964 56.3599 5.50952 61.4362 6.21668 65.5149C6.94956 69.7424 8.37481 73.1841 11.3083 76.1337L15.7397 71.7262C13.9576 69.9345 12.9571 67.8057 12.3748 64.4474C11.7668 60.9407 11.6623 56.4162 11.524 49.9216L5.27539 50.0545ZM91.6444 43.8262C94.769 43.8691 94.769 43.8691 94.769 43.8691C94.769 43.8699 94.769 43.8682 94.769 43.8691C94.769 43.867 94.7694 43.8607 94.7694 43.857C94.7694 43.8495 94.7694 43.8387 94.7698 43.8241C94.7702 43.7953 94.7706 43.7528 94.7715 43.6987C94.7727 43.5895 94.7744 43.4316 94.7765 43.2349C94.7806 42.842 94.7856 42.2924 94.7886 41.6665C94.7952 40.4224 94.7952 38.8478 94.769 37.5981L88.5202 37.7312C88.5448 38.8943 88.5452 40.4005 88.539 41.634C88.5356 42.247 88.5306 42.7853 88.5269 43.1708C88.5248 43.3628 88.5231 43.517 88.5219 43.6224C88.5211 43.6753 88.5206 43.7157 88.5202 43.7428C88.5202 43.7566 88.5198 43.767 88.5198 43.7737C88.5198 43.777 88.5198 43.7816 88.5198 43.7833C88.5198 43.7833 88.5198 43.7833 91.6444 43.8262Z" fill="black"/>
                  </svg>
                [/#if]
              </div>
            [/#if]
            [#if title?has_content]
              <h1 class="text-3xl font-semibold whitespace-nowrap">${title}</h1>
            [/#if]
            [#if subtitle?has_content]
              <p class="text-muted-foreground text-lg text-neutral-500">
                ${subtitle}
              </p>
            [/#if]
            </p>
          </div>
          <main class="flex flex-col gap-6">
            [#nested/]
          </main>
          <div class="flex justify-center p-6">
            [@localSelector/]
          </div>
        </div>
      </div>
    </div>
  </div>
</main>
[/#macro]

[#macro splitMain title="Login" subtitle="" splitSideImage="/placeholder.svg"]
<main class="grid min-h-svh lg:grid-cols-2">
  <div class="flex flex-col gap-4 p-6 md:p-10">    
    <div class="hidden flex justify-center gap-2 md:justify-start" data-in-progress>
        <a href="#" class="flex items-center gap-2 font-medium">
            <div class="bg-black text-white flex size-6 items-center justify-center rounded-md">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="size-4">
                    <path d="M3 3h18v18H3z"/>
                    <path d="M3 9h18"/>
                    <path d="M3 15h18"/>
                </svg>
            </div>
            Acme Inc.
        </a>
    </div>

    <div class="flex flex-1 items-center justify-center">
      <div class="w-full max-w-md">
        <div class="flex flex-col gap-6">
          <div class="flex flex-col items-center gap-2 text-center">
            [#if title?has_content]
              <h1 class="text-3xl font-semibold">${title}</h1>
            [/#if]
            [#if subtitle?has_content]
              <p class="text-muted-foreground text-lg text-neutral-500">
                ${subtitle}
              </p>
            [/#if]
            </p>
          </div>
          <main class="flex flex-col gap-6">
            [#nested/]
          </main>
        </div>
      </div>
    </div>
  </div>
  
  <div class="relative hidden lg:block pt-6 pb-6 pr-6">
      <div class="h-full w-full rounded-2xl bg-gradient-to-r from-indigo-500 from-10% via-sky-500 via-30% to-emerald-500 to-90%">
      </div>
  </div>
  
</main>
[/#macro]

[#macro accountMain rowClass="row center-xs" colClass="col-xs col-sm-8 col-md-6 col-lg-5 col-xl-4" actionURL="" actionText="Go back" actionDirection="back"]
<main class="page-body container">
  [@printErrorAlerts rowClass colClass/]
  [@printInfoAlerts rowClass colClass/]
  <div class="${rowClass}">
    <div class="${colClass}">
      [#nested/]
    </div>
  </div>
  [@accountFooter rowClass "col-xs-6 col-sm-6 col-md-5 col-lg-4" actionURL actionText actionDirection/]
</main>
[/#macro]

[#macro localSelector]
<label class="select">
  <select id="locale-select" name="locale" class="select">
    <option value="en" [#if locale == 'en']selected[/#if]>English</option>
      [#list theme.additionalLocales() as l]
        <option value="${l}" [#if locale == l]selected[/#if]>${l.getDisplayLanguage(locale)}</option>
      [/#list]
  </select>
</label>
[/#macro]

[#macro accountFooter rowClass colClass actionURL actionText actionDirection]
<div class="${rowClass}">
  <div class="${colClass}">
    [@localSelector/]
  </div>
  <div class="${colClass}" style="text-align: right;">

  [#-- actionURL and actionText may be an array. For backwards compatibility, allow a string
       or an array. If not an array yet, convert to one now. --]
  [#if !actionURL?is_sequence]
    [#local actionURLs = [actionURL]/]
  [#else]
    [#local actionURLs = actionURL/]
  [/#if]

  [#if !actionText?is_sequence]
    [#local actionTexts = [actionText]/]
  [#else]
    [#local actionTexts = actionText/]
  [/#if]

  [#list actionURLs as url]
    [#local actionURL = url/]
    [#if actionURL?has_content]
      [#if !actionURL?contains("client_id")]
        [#if actionURL?contains("?")]
         [#local actionURL = actionURL + "&client_id=${client_id}"/]
        [#else]
         [#local actionURL = actionURL + "?client_id=${client_id}"/]
        [/#if]
      [/#if]
      [#if actionDirection == "back"]
        <a href="${actionURL}"> <i class="fa fa-arrow-left"></i> ${actionTexts[url_index]}</a>
      [#else]
        <a class="d-inline-block mb-2" href="${actionURL}">${actionTexts[url_index]} <i class="fa fa-arrow-right"></i></a>
      [/#if]
      [#sep]<br>[/#sep]
    [/#if]
  [/#list]
  </div>
</div>
[/#macro]

[#macro accountPanelFull title=""]
<div class="panel">
  [#if title?has_content]
    <h2>${title}</h2>
  [/#if]
  <main>
    [#nested/]
  </main>
</div>
[/#macro]

[#macro accountPanel title tenant user action showEdit]
<div class="panel">
  [#if title?has_content]
    <h2>${title}</h2>
  [/#if]
  <main>
   <div class="row mb-5 user-details">
      [#-- Column 1 --]
      <div class="col-xs-12 col-md-4 col-lg-4 tight-left" style="padding-bottom: 0;">
        <div class="avatar pr-2 pb-3">
          <div>
            [#if user.imageUrl??]
              <img src="${user.imageUrl}" class="profile w-100" alt="profile image"/>
            [#elseif user.lookupEmail()??]
              <img src="${function.gravatar(user.lookupEmail(), 200)}" class="profile w-100" alt="profile image"/>
            [#else]
              <img src="${request.contextPath}/images/missing-user-image.svg" class="profile w-100" alt="profile image"/>
            [/#if]
          </div>
          <div>${display(user, "name")}</div>
       </div>
      </div>
      [#-- Column 2 --]
      <div class="col-xs-12 col-md-8 col-lg-8 tight-left">
        [#nested/]
      </div>
      [#if action == "view"]
        <div class="panel-actions">
         <div class="status">
           [#if showEdit]
            <a id="edit-profile" class="blue icon" href="${request.contextPath}/account/edit?client_id=${client_id}">
              <span style="font-size: 0.9rem;">
              <i class="fa fa-pencil blue-text" data-tooltip="${theme.message('edit-profile')}"></i>
              </span>
            </a>
           [/#if]
         </div>
       </div>
      [/#if]
  </div>
  </main>
</div>
[/#macro]

[#macro footer]
  [#--
  [#nested/]
  --]

  [#-- [@localSelector/] --]

  [#-- Powered by FusionAuth branding. This backlink helps FusionAuth web ranking so more
       people can find us! However, we always want to give the developer choice, remove this if you like. --]
  [#--
  <div id="fa-footer" style="position: fixed; bottom: 5px; right: 0; padding-bottom: 5px; padding-right: 10px; align-items: center">
    <span style="padding-right: 5px;">Powered by </span>
    <a href="https://fusionauth.io" title="The best developer IAM in the universe!">
      <img src="/images/footer-logo.svg" alt="FusionAuth" height="24" style="margin-bottom: -7px;">
    </a>
  </div>
  --]
[/#macro]

[#-- Below are the social login buttons and helpers --]
[#assign socialLoginButtonClasses = "login-button inline-flex items-center justify-center gap-1.5 whitespace-nowrap rounded-md text-sm font-medium h-10 px-3 shadow-[0_0px_6px_rgba(0,0,0,0.1)] hover:bg-accent hover:text-accent-foreground"]

[#macro appleButton identityProvider clientId]
 [#-- https://developer.apple.com/design/human-interface-guidelines/sign-in-with-apple/overview/buttons/ --]
  <button type="button" id="apple-login-button" data-scope="${identityProvider.lookupScope(clientId)!''}" data-services-id="${identityProvider.lookupServicesId(clientId)}" class="apple ${socialLoginButtonClasses}">
    <span class="social social-app-apple" style="height:1rem;"></span>
    ${identityProvider.type}
  </button>
[/#macro]

[#macro epicButton identityProvider clientId]
<button id="epicgames-login-button" class="epicgames login-button" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
  <div>
    <div class="icon">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="-97.07505 -187.74425 841.3171 1126.4655">
        <g transform="matrix(1.33333 0 0 -1.33333 -278.052 902.584)">
          <path d="M649.836 676.938h-397.22c-32.195 0-44.077-11.882-44.077-44.093V244.169c0-3.645.147-7.031.469-10.168.733-7.031.87-13.844 7.41-21.601.639-.76 7.315-5.728 7.315-5.728 3.59-1.761 6.043-3.058 10.093-4.688l195.596-81.948c10.154-4.655 14.4-6.47 21.775-6.323v-.001h.058c7.375-.145 11.62 1.669 21.776 6.324l195.595 81.948c4.05 1.63 6.502 2.927 10.094 4.688 0 0 6.676 4.968 7.314 5.728 6.539 7.757 6.677 14.57 7.41 21.6.322 3.138.47 6.524.47 10.169v388.676c0 32.21-11.883 44.093-44.078 44.093" fill="#2f2d2e" fill-rule="evenodd"/>
          <path d="M623.23 286.175l-.09-.897-.089-.985-.18-.897-.268-.896-.174-.807-.27-.897-.358-.807-.359-.718-.353-.806-.448-.717-.448-.718-.533-.717-.449-.717-.532-.627-.628-.628-.533-.538-.716-.628-.623-.538-.717-.538-.712-.442-.712-.538-.807-.448-.802-.359-.8-.448-.898-.359-.89-.359-.892-.268-.89-.27-.808-.268-.89-.18-.803-.179-.8-.179-.898-.18-.892-.089-.8-.09-.898-.09-.98-.09-.892-.089h-3.748l-.893.089h-.98l-.892.09-.896.09-.98.09-.892.179-.89.09-.898.179-.892.179-.89.18-.892.179-.896.268-.802.18-.89.269-.893.269-.806.359-.89.269-.803.268-.892.359-.806.359-.802.359-.802.442-.806.359-.802.449-.712.447-.807.449-.712.448-.717.448-.712.538-.712.538-.717.538-.713.538-.627.538-.712.627.538.717.622.628.538.718.623.717.538.627.532.717.628.718.532.627.628.717.533.628.627.717.533.718.538.627.622.717.538.718.622.627.538.717.712-.538.802-.538.717-.538.802-.538.717-.448.802-.537.711-.449.808-.358.711-.449.802-.359.807-.358.801-.359.803-.269.806-.358.891-.269.892-.269.801-.269.897-.18.891-.179.891-.179.981-.09.896-.179h.892l.98-.089h1.963l.981.089.897.179.801.18.802.179.717.269.623.358.717.538.532.628.36.718.27.806.087.897v.179l-.088 1.076-.359.897-.449.627-.622.538-.718.538-.712.358-.8.359-.898.359-1.07.447-.623.18-.71.179-.808.27-.802.179-.89.269-.898.179-.98.269-.892.179-.98.269-.892.179-.897.269-.89.18-.892.269-.807.268-.89.18-.803.269-.8.269-.808.269-.98.359-.892.359-.892.358-.896.359-.8.448-.893.448-.717.448-.802.448-.712.538-.717.448-.622.539-.627.627-.623.628-.538.628-.532.627-.449.627-.443.718-.448.806-.359.622-.269.718-.263.807-.269.717-.18.897-.179.807-.09.896-.089.897-.09.985v2.063l.09.896.09.807.09.897.178.806.18.807.27.808.178.806.353.807.36.807.357.806.444.808.447.806.533.718.54.717.621.717.627.627.623.718.717.628.622.448.717.538.713.538.711.448.807.448.802.359.801.448.807.358.891.27.891.358.807.269.712.18.803.179.806.179.891.179.802.18.891.089.897.09.891.09.891.089h3.839l.981-.089.981-.09h.891l.986-.09.891-.179.981-.09.892-.179.807-.179.891-.179.891-.18.802-.179.896-.269.802-.269.802-.18.896-.358.802-.269.801-.358.802-.359.896-.359.802-.448.712-.359.807-.448.802-.448.712-.449.806-.538.713-.447.717-.539.712-.538.711-.537-.532-.718-.448-.717-.533-.717-.538-.718-.532-.806-.449-.717-.538-.718-.533-.717-.447-.717-.534-.718-.537-.717-.449-.717-.532-.807-.539-.717-.532-.717-.448-.717-.533-.717-.717.537-.8.449-.714.448-.717.538-.8.358-.719.449-.8.359-.713.358-.807.359-.712.358-.8.269-.718.359-.982.268-.89.27-.892.268-.897.18-.89.179-.892.18-.89.09-.898.089-.8.09h-1.963l-.98-.179-.898-.18-.8-.179-.713-.359-.628-.358-.802-.718-.538-.807-.352-.807-.09-.896v-.18l.09-1.165.442-.986.36-.538.621-.628.807-.448.712-.448.891-.359.986-.359 1.071-.358.712-.179.712-.269.807-.179.801-.269.891-.18.987-.269.981-.268.981-.27.98-.179.891-.269.981-.269.897-.179.892-.269.891-.269.801-.269.897-.269.802-.269.801-.269.986-.353.891-.449.891-.358.892-.448.807-.449.802-.448.711-.448.717-.538.713-.448.712-.628.717-.627.622-.718.627-.627.533-.718.538-.806.443-.717.45-.808.357-.717.27-.806.263-.807.18-.807.178-.897.18-.897.09-.896.09-.986v-2.152zm-62.594-17.926h-51.142v65.258h51.586v-14.794h-34.543v-10.668H557.6v-13.891h-31.063v-11.116h34.991v-14.789zm-65.214 0H479.09v38.589l-.447-.717-.533-.813-.449-.717-.532-.718-.448-.806-.539-.718-.442-.717-.449-.812-.532-.717-.449-.717-.537-.718-.443-.812-.538-.717-.443-.717-.449-.807-.538-.722-.443-.718-.538-.806-.442-.718-.538-.717-.443-.812-.449-.718-.537-.717-.443-.807-.538-.722-.443-.717-.538-.718-.449-.806-.443-.722-.537-.718-.443-.807-.538-.717-.448-.717-.533-.813-.448-.717h-.354l-.537.807-.449.723-.533.807-.448.717-.533.806-.448.723-.532.807-.449.718-.538.806-.443.717-.538.813-.442.717-.538.807-.449.717-.532.812-.449.717-.532.807-.538.717-.448.812-.533.717-.448.807-.533.717-.448.813-.533.717-.448.807-.538.717-.443.807-.538.723-.443.806-.538.718-.448.807-.532.716-.45.813-.532.717v-38.409h-16.96v65.258h18.299l.443-.718.448-.806.532-.712.45-.807.447-.717.443-.808.448-.711.534-.808.447-.717.45-.717.442-.801.448-.718.533-.806.448-.718.448-.801.443-.717.538-.717.45-.803.441-.716.448-.807.444-.718.538-.801.448-.718.442-.806.45-.712.442-.717.538-.807.448-.718.443-.807.448-.712.443-.807.54-.717.447-.801.443-.718.448.718.448.801.533.717.447.807.444.712.448.807.533.718.448.807.45.717.441.712.538.806.443.718.45.801.446.718.533.807.448.716.45.803.441.717.45.717.532.801.448.718.448.806.444.718.537.801.444.717.447.717.45.808.531.711.45.808.441.717.45.807.537.712.443.806.448.718h18.294v-65.258zM391.863 295.14l-.269.812-.353.897-.359.807-.269.812-.353.807-.358.897-.27.812-.359.807-.352.806-.27.812-.359.897-.263.807-.359.812-.359.807-.268.807-.354.901-.358.808-.269.806-.359.812-.353.897-.269.812-.359.807-.353-.807-.268-.812-.359-.897-.359-.812-.264-.806-.358-.808-.359-.901-.353-.807-.27-.807-.358-.812-.359-.807-.264-.897-.358-.812-.359-.806-.268-.807-.354-.812-.359-.897-.358-.807-.263-.812-.359-.807-.359-.897-.269-.812-.353-.807h15.082zm28.03-26.891h-17.498l-.354.808-.269.807-.358.807-.359.896-.264.802-.358.806-.359.807-.264.807-.358.807-.359.807-.268.807-.354.896-.359.807-.269.807-.359.807h-25.613l-.354-.807-.269-.807-.359-.807-.358-.896-.264-.807-.358-.807-.359-.807-.269-.807-.353-.807-.359-.806-.269-.802-.354-.896-.358-.807-.269-.807-.359-.808h-18.024l.352.808.36.807.357.807.354.896.27.802.358.806.358.807.353.807.36.807.358.897.353.807.36.806.267.807.36.807.352.807.36.896.357.807.354.808.36.806.357.807.27.807.352.897.36.806.358.807.353.807.36.807.358.807.353.897.27.806.358.807.358.807.354.807.358.807.358.896.354.807.358.807.27.807.358.806.353.807.36.897.358.807.353.807.358.807.36.806.268.808.354.801.358.897.358.806.354.808.358.807.36.806.352.807.27.897.358.806.358.807.354.807.36.807.357.807.354.897.358.806.27.807.357.807.354.807.358.807.36.896.352.807.36.807.358.807.263.806.36.808.358.896.36.807.352.807.36.807.357.807.353.806.27.897.358.807.36.807.352.807h16.512l.358-.807.36-.807.353-.807.358-.897.27-.806.352-.807.36-.807.357-.807.36-.807.352-.896.36-.808.358-.806.263-.807.36-.807.358-.807.36-.896.352-.807.358-.807.36-.807.352-.807.27-.806.357-.897.354-.807.36-.807.357-.807.36-.807.352-.806.358-.897.27-.807.353-.806.358-.807.36-.808.358-.806.353-.897.36-.801.357-.808.264-.806.358-.807.36-.807.353-.807.358-.897.36-.807.358-.806.353-.807.27-.807.357-.807.354-.896.358-.807.36-.807.357-.807.354-.807.36-.806.267-.897.354-.807.358-.807.36-.807.352-.807.36-.806.358-.897.36-.807.262-.807.36-.806.358-.808.353-.807.358-.896.36-.807.357-.807.353-.807.27-.806.36-.807.352-.897.358-.807.358-.807.354-.807.358-.806.36-.802.27-.896.351-.807.36-.807.357-.808zm-78.193 8.334l-.717-.538-.623-.449-.717-.538-.712-.448-.712-.538-.717-.448-.712-.449-.807-.447-.802-.449-.802-.448-.806-.353-.802-.449-.89-.358-.802-.359-.897-.358-.8-.359-.804-.269-.806-.269-.802-.27-.89-.268-.802-.27-.897-.179-.802-.179-.89-.179-.897-.179-.892-.09-.98-.09-.892-.09-.98-.089-.898-.09-.98-.089h-3.84l-.89.089-.982.09-.89.089-.892.09-.897.09-.89.179-.893.18-.8.179-.897.179-.802.269-.89.179-.808.27-.802.358-.802.269-.89.359-.807.358-.802.358-.8.359-.809.448-.71.444-.803.448-.717.449-.712.447-.717.539-.712.537-.713.538-.627.538-.622.538-.628.628-.622.537-.628.628-.622.628-.538.627-.533.717-.538.628-.448.717-.533.718-.447.716-.444.718-.448.807-.448.717-.353.807-.359.807-.358.807-.354.806-.269.717-.359.808-.179.807-.264.806-.179.896-.269.808-.179.896-.09.807-.18.897-.088.806-.09.897-.085.897-.089.896v2.959l.09.986v.896l.083.897.091.986.18.891.088.897.18.807.268.896.18.897.263.807.27.896.268.807.36.897.353.806.358.807.36.807.352.807.448.807.448.717.444.718.447.717.45.717.531.717.538.717.533.717.538.629.622.627.538.628.623.626.627.629.622.537.717.628.623.538.712.538.717.448.712.538.718.448.711.448.802.449.807.448.801.448.802.359.806.358.892.449.712.268.891.27.808.358.801.18.801.269.896.179.802.269.891.179.892.09.896.179.892.09.89.089.892.09.897.09h3.833l.987-.09.981-.09h.891l.891-.089.981-.18.807-.089.891-.18.892-.179.806-.179.801-.179.803-.18.807-.269.801-.179.712-.269.807-.269.802-.358.801-.359.807-.359.802-.448.801-.359.718-.448.801-.448.712-.448.807-.449.712-.537.712-.449.717-.538.712-.538.717-.627.712-.538-.538-.718-.622-.627-.538-.717-.622-.717-.538-.718-.533-.627-.628-.717-.532-.717-.538-.629-.623-.717-.537-.717-.623-.717-.538-.628-.532-.717-.627-.717-.534-.717-.627-.628-.533-.717-.717.538-.712.627-.717.449-.712.538-.712.448-.717.449-.713.447-.8.449-.718.358-.712.359-.717.269-.802.269-.8.269-.808.179-.89.18-.892.179-.892.089-.98.09-.987.089h-1.872l-.89-.089-.808-.09-.89-.179-.803-.18-.807-.268-.8-.269-.803-.359-.802-.358-.717-.448-.71-.449-.719-.449-.622-.537-.628-.538-.622-.538-.538-.627-.622-.628-.538-.717-.444-.628-.448-.717-.442-.807-.449-.717-.358-.807-.269-.807-.354-.807-.269-.896-.179-.892-.179-.806-.18-.987-.089-.896-.084-.896v-2.063l.084-.896.09-.807.09-.897.178-.806.18-.808.18-.806.268-.807.264-.717.36-.896.357-.808.443-.807.448-.717.448-.717.533-.718.538-.627.622-.628.54-.627.62-.538.718-.538.712-.538.711-.448.717-.448.803-.359.801-.359.806-.358.892-.269.891-.269.897-.18.891-.179.891-.089.981-.09h2.051l.987.09.981.089.891.09.891.18.897.179.891.268.801.18.803.358.717.359.801.359.627.358.713.449v8.158h-13.032v13.084h29.454V277.12zM312.995 481.16h38.683v29.921h-38.683v61.086h40.223v29.922h-73.072V386.14h73.684v29.922h-40.835zm277.075-6.483v-48.744c0-8.639-3.993-12.647-12.278-12.647h-6.144c-8.595 0-12.588 4.008-12.588 12.647v136.362c0 8.638 3.993 12.646 12.588 12.646h5.527c8.29 0 12.283-4.008 12.283-12.646v-42.269h32.233v44.12c0 26.837-12.895 39.795-39.6 39.795h-15.97c-26.705 0-39.911-13.264-39.911-40.106V424.393c0-26.843 13.206-40.106 39.912-40.106h16.274c26.712 0 39.91 13.263 39.91 40.106v50.284zm-114.075-88.539h32.854V602.09h-32.854zm-47.669 120.008c0-8.639-3.987-12.652-12.277-12.652h-13.511v79.596h13.51c8.29 0 12.278-4.009 12.278-12.646zm-7.061 95.944h-51.577V386.138h32.85V464.5h18.727c26.71 0 39.91 13.263 39.91 40.1v57.384c0 26.842-13.2 40.106-39.91 40.106" fill="#fff"/>
          <path d="M357.642 190.875h188.054L449.71 159.22z" fill="#fff" fill-rule="evenodd"/>
        </g>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
  </div>
</button>
[/#macro]

[#macro facebookButton identityProvider clientId]
  <button type="button" id="facebook-login-button" data-login-method="${identityProvider.lookupLoginMethod(clientId)!''}" data-permissions="${identityProvider.lookupPermissions(clientId)!''}" data-identity-provider-id="${identityProvider.id}" class="facebook ${socialLoginButtonClasses}">
    <span class="social social-app-facebook" style="height:1rem;"></span>
    ${identityProvider.type}
  </button>
[/#macro]

[#macro googleButton identityProvider clientId idpRedirectState=""]
  [#-- When using this loginMethod - the Google JavaScript API is not used at all. --]
  [#if identityProvider.lookupLoginMethod(clientId) == "UseRedirect"]
  <button type="button" id="google-login-button"  data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}" class="google ${socialLoginButtonClasses}">
      <span class="social social-app-google" style="height:1rem;"></span>
      ${identityProvider.type}
  </button>

  [#else] [#-- UsePopup or UseVendorJavaScript --]
    [#--
     Use the Google Identity Service (GIS) API.
     https://developers.google.com/identity/gsi/web/reference/html-reference
    --]
    <div id="g_id_onload" [#list identityProvider.lookupAPIProperties(clientId)!{} as attribute, value] data-${attribute}="${value}" [/#list]
         data-client_id="${identityProvider.lookupClientId(clientId)}"
         data-callback="googleLoginCallback" >
    </div>
    [#-- This the Google Signin button. If only using One tap, you can delete or commment out this element --]
    <div class="g_id_signin" [#list identityProvider.lookupButtonProperties(clientId)!{} as attribute, value] data-${attribute}="${value}" [/#list]
         [#-- Optional click handler, when using ux_mode=popup. --]
         data-click_listener="googleButtonClickHandler" >
    </div>
  [/#if]
[/#macro]

[#macro linkedInButton identityProvider clientId]
<button type="button" id="linkedin-login-button" data-login-method="UseRedirect" data-identity-provider-id="${identityProvider.id}" class="linkedin ${socialLoginButtonClasses}">
  <span class="social social-app-linkedin" style="height:1rem;"></span>
  ${identityProvider.type}
</button>
 <button id="linkedin-login-button" class="linkedin login-button" data-login-method="UseRedirect" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon">
       <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
            viewBox="0 0 382 382" style="enable-background:new 0 0 382 382;" xml:space="preserve">
       <path style="fill:#0077B7;" d="M347.445,0H34.555C15.471,0,0,15.471,0,34.555v312.889C0,366.529,15.471,382,34.555,382h312.889
        C366.529,382,382,366.529,382,347.444V34.555C382,15.471,366.529,0,347.445,0z M118.207,329.844c0,5.554-4.502,10.056-10.056,10.056
        H65.345c-5.554,0-10.056-4.502-10.056-10.056V150.403c0-5.554,4.502-10.056,10.056-10.056h42.806
        c5.554,0,10.056,4.502,10.056,10.056V329.844z M86.748,123.432c-22.459,0-40.666-18.207-40.666-40.666S64.289,42.1,86.748,42.1
        s40.666,18.207,40.666,40.666S109.208,123.432,86.748,123.432z M341.91,330.654c0,5.106-4.14,9.246-9.246,9.246H286.73
        c-5.106,0-9.246-4.14-9.246-9.246v-84.168c0-12.556,3.683-55.021-32.813-55.021c-28.309,0-34.051,29.066-35.204,42.11v97.079
        c0,5.106-4.139,9.246-9.246,9.246h-44.426c-5.106,0-9.246-4.14-9.246-9.246V149.593c0-5.106,4.14-9.246,9.246-9.246h44.426
        c5.106,0,9.246,4.14,9.246,9.246v15.655c10.497-15.753,26.097-27.912,59.312-27.912c73.552,0,73.131,68.716,73.131,106.472
        L341.91,330.654L341.91,330.654z"/>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro nintendoButton identityProvider clientId]
<button id="nintendo-login-button" class="nintendo login-button" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
  <div>
    <div class="icon">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 192.756 192.756">
        <g>
          <path fill="#cc2131" d="M27.305 119.422c-14.669-.004-24.47-10.398-24.47-23.002 0-12.605 9.826-23.119 24.449-23.086h138.189c14.623-.033 24.449 10.481 24.449 23.086 0 12.604-9.803 22.998-24.473 23.002H27.305z"/>
          <path fill="#fff" d="M27.351 79.005c-11.613.02-18.743 7.783-18.743 17.384 0 9.6 7.084 17.424 18.743 17.381h138.052c11.658.043 18.746-7.781 18.746-17.381 0-9.601-7.131-17.363-18.746-17.384H27.351z"/>
          <path fill="#cc2131" d="M21.396 85.491h6.756l9.355 15.128-.005-15.128h6.705v21.698h-6.696L28.109 92.06v15.129h-6.716l.003-21.698zM80.674 87.725h6.53v2.919h3.533v2.143h-3.533l.004 14.402h-6.534l.003-14.402h-3.546v-2.141h3.548l-.005-2.921zM47.943 92.761h6.525v14.428h-6.525V92.761zM47.929 85.487h6.539v4.436h-6.539v-4.436zM164.898 99.859s-.004 2.178-.004 3.055c0 2.299-1.357 3.25-2.668 3.25-1.305 0-2.672-.951-2.672-3.25 0-.877.004-3.109.004-3.109s.006-2.133.006-3.01c0-2.29 1.361-3.232 2.662-3.232s2.668.942 2.668 3.232c0 .877 0 2.492.004 3.074v-.01zm-2.621-8.084c-5.264 0-9.531 3.628-9.531 8.104 0 4.473 4.268 8.1 9.531 8.1 5.27 0 9.537-3.627 9.537-8.1 0-4.476-4.267-8.104-9.537-8.104zM144.18 85.491h6.439v21.694h-6.449l-.004-.83c-2.494 1.566-5.316 1.562-7.512.541-.588-.275-4.463-2.135-4.463-7.152 0-3.812 3.596-7.969 8.295-7.557 1.549.138 2.648.702 3.693 1.287l.001-7.983zm.047 14.411v-2.578c0-2.232-1.539-2.8-2.555-2.8-1.041 0-2.561.568-2.561 2.8 0 .736.004 2.572.004 2.572s-.004 1.795-.004 2.564c0 2.23 1.52 2.812 2.561 2.812 1.016 0 2.555-.582 2.555-2.812v-2.558zM69.741 92.094c2.438-.067 7.39 1.53 7.354 7.244-.007 1.012-.002 7.848-.002 7.848h-6.482v-9.475c0-1.259-1.203-2.658-2.979-2.658-1.779 0-3.099 1.399-3.099 2.658l.007 9.475h-6.479l-.005-14.427 6.483-.005s-.007 1.162 0 1.516a7.872 7.872 0 0 1 5.202-2.176zM122.768 92.094c2.434-.067 7.385 1.53 7.354 7.244-.01 1.012-.006 7.848-.006 7.848h-6.482v-9.475c0-1.259-1.201-2.658-2.979-2.658s-3.102 1.399-3.102 2.658l.01 9.475h-6.477l.004-14.427 6.473-.005s-.01 1.162 0 1.516a7.869 7.869 0 0 1 5.205-2.176zM96.816 97.789c-.012-1.262.014-2.106.428-2.832.514-.888 1.451-1.311 2.299-1.315h-.004c.854.004 1.785.427 2.295 1.315.414.725.438 1.57.428 2.832h-5.446zm5.418 4.352s.006.064.006.877c0 2.639-1.736 3.227-2.697 3.227-.965 0-2.732-.588-2.732-3.227 0-.793.01-2.98.01-2.98s12.287.004 12.287 0c0-4.476-4.318-8.183-9.625-8.183-5.304 0-9.607 3.628-9.607 8.099 0 4.477 4.303 8.105 9.607 8.105 4.402 0 8.119-2.514 9.258-5.924l-6.507.006zM172.268 90.654h-.752v-4.941h1.885c1.164 0 1.744.431 1.744 1.404 0 .883-.555 1.268-1.283 1.361l1.404 2.176h-.836l-1.305-2.143h-.857v2.143zm.894-2.778c.635 0 1.197-.044 1.197-.804 0-.611-.555-.726-1.072-.726h-1.02v1.53h.895z"/>
          <path fill="#cc2131" d="M168.82 88.17c0-2.458 1.996-4.271 4.352-4.271 2.336 0 4.326 1.814 4.326 4.271 0 2.483-1.99 4.295-4.326 4.295-2.356 0-4.352-1.811-4.352-4.295zm4.352 3.581c1.939 0 3.465-1.518 3.465-3.581 0-2.026-1.525-3.558-3.465-3.558-1.959 0-3.488 1.532-3.488 3.558 0 2.064 1.529 3.581 3.488 3.581z"/>
        </g>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
  </div>
</button>
[/#macro]

[#macro twitterButton identityProvider clientId]
 <button id="twitter-login-button" class="twitter login-button">
   <div>
     <div class="icon">
       <svg version="1.1" viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg">
         <g>
           <rect class="cls-1" width="400" height="400"></rect>
         </g>
         <g>
           <path class="cls-2" d="M153.62,301.59c94.34,0,145.94-78.16,145.94-145.94,0-2.22,0-4.43-.15-6.63A104.36,104.36,0,0,0,325,122.47a102.38,102.38,0,0,1-29.46,8.07,51.47,51.47,0,0,0,22.55-28.37,102.79,102.79,0,0,1-32.57,12.45,51.34,51.34,0,0,0-87.41,46.78A145.62,145.62,0,0,1,92.4,107.81a51.33,51.33,0,0,0,15.88,68.47A50.91,50.91,0,0,1,85,169.86c0,.21,0,.43,0,.65a51.31,51.31,0,0,0,41.15,50.28,51.21,51.21,0,0,1-23.16.88,51.35,51.35,0,0,0,47.92,35.62,102.92,102.92,0,0,1-63.7,22A104.41,104.41,0,0,1,75,278.55a145.21,145.21,0,0,0,78.62,23"></path>
           <rect class="cls-3" width="400" height="400"></rect>
         </g>
       </svg>
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro openIDConnectButton identityProvider clientId]
 <button class="openid login-button" data-login-method="UseRedirect" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon">
       [#if identityProvider.lookupButtonImageURL(clientId)?has_content]
         <img src="${identityProvider.lookupButtonImageURL(clientId)}" title="OpenID Connect Logo" alt="OpenID Connect Logo"/>
       [#else]
         <svg version="1.1" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
           <g id="g2189">
             <g id="g2202">
               <path class="cls-1" d="M87.57,39.57c-8.9-5.55-21.38-9-34.95-9C25.18,30.59,3,44.31,3,61.17,3,76.64,21.46,89.34,45.46,91.52v-8.9c-16.12-2-28.24-10.87-28.24-21.45,0-12,15.84-21.9,35.4-21.9,9.78,0,18.6,2.41,24.95,6.43l-9,5.62H96.84V33.8Z"></path>
               <path class="cls-2" d="M45.46,15.41v76l14.23-8.9V6.22Z"></path>
             </g>
           </g>
         </svg>
       [/#if]
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro samlv2Button identityProvider clientId]
 <button class="samlv2 login-button" data-login-method="UseRedirect" data-identity-provider-id="${identityProvider.id}">
   <div>
     <div class="icon">
       [#if identityProvider.lookupButtonImageURL(clientId)?has_content]
         <img src="${identityProvider.lookupButtonImageURL(clientId)}" title="SAML Login" alt="SAML Login"/>
       [#else]
         <img src="/images/identityProviders/samlv2.svg" title="SAML 2 Logo" alt="SAML 2 Logo"/>
       [/#if]
     </div>
     <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
   </div>
 </button>
[/#macro]

[#macro sonypsnButton identityProvider clientId]
<button id="sonypsn-login-button" class="sonypsn login-button" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
  <div>
    <div class="icon">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="-6.003495 -7.75 52.03029 46.5">
        <path fill="#0070d1" d="M.81 22.6c-1.5 1-1 2.9 2.2 3.8 3.3 1.1 6.9 1.4 10.4.8.2 0 .4-.1.5-.1v-3.4l-3.4 1.1c-1.3.4-2.6.5-3.9.2-1-.3-.8-.9.4-1.4l6.9-2.4v-3.7l-9.6 3.3c-1.2.4-2.4 1-3.5 1.8zm23.2-15v9.7c4.1 2 7.3 0 7.3-5.2 0-5.3-1.9-7.7-7.4-9.6-2.9-1-5.9-1.9-8.9-2.5v28.9l7 2.1V6.7c0-1.1 0-1.9.8-1.6 1.1.3 1.2 1.4 1.2 2.5zm13 12.7c-2.9-1-6-1.4-9-1.1-1.6.1-3.1.5-4.5 1l-.3.1v3.9l6.5-2.4c1.3-.4 2.6-.5 3.9-.2 1 .3.8.9-.4 1.4l-10 3.7v3.8l13.8-5.1c1-.4 1.9-.9 2.7-1.7.7-1 .4-2.4-2.7-3.4z"/>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
  </div>
</button>
[/#macro]

[#macro steamButton identityProvider clientId]
<button id="steam-login-button" class="steam login-button" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
  <div>
    <div class="icon">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 233 233">
       <defs>
        <linearGradient id="a" x2="50%" x1="50%" y2="100%">
         <stop stop-color="#111D2E" offset="0"/>
         <stop stop-color="#051839" offset=".21248"/>
         <stop stop-color="#0A1B48" offset=".40695"/>
         <stop stop-color="#132E62" offset=".58110"/>
         <stop stop-color="#144B7E" offset=".73760"/>
         <stop stop-color="#136497" offset=".87279"/>
         <stop stop-color="#1387B8" offset="1"/>
        </linearGradient>
       </defs>
       <path fill="url(#a)" d="m4.8911 150.01c14.393 48.01 58.916 82.99 111.61 82.99 64.34 0 116.5-52.16 116.5-116.5 0-64.341-52.16-116.5-116.5-116.5-61.741 0-112.26 48.029-116.25 108.76 7.5391 12.66 10.481 20.49 4.6411 41.25z"/>
       <path fill="#fff" d="m110.5 87.322c0 0.196 0 0.392 0.01 0.576l-28.508 41.412c-4.618-0.21-9.252 0.6-13.646 2.41-1.937 0.79-3.752 1.76-5.455 2.88l-62.599-25.77c0.00049 0-1.4485 23.83 4.588 41.59l44.254 18.26c2.222 9.93 9.034 18.64 19.084 22.83 16.443 6.87 35.402-0.96 42.242-17.41 1.78-4.3 2.61-8.81 2.49-13.31l40.79-29.15c0.33 0.01 0.67 0.02 1 0.02 24.41 0 44.25-19.9 44.25-44.338 0-24.44-19.84-44.322-44.25-44.322-24.4 0-44.25 19.882-44.25 44.322zm-6.84 83.918c-5.294 12.71-19.9 18.74-32.596 13.45-5.857-2.44-10.279-6.91-12.83-12.24l14.405 5.97c9.363 3.9 20.105-0.54 23.997-9.9 3.904-9.37-0.525-20.13-9.883-24.03l-14.891-6.17c5.746-2.18 12.278-2.26 18.381 0.28 6.153 2.56 10.927 7.38 13.457 13.54s2.52 12.96-0.04 19.1m51.09-54.38c-16.25 0-29.48-13.25-29.48-29.538 0-16.275 13.23-29.529 29.48-29.529 16.26 0 29.49 13.254 29.49 29.529 0 16.288-13.23 29.538-29.49 29.538m-22.09-29.583c0-12.253 9.92-22.191 22.14-22.191 12.23 0 22.15 9.938 22.15 22.191 0 12.254-9.92 22.183-22.15 22.183-12.22 0-22.14-9.929-22.14-22.183z"/>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
  </div>
</button>
[/#macro]

[#macro twitchButton identityProvider clientId]
<button id="twitch-login-button" class="twitch login-button" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
  <div>
    <div class="icon">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2400 2800">
        <g>
          <polygon fill="#FFFFFF" points="2200,1300 1800,1700 1400,1700 1050,2050 1050,1700 600,1700 600,200 2200,200"/>
          <g>
            <g fill="#9146FF">
              <path d="M500,0L0,500v1800h600v500l500-500h400l900-900V0H500z M2200,1300l-400,400h-400l-350,350v-350H600V200h1600 V1300z"/>
              <rect x="1700" y="550" width="200" height="600"/>
              <rect x="1150" y="550" width="200" height="600"/>
            </g>
          </g>
        </g>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
  </div>
</button>
[/#macro]

[#macro xboxButton identityProvider clientId]
<button id="xbox-login-button" class="xbox login-button" data-login-method="UseRedirect" data-scope="${identityProvider.lookupScope(clientId)!''}" data-identity-provider-id="${identityProvider.id}">
  <div>
    <div class="icon">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="-12.90591 -21.521775 111.85122 129.13065">
        <path d="M38.7297 85.9103c-6.628-.635-13.338-3.015-19.102-6.776-4.83-3.15-5.92-4.447-5.92-7.032 0-5.193 5.71-14.29 15.48-24.658 5.547-5.89 13.275-12.79 14.11-12.604 1.626.363 14.616 13.034 19.48 19 7.69 9.43 11.224 17.154 9.428 20.597-1.365 2.617-9.837 7.733-16.06 9.698-5.13 1.62-11.867 2.306-17.416 1.775zm-31.546-19.207c-4.014-6.158-6.042-12.22-7.02-20.988-.324-2.895-.21-4.55.733-10.494 1.173-7.4 5.39-15.97 10.46-21.24 2.158-2.24 2.35-2.3 4.982-1.41 3.19 1.08 6.6 3.436 11.89 8.22l3.09 2.794-1.69 2.07c-7.828 9.61-16.09 23.24-19.2 31.67-1.69 4.58-2.37 9.18-1.64 11.095.49 1.294.04.812-1.61-1.714zm70.453 1.047c.397-1.936-.105-5.49-1.28-9.076-2.545-7.765-11.054-22.21-18.867-32.032l-2.46-3.092 2.662-2.443c3.474-3.19 5.886-5.1 8.49-6.723 2.053-1.28 4.988-2.413 6.25-2.413.777 0 3.516 2.85 5.726 5.95 3.424 4.8 5.942 10.63 7.218 16.69.825 3.92.894 12.3.133 16.21-.63 3.208-1.95 7.366-3.23 10.187-.97 2.113-3.36 6.218-4.41 7.554-.54.687-.54.686-.24-.796zm-38.197-57.245c-3.606-1.83-9.168-3.795-12.24-4.325-1.076-.185-2.913-.29-4.08-.23-2.536.128-2.423-.004 1.643-1.925 3.38-1.597 6.2-2.536 10.03-3.34 4.305-.905 12.4-.915 16.637-.022 4.575.965 9.964 2.97 13 4.84l.904.554-2.07-.104c-4.116-.208-10.114 1.455-16.554 4.587-1.942.946-3.63 1.7-3.754 1.68-.123-.024-1.706-.795-3.52-1.715z" fill="#107c10"/>
      </svg>
    </div>
    <div class="text">${identityProvider.lookupButtonText(clientId)?trim}</div>
  </div>
</button>
[/#macro]

[#macro alternativeLogins clientId identityProviders passwordlessEnabled bootstrapWebauthnEnabled=false idpRedirectState="" federatedCSRFToken=""]
  [#if identityProviders?has_content || passwordlessEnabled || bootstrapWebauthnEnabled]

    <div id="login-button-container" class="flex flex-col gap-6 login-button-container" data-federated-csrf="${federatedCSRFToken}">
    
      <div class="flex flex-row justify-stretch gap-6 py-2">
        [#if identityProviders["Apple"]?has_content]
        <div>
          [@appleButton identityProvider=identityProviders["Apple"][0] clientId=clientId/]
        </div>
        [/#if]

        [#if identityProviders["EpicGames"]?has_content]
          <div class="form-row push-less-top">
            [@epicButton identityProvider=identityProviders["EpicGames"][0] clientId=clientId/]
          </div>
        [/#if]

        [#if identityProviders["Facebook"]?has_content]
        <div>
          [@facebookButton identityProvider=identityProviders["Facebook"][0] clientId=clientId /]
        </div>
        [/#if]

        [#if identityProviders["Google"]?has_content]
        <div>
          [@googleButton identityProvider=identityProviders["Google"][0] clientId=clientId idpRedirectState=idpRedirectState/]
        </div>
        <div>
          [@googleButton identityProvider=identityProviders["Google"][0] clientId=clientId idpRedirectState=idpRedirectState/]
        </div>
        <div>
          [@googleButton identityProvider=identityProviders["Google"][0] clientId=clientId idpRedirectState=idpRedirectState/]
        </div>
        <div>
          [@googleButton identityProvider=identityProviders["Google"][0] clientId=clientId idpRedirectState=idpRedirectState/]
        </div>
        [/#if]

        [#if identityProviders["LinkedIn"]?has_content]
        <div>
          [@linkedInButton identityProvider=identityProviders["LinkedIn"][0] clientId=clientId/]
        </div>
        [/#if]

        [#if identityProviders["Nintendo"]?has_content]
          <div class="form-row push-less-top">
            [@nintendoButton identityProvider=identityProviders["Nintendo"][0] clientId=clientId/]
          </div>
        [/#if]

        [#if identityProviders["OpenIDConnect"]?has_content]
          [#list identityProviders["OpenIDConnect"] as identityProvider]
            <div class="form-row push-less-top">
              [@openIDConnectButton identityProvider=identityProvider clientId=clientId/]
            </div>
          [/#list]
        [/#if]

        [#if identityProviders["SAMLv2"]?has_content]
          [#list identityProviders["SAMLv2"] as identityProvider]
            <div class="form-row push-less-top">
              [@samlv2Button identityProvider=identityProvider clientId=clientId/]
            </div>
          [/#list]
        [/#if]

        [#if identityProviders["SonyPSN"]?has_content]
          <div class="form-row push-less-top">
            [@sonypsnButton identityProvider=identityProviders["SonyPSN"][0] clientId=clientId/]
          </div>
        [/#if]

        [#if identityProviders["Steam"]?has_content]
          <div class="form-row push-less-top">
            [@steamButton identityProvider=identityProviders["Steam"][0] clientId=clientId/]
          </div>
        [/#if]

        [#if identityProviders["Twitch"]?has_content]
          <div class="form-row push-less-top">
            [@twitchButton identityProvider=identityProviders["Twitch"][0] clientId=clientId/]
          </div>
        [/#if]

        [#if identityProviders["Twitter"]?has_content]
        <div class="form-row push-less-top">
          [@twitterButton identityProvider=identityProviders["Twitter"][0] clientId=clientId/]
        </div>
        [/#if]

        [#if identityProviders["Xbox"]?has_content]
        <div class="form-row push-less-top">
          [@xboxButton identityProvider=identityProviders["Xbox"][0] clientId=clientId/]
        </div>
        [/#if]
      
      </div>

      [#if passwordlessEnabled]
      <div class="flex flex-col items-center text-center">
        [@link url = "/oauth2/passwordless" class="w-full"]
          [@helpers.button text=theme.message("passwordless-button-text") styleAs="primary" /]
        [/@link]
      </div>
      [/#if]

      [#if bootstrapWebauthnEnabled]
      <div class="form-row push-less-top">
        [@link url = "/oauth2/webauthn"]
          <div class="magic login-button">
            <div>
              <div class="icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="512.000000pt" height="512.000000pt" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">
                  <g transform="translate(0.000000,512.000000) scale(0.100000,-0.100000)" fill="#FFF" stroke="none">
                    <path d="M923 4595 c-187 -51 -349 -214 -398 -402 -12 -44 -15 -122 -15 -348 0 -261 2 -294 19 -331 51 -112 193 -135 276 -43 19 21 37 49 40 61 2 13 6 160 7 328 3 338 5 345 72 386 28 17 58 19 336 22 168 1 315 5 328 7 12 3 40 21 61 40 92 83 69 225 -43 276 -37 17 -70 19 -336 18 -221 0 -308 -4 -347 -14z"/>
                    <path d="M3514 4591 c-112 -51 -135 -193 -43 -276 21 -19 49 -37 61 -40 13 -2 160 -6 328 -7 338 -3 345 -5 386 -72 17 -28 19 -58 22 -336 1 -168 5 -315 7 -328 3 -12 21 -40 40 -61 83 -92 225 -69 276 43 17 37 19 70 19 331 0 320 -5 355 -61 468 -42 82 -154 194 -236 236 -113 56 -148 61 -468 61 -261 0 -294 -2 -331 -19z"/>
                    <path d="M1640 3229 c-14 -6 -36 -20 -48 -32 -49 -46 -52 -62 -52 -294 0 -193 2 -222 19 -253 48 -91 175 -117 252 -53 61 51 69 86 69 298 0 105 -4 206 -10 224 -11 39 -51 86 -92 107 -31 16 -101 17 -138 3z"/>
                    <path d="M2500 3233 c-36 -15 -72 -48 -90 -83 -19 -37 -20 -60 -20 -398 l0 -359 -31 -7 c-79 -15 -139 -89 -139 -170 0 -48 31 -109 72 -138 47 -33 153 -33 220 0 70 35 140 103 179 174 l34 63 3 397 c3 382 2 399 -17 437 -30 57 -73 84 -140 88 -31 1 -63 0 -71 -4z"/>
                    <path d="M3335 3222 c-44 -29 -74 -65 -85 -103 -6 -19 -10 -119 -10 -224 0 -212 8 -247 69 -298 77 -64 204 -38 252 53 17 31 19 60 19 256 0 213 -1 222 -22 254 -37 54 -71 73 -135 77 -45 3 -65 0 -88 -15z"/>
                    <path d="M2006 1870 c-34 -11 -82 -54 -102 -92 -19 -37 -18 -106 4 -148 34 -69 212 -173 387 -226 84 -26 102 -28 265 -28 163 0 181 2 265 28 175 53 353 157 387 226 70 139 -75 297 -213 231 -24 -11 -72 -38 -107 -60 -99 -62 -169 -83 -302 -88 -165 -7 -265 22 -421 122 -60 39 -114 50 -163 35z"/>
                    <path d="M627 1696 c-50 -18 -76 -42 -98 -91 -17 -36 -19 -70 -19 -330 0 -320 5 -355 61 -468 42 -82 154 -194 236 -236 113 -56 148 -61 468 -61 261 0 294 2 331 19 112 51 135 193 43 276 -21 19 -49 37 -61 40 -13 2 -160 6 -328 7 -435 4 -403 -29 -410 423 -3 217 -9 326 -17 340 -19 33 -66 72 -102 84 -43 14 -57 13 -104 -3z"/>
                    <path d="M4385 1698 c-33 -11 -80 -51 -98 -83 -8 -14 -14 -123 -17 -340 -7 -452 25 -419 -410 -423 -168 -1 -315 -5 -328 -7 -12 -3 -40 -21 -61 -40 -92 -83 -69 -225 43 -276 37 -17 70 -19 331 -19 320 0 355 5 468 61 82 42 194 154 236 236 56 113 61 148 61 468 0 260 -2 294 -19 330 -22 49 -48 73 -98 91 -45 16 -67 16 -108 2z"/>
                  </g>
                </svg>
              </div>
              <div class="text">${theme.message('webauthn-button-text')}</div>
            </div>
          </div>
        [/@link]
      </div>
      [/#if]

    </div>
    
  [/#if]
[/#macro]

[#-- Below are the helpers for errors and alerts --]

[#macro printErrorAlerts rowClass colClass]
  [#if errorMessages?size > 0]
    [#list errorMessages as m]
      [@alert message=m type="error" icon="exclamation-circle" rowClass=rowClass colClass=colClass/]
    [/#list]
  [/#if]
[/#macro]

[#macro printInfoAlerts rowClass colClass]
  [#if infoMessages?size > 0]
    [#list infoMessages as m]
      [@alert message=m type="info" icon="info-circle" rowClass=rowClass colClass=colClass/]
    [/#list]
  [/#if]
[/#macro]

[#macro alert message type icon includeDismissButton=true rowClass="row center-xs" colClass="col-xs col-sm-8 col-md-6 col-lg-5 col-xl-4"]
<div class="${rowClass}">
  <div class="${colClass}">
    <div class="alert ${type}">
      <i class="fa fa-${icon}"></i>
      <p>
        ${message}
      </p>
      [#if includeDismissButton]
        <a href="#" class="dismiss-button"><i class="fa fa-times-circle"></i></a>
      [/#if]
    </div>
  </div>
</div>
[/#macro]

[#-- Below are the input helpers for hidden, text, buttons, labels and form errors.
     These fields are general purpose and can be used on any form you like. --]

[#-- Hidden Input --]
[#macro hidden name value="" dateTimeFormat=""]
  [#if !value?has_content]
    [#local value=("((" + name + ")!'')")?eval?string/]
  [/#if]
  <input type="hidden" name="${name}" [#if value == ""]value="${value}" [#else]value="${value?string}"[/#if]/>
  [#if dateTimeFormat != ""]
  <input type="hidden" name="${name}@dateTimeFormat" value="${dateTimeFormat}"/>
  [/#if]
[/#macro]

[#-- Input field of type. --]
[#macro input type name id autocapitalize="none" autocomplete="on" autocorrect="off" autofocus=false spellcheck="false" label="" placeholder="" leftAddon="" required=false tooltip="" disabled=false class="" dateTimeFormat="" value="" uncheckedValue="" labelClass=""]
<div class="form-row grid gap-3">
  [#if type == "checkbox"]
    [@_input_checkbox name=name value=value uncheckedValue=uncheckedValue label=label tooltip=tooltip labelClass=labelClass]
     [#nested]
    [/@_input_checkbox]
  [#else]
    [@_input_text type=type name=name id=id autocapitalize=autocapitalize autocomplete=autocomplete autocorrect=autocorrect autofocus=autofocus spellcheck=spellcheck label=label placeholder=placeholder leftAddon=leftAddon required=required tooltip=tooltip disabled=disabled class="flex h-10 w-full rounded-md border border-gray-300 bg-white px-3 py-2 text-sm ring-offset-white file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-gray-500 focus-visible:outline-none disabled:cursor-not-allowed disabled:opacity-50" labelClass="text-sm font-medium leading-none ${class}" dateTimeFormat=dateTimeFormat labelClass=labelClass/]
  [/#if]
  [@errors field=name/]
</div>
[/#macro]

[#macro _input_text type name id autocapitalize autocomplete autocorrect autofocus spellcheck label placeholder leftAddon required tooltip disabled class dateTimeFormat labelClass]
  [#if label?has_content]
  [#compress]
    <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error text-pink-700 text-sm font-medium leading-none ${labelClass}"[#else] class="text-sm font-medium leading-none ${labelClass}" [/#if]>${label}[#if required] <span class="text-pink-700 required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
    </label>
  [/#compress]
  [/#if]
  [#if leftAddon?has_content]
  <div class="input-addon-group">
    <span class="icon"><i class="fa fa-${leftAddon}"></i></span>
  [/#if]
  [#local value=("((" + name + ")!'')")?eval/]
  [#if (placeholder?has_content) && (type == "date") && (value == "")]
    [#-- If the value is empty, we want to show the placeholder. This is a workaround for the date picker. --]
    [#assign the_type="text" /]
    [#assign the_class=class + " date-picker" /]
    [#-- it is possible that this element is the first in the form list. We want it to focus on something else so that the placeholder shows. --]
    <input type="text" style="display:none" autofocus="autofocus" />
  [#else ]
    [#assign the_type=type /]
    [#assign the_class=class /]
  [/#if]
  [#if (fieldMessages[name]![])?size > 0]
    [#assign the_class=the_class + " border-pink-700 focus:border-pink-700 focus-visible:ring-2 focus-visible:ring-pink-700" /]
  [#else]
    [#assign the_class=the_class + " focus-visible:ring-2 focus-visible:ring-gray-400" /]
  [/#if]
  <input id="${id}" type="${the_type}" name="${name}" [#if type != "password"]value="${value}"[/#if] class="${the_class}" autocapitalize="${autocapitalize}" autocomplete="${autocomplete}" autocorrect="${autocorrect}" spellcheck="${spellcheck}" [#if autofocus]autofocus="autofocus"[/#if] placeholder="${placeholder}" [#if disabled]disabled="disabled"[/#if]/>
  [#if dateTimeFormat != ""]
    <input type="hidden" name="${name}@dateTimeFormat" value="${dateTimeFormat}"/>
  [#elseif type == "date"]
    <input type="hidden" name="${name}@dateTimeFormat" value="yyyy-MM-dd"/>
  [/#if]
  [#if leftAddon?has_content]
  </div>
  [/#if]
[/#macro]

[#macro _input_checkbox name value uncheckedValue label tooltip labelClass]
<label class="text-sm font-medium leading-none ${labelClass}">
  [#local actualValue = ("((" + name + ")!'')")?eval/]
  [#local checked = actualValue?is_boolean?then(actualValue == value?boolean, actualValue == value)/]
  [#if uncheckedValue?has_content]
  <input type="hidden" name="__cb_${name}" value="${uncheckedValue}"/>
  [/#if]
  <input type="checkbox" name=${name} value="${value}" [#if checked]checked=checked[/#if]/>
  &nbsp; ${label?has_content?then(label, theme.message(name))}
  [#nested/]
  [#if tooltip?has_content]
    <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
  [/#if]
</label>
[/#macro]

[#-- Select --]
[#macro select name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="select" options=[]]
<div class="form-row">
  [#if label?has_content]
  [#compress]
    <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
    </label>
  [/#compress]
  [/#if]
  <label class="select">
    [#local value=("((" + name + ")!'')")?eval/]
    [#if name == "user.timezone" || name == "registration.timezone"]
      <select id="${id}" class="${class}" name="${name}">
        [#list timezones as option]
          [#local selected = value == option/]
          <option value="${option}" [#if selected]selected="selected"[/#if] >${option}</option>
        [/#list]]
      </select>
    [#else]
    <select id="${id}" class="${class}" name="${name}">
      [#list options as option]
        [#local selected = value == option/]
        <option value="${option}" [#if selected]selected="selected"[/#if] >${theme.optionalMessage(option)}</option>
      [/#list]
    </select>
    [/#if]
  </label>
  [@errors field=name/]
</div>
[/#macro]

[#-- Text Area --]
[#macro textarea name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="textarea" placeholder=""]
<div class="form-row">
  <textarea id="${id}" name="${name}" class="${class}">${(name?eval!'')}</textarea>
  [@errors field=name/]
</div>
[/#macro]

[#-- Begin : Used for Advanced Registration.
     The following form controls require a 'field' argument which is only available during registration. --]

[#-- Radio List --]
[#macro radio_list field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="radio-list" options=[]]
<div class="form-row">
  [#if label?has_content]
  [#compress]
  <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if]
    [#if tooltip?has_content]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>
    [/#if]
  </label>
  [/#compress]
  [/#if]
  [#local value=("((" + name + ")!'')")?eval/]
  <div id="${id}" class="${class}">
    [#list options as option]
      [#local checked = value == option/]
      [#if field.type == "consent"]
        [#local checked = consents(field.consentId)?? && consents(field.consentId)?contains(option)]
      [/#if]
      <label class="radio"><input type="radio" name="${name}" value="${option}" [#if checked]checked="checked"[/#if]><span class="box"></span><span class="label">${theme.optionalMessage(option)}</span></label>
    [/#list]
  </div>
  [@errors field=name/]
</div>
[/#macro]

[#macro checkbox field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="checkbox"]
<div class="form-row">
   <label class="${class}">
     [#local value=("((" + name + ")!'')")?eval/]
     [#local checked = value?has_content]
     [#if field.type == "consent"]
       [#local checked = consents(field.consentId)??]
     [/#if]
     <input id="${id}" type="checkbox" name="${name}" value="${value}" [#if checked]checked="checked"[/#if]>
       <span class="box"></span>
       <span class="label">${theme.optionalMessage(name)}</span>
   </label>
  [@errors field=name/]
</div>
[/#macro]

[#macro checkbox_list field name id autocapitalize="none" autofocus=false label="" required=false tooltip="" disabled=false class="checkbox-list" options=[]]
<div class="form-row">
  [#if label?has_content][#t/]
  <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if][#t/]
    [#if tooltip?has_content][#t/]
      <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>[#t/]
    [/#if][#t/]
  </label>[#t/]
  [/#if]
  <div id="${id}" class="${class}">
    [#list options as option]
      [#local value=("((" + name + ")!'')")?eval/]
      [#local checked = value?is_sequence && value?seq_contains(option)/]
      [#if field.type == "consent"]
        [#local checked = consents(field.consentId)?? && consents(field.consentId)?contains(option)]
      [/#if]
      <label class="checkbox"><input type="checkbox" name="${name}" value="${option}" [#if checked]checked="checked"[/#if]><span class="box"></span><span class="label">${theme.optionalMessage(option)}</span></label>
    [/#list]
  </div>
  [@errors field=name/]
</div>
[/#macro]

[#macro locale_select field name id autofocus=false label="" required=false tooltip="" class="select"]
  [#-- Note: This is a simple imlementation that does not support selecting more than one locale.
             You may wish to use a multi-select or some other JavaScript widget to allow for more than one selection and to improve UX --]
  [#local value=("((" + name + ")!'')")?eval/]
  <div class="form-row">
    [#if label?has_content][#t/]
    <label for="${id}"[#if (fieldMessages[name]![])?size > 0] class="error"[/#if]>${label}[#if required] <span class="required">*</span>[/#if][#t/]
      [#if tooltip?has_content][#t/]
        <i class="fa fa-info-circle" data-tooltip="${tooltip}"></i>[#t/]
      [/#if][#t/]
    </label>[#t/]
    [/#if]
    <label class="select">
      <select name="${name}" id="${id}" class="${class}" [#if autofocus]autofocus="autofocus"[/#if]>
        <option value="">${theme.optionalMessage("none-selected")}</option>
      [#list fusionAuth.locales() as l, n]
        [#local checked = value?is_sequence && value?seq_contains(l)/]
        <option  value="${l}" [#if checked]selected[/#if]>${l.getDisplayName()}</option>
      [/#list]
     </select>
   </label>
   [@errors field=name/]
  </div>
[/#macro]

[#-- End : Used for Advanced Registration. --]

[#macro oauthHiddenFields]
  [@hidden name="captcha_token"/]
  [@hidden name="client_id"/]
  [@hidden name="code_challenge"/]
  [@hidden name="code_challenge_method"/]
  [@hidden name="metaData.device.name"/]
  [@hidden name="metaData.device.type"/]
  [@hidden name="nonce"/]
  [@hidden name="oauth_context"/]
  [@hidden name="pendingIdPLinkId"/]
  [@hidden name="redirect_uri"/]
  [@hidden name="response_mode"/]
  [@hidden name="response_type"/]
  [@hidden name="scope"/]
  [@hidden name="state"/]
  [@hidden name="tenantId"/]
  [@hidden name="timezone"/]
  [@hidden name="user_code"/]
[/#macro]

[#macro errors field]
[#if fieldMessages[field]?has_content]
<span class="error text-pink-700 text-xs leading-none">[#list fieldMessages[field] as message]${message?no_esc}[#if message_has_next], [/#if][/#list]</span>
[/#if]
[/#macro]

[#assign primaryButtonClasses = "inline-flex h-10 px-4 py-2 w-full items-center justify-center whitespace-nowrap rounded-md text-sm font-medium text-white bg-fuchsia-900 hover:bg-gray-800 transition-colors ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-gray-400 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50" ]
[#assign blackButtonClasses = "inline-flex h-10 px-4 py-2 w-full items-center justify-center whitespace-nowrap rounded-md text-sm font-medium text-white bg-black hover:bg-gray-800 transition-colors ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-gray-400 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50" ]

[#macro button text icon="" color="blue" disabled=false name="" value="" class="" styleAs=""]
[#if styleAs == "primary"]
  [#assign the_class = class + " " + primaryButtonClasses /]
[#elseif styleAs == "black"]
  [#assign the_class = class + " " + blackButtonClasses /]
[#else]
  [#assign the_class = class /]
[/#if]
<button class="${color} button${disabled?then(' disabled', '')} ${the_class}"[#if disabled] disabled="disabled"[/#if][#if name !=""]name="${name}"[/#if][#if value !=""]value="${value}"[/#if]> [#if icon != ""]<i class="fa fa-${icon}"></i>[/#if] ${text}</button>
[/#macro]

[#macro link url extraParameters="" class=""]
<a href="${url}?tenantId=${(tenantId)!''}&client_id=${(client_id)!''}&nonce=${(nonce?url)!''}&pendingIdPLinkId=${(pendingIdPLinkId)!''}&redirect_uri=${(redirect_uri?url)!''}&response_mode=${(response_mode?url)!''}&response_type=${(response_type?url)!''}&scope=${(scope?url)!''}&state=${(state?url)!''}&timezone=${(timezone?url)!''}&metaData.device.name=${(metaData.device.name?url)!''}&metaData.device.type=${(metaData.device.type?url)!''}${(extraParameters!'')?no_esc}&code_challenge=${(code_challenge?url)!''}&code_challenge_method=${(code_challenge_method?url)!''}&user_code=${(user_code?url)!''}" class="${class}">
[#nested/]
</a>
[/#macro]

[#macro goBackToLoginlink class="" iconBefore=true]
  [#assign the_class = "inline-flex h-10 px-4 py-2 w-full items-center justify-center whitespace-nowrap rounded-md text-sm font-medium text-black border-1 border-black bg-white hover:bg-gray-100 transition-colors ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-gray-400 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 ${class}" /]
  [#if class != ""]
    [#assign the_class = the_class + " " + class /]
  [/#if]
  [@helpers.link url="/oauth2/authorize" class=the_class ]
    [#if iconBefore == true]
      <span class="mr-2 text-2xl">&#8592;</span>
    [/#if]
    ${theme.message('return-to-login')}
  [/@helpers.link]
[/#macro]

[#macro logoutLink redirectURI extraParameters=""]
[#-- Note that in order for the post_logout_redirect_uri to be correctly URL escaped, you must use this syntax for assignment --]
[#local post_logout_redirect_uri]${redirectURI}?tenantId=${(tenantId)!''}&client_id=${(client_id)!''}&nonce=${(nonce?url)!''}&pendingIdPLinkId=${(pendingIdPLinkId)!''}&redirect_uri=${(redirect_uri?url)!''}&response_mode=${(response_mode?url)!''}&response_type=${(response_type?url)!''}&scope=${(scope?url)!''}&state=${(state?url)!''}&timezone=${(timezone?url)!''}&metaData.device.name=${(metaData.device.name?url)!''}&metaData.device.type=${(metaData.device.type?url)!''}${(extraParameters?no_esc)!''}&code_challenge=${(code_challenge?url)!''}&code_challenge_method=${(code_challenge_method?url)!''}&user_code=${(user_code?url)!''}[/#local]
<a href="/oauth2/logout?tenantId=${(tenantId)!''}&client_id=${(client_id)!''}&post_logout_redirect_uri=${post_logout_redirect_uri?markup_string?url}">[#t]
  [#nested/][#t]
</a>[#t]
[/#macro]

[#macro defaultIfNull text default]
  ${text!default}
[/#macro]

[#macro faSolidCircleCheck]
  <svg
  xmlns="http://www.w3.org/2000/svg"
  fill="none"
  viewBox="0 0 512 512">
    <!--!Font Awesome Free 6.7.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2025 Fonticons, Inc.-->
    <path
      d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"
      fill="currentColor"
    />
  </svg> 
[/#macro]

[#macro passwordRules passwordValidationRules]
<div class="flex flex-col gap-1 text-xs text-neutral-500 border-1 rounded-md p-3" id="passwordRules">
  [#--
  <span>
     ${theme.message('password-constraints-intro')} 
  </span>
  --]
  <ul class="flex flex-col gap-1.5">
    [#if passwordValidationRules.requireMixedCase]
      <li class="flex items-center gap-2" id="requireMixedCase">
        <span class="flex-shrink-0 w-4 h-4">
          [@faSolidCircleCheck/]
        </span>
        <span>${theme.message('password-case-constraint')}</span>
      </li>
    [/#if]
    [#if passwordValidationRules.requireNonAlpha]
      <li class="flex items-center gap-2" id="requireNonAlpha">
        <span class="flex-shrink-0 w-4 h-4">
          [@faSolidCircleCheck/]
        </span>
        <span>${theme.message('password-alpha-constraint')}</span>
      </li>
    [/#if]
    [#if passwordValidationRules.requireNumber]
      <li class="flex items-center gap-2" id="requireNumber">
        <span class="flex-shrink-0 w-4 h-4">
          [@faSolidCircleCheck/]
        </span>
        <span>${theme.message('password-number-constraint')}</span>
      </li>
    [/#if]
    <li class="flex items-center gap-2" id="requireLength">
      <span class="flex-shrink-0 w-4 h-4">
        [@faSolidCircleCheck/]
      </span>
      <span>${theme.message('password-length-constraint', passwordValidationRules.minLength, passwordValidationRules.maxLength)}</span>
    </li>
    [#if application.registrationConfiguration.confirmPassword]
    <li class="flex items-center gap-2" id="requireMatch">
      <span class="flex-shrink-0 w-4 h-4">
        [@faSolidCircleCheck/]
      </span>
      <span>${theme.message('password-must-match')}</span>
    </li>
    [/#if]
    [#if passwordValidationRules.rememberPreviousPasswords.enabled]
      <li class="flex items-center gap-2" id="requirePrevious">
        <span class="flex-shrink-0 w-4 h-4">
          [@faSolidCircleCheck/]
        </span>
        <span>${theme.message('password-previous-constraint', passwordValidationRules.rememberPreviousPasswords.count)}</span>
      </li>
    [/#if]
  </ul>
</div>
[/#macro]

[#macro customField field key autofocus=false placeholder="" label="" leftAddon="true"]
  [#assign fieldId = field.key?replace(".", "_") /]
  [#local leftAddon = (leftAddon == "true")?then(field.data.leftAddon!'info', "") /]

  [#if field.key == "user.preferredLanguages" || field.key == "registration.preferredLanguages"]
    [@locale_select field=field id="${fieldId}" name="${field.key}" required=field.required autofocus=autofocus label=label /]
  [#elseif field.control == "checkbox"]
    [#if field.options?has_content]
      [@checkbox_list field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
    [#else]
      [@checkbox field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label /]
    [/#if]
  [#elseif field.control == "number"]
    [@input id="${fieldId}" type="number" name="${key}" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
  [#elseif field.control == "password"]
    [@input id="${fieldId}" type="password" name="${key}" leftAddon="lock" autocomplete="new-password" autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder)/]
  [#elseif field.control == "radio"]
    [@radio_list field=field id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
  [#elseif field.control == "select"]
    [@select id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label options=field.options /]
  [#elseif field.control == "textarea"]
    [@textarea id="${fieldId}" name="${key}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
  [#elseif field.control == "text"]
    [#if field.type == "date"]
      [@input id="${fieldId}" name="${key}" type="date" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder) /]
    [#else]
      [@input id="${fieldId}" type="text" name="${key}" leftAddon="${leftAddon}" required=field.required autofocus=autofocus label=label placeholder=theme.optionalMessage(placeholder)/]
    [/#if]
  [/#if]
[/#macro]

[#function display object propertyName default="\x2013" ]
  [#assign value=("((object." + propertyName + ")!'')")?eval/]
  [#-- ?has_content is false for boolean types, check it first --]
  [#if value?has_content]
    [#if value?is_number]
      [#return value?string('#,###')]
    [#else]
      [#return (value == default?is_markup_output?then(default?markup_string, default))?then(value, value?string)]
    [/#if]
  [#else]
    [#return default]
  [/#if]
[/#function]

[#macro passwordField field showCurrentPasswordField=false]
  [#-- Render checkbox used to determine whether the form submit should update password--]
  <div class="form-row">
    <label for="editPasswordOption"> ${theme.optionalMessage("change-password")} </label>
    <input type="hidden" name="__cb_editPasswordOption" value="useExisting">
    <label class="toggle">
      <input id="editPasswordOption" type="checkbox" name="editPasswordOption" value="update" data-slide-open="password-fields" [#if editPasswordOption == "update"]checked[/#if]>
      <span class="rail"></span>
      <span class="pin"></span>
    </label>
  </div>
  <div id="password-fields" class="slide-open ${(editPasswordOption == "update")?then('open', '')}">
    [#-- See if the application requires the current password --]
    [#if showCurrentPasswordField]
      [@customField field=field key="currentPassword" autofocus=false label=theme.optionalMessage("current-password")/]
    [/#if]

    [#-- Show the Password Validation Rules if there is a field error for 'user.password' --]
    [#if (fieldMessages?keys?seq_contains("user.password")!false) && passwordValidationRules??]
      [@passwordRules passwordValidationRules/]
    [/#if]

    [#-- Render password field--]
    [@customField field=field key=field.key autofocus=false placeholder=field.key label=theme.optionalMessage(field.key) leftAddon="false"/]

    [#-- Render confirm if set to true on the field     --]
    [#if field.confirm]
      [@customField field "confirm.${field.key}" false "[confirm]${field.key}" /]
    [/#if]
  </div>
[/#macro]

[#macro captchaScripts showCaptcha captchaMethod siteKey=""]
  [#if showCaptcha]
    [#if captchaMethod == "GoogleRecaptchaV2"]
      <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    [/#if]
    [#if captchaMethod == "GoogleRecaptchaV3"]
      <script src="https://www.google.com/recaptcha/api.js?render=${siteKey}"></script>
    [/#if]
    [#if captchaMethod == "HCaptcha" || captchaMethod == "HCaptchaEnterprise"]
      <script src="https://hcaptcha.com/1/api.js" async defer></script>
    [/#if]
    <script src="${request.contextPath}/js/oauth2/Captcha.js?version=${version}"></script>
    <script data-captcha-method="${captchaMethod!''}" data-site-key="${siteKey!''}">
      Prime.Document.onReady(function() {
        new FusionAuth.OAuth2.Captcha();
      });
    </script>
  [/#if]
[/#macro]

[#macro captchaBadge showCaptcha captchaMethod siteKey=""]
  [#-- If you want to remove captcha from the page, also ensure you disable it in the tenant configruation. --]
  [#if showCaptcha]
    [#if captchaMethod == "GoogleRecaptchaV2"]
      <div class="g-recaptcha" data-sitekey="${siteKey!''}"
        [#-- To use the invisible mode, un-comment the following two data- attributes. For more information see: https://developers.google.com/recaptcha/docs/invisible --]
        [#--
        data-size="invisible"
        data-callback="reCaptchaV2InvisibleCallback"
        --]
      ></div>
    [#elseif captchaMethod == "GoogleRecaptchaV3"]
      [#-- This is the replacement Terms and Conditions messaging that is required by Google when hiding the
           standard badge. If you want to remove this you will also need to remove or edit the CSS above. --]
      <div class="grecaptcha-msg">
        ${theme.message('captcha-google-branding')?no_esc}
      </div>
    [#elseif captchaMethod == "HCaptcha" || captchaMethod == "HCaptchaEnterprise"]
      <div class="h-captcha" data-sitekey="${siteKey!''}"></div>
    [/#if]
    [@errors field="captcha_token"/]
  [/#if]
[/#macro]

[#macro scopeConsentField application scope type]
  [#-- Resolve the consent message and detail for the provided scope --]
  [#if type != "unknown"]
    [#local scopeMessage = resolveScopeMessaging('message', application, scope.name, scope.defaultConsentMessage!scope.name) /]
    [#local scopeDetail = resolveScopeMessaging('detail', application, scope.name, scope.defaultConsentDetail!'') /]
  [/#if]

  [#if type == "required"]
    [#-- Required scopes should use a hidden form field with a value of "true". The user cannot change this selection, --]
    [#-- but there should be a display element to inform the user that they must consent to the scopes to continue. --]
    <div class="form-row consent-item col-lg-offset-0">
      [@hidden name="scopeConsents['${scope.name}']" value="true" /]
      <i class="fa fa-check"></i>
      <span>
        ${scopeMessage}
        [#if scopeDetail?has_content]
          <i class="fa fa-info-circle" data-tooltip="${scopeDetail}"></i>
        [/#if]
      </span>
    </div>
  [#elseif type == "optional"]
    [#-- Optional scopes should render a checkbox to allow a user to change their selection. The available values should be "true" and "false" --]
    <div class="consent-item col-lg-offset-0">
      [@input type="checkbox" name="scopeConsents['${scope.name}']" id="${scope.name}" label=scopeMessage value="true" uncheckedValue="false" tooltip=scopeDetail /]
    </div>
  [#elseif type == "unknown"]
    [#-- Unknown scopes and the reserved "openid" and "offline_access" scopes are considered required and do not have an associated display element. --]
    [@hidden name="scopeConsents['${scope}']" value="true" /]
  [/#if]
[/#macro]

[#function resolveScopeMessaging messageType application scopeName default]
  [#-- Application specific, tenant specific, not application/tenant specific, then default --]
  [#local message = theme.optionalMessage("[{application}${application.id}]{scope-${messageType}}${scopeName}") /]
  [#local resolvedMessage = message != "[{application}${application.id}]{scope-${messageType}}${scopeName}" /]
  [#if !resolvedMessage]
     [#local message = theme.optionalMessage("[{tenant}${application.tenantId}]{scope-${messageType}}${scopeName}") /]
     [#local resolvedMessage = message != "[{tenant}${application.tenantId}]{scope-${messageType}}${scopeName}" /]
  [/#if]
  [#if !resolvedMessage]
    [#local message = theme.optionalMessage("{scope-${messageType}}${scopeName}") /]
    [#local resolvedMessage = message != "{scope-${messageType}}${scopeName}" /]
  [/#if]
  [#if !resolvedMessage]
    [#return default /]
  [#else]
    [#return message /]
  [/#if]
[/#function]