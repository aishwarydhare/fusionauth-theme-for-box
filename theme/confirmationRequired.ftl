[#ftl/]
[#-- @ftlvariable name="application" type="io.fusionauth.domain.Application" --]
[#-- @ftlvariable name="client_id" type="java.lang.String" --]
[#-- @ftlvariable name="confirmationRequiredReason" type="java.lang.String" --]
[#-- @ftlvariable name="csrfToken" type="java.lang.String" --]
[#-- @ftlvariable name="tenant" type="io.fusionauth.domain.Tenant" --]
[#-- @ftlvariable name="tenantId" type="java.util.UUID" --]
[#import "_helpers.ftl" as helpers/]

[@helpers.html]
  [@helpers.head title=theme.message("confirmation-required")]
    [#-- Custom <head> code goes here --]
  [/@helpers.head ]
  [@helpers.body]
    [@helpers.header]
      [#-- Custom header code goes here --]
    [/@helpers.header]
    
    [@helpers.main title=theme.message("confirmation-required") subtitle=theme.message("{description}confirmation-required-${confirmationRequiredReason}")?no_esc]

      [#-- Message specific to the reason the user is being required to confirm.
           - Adding ?no_esc to allow the message to include <br> (line breaks)
       --]
      <div class="grid gap-6 text-center">
        [#-- Generic detail about what to do next --]
        <div class="grid gap-3">
          <p>${theme.message("{description}confirmation-required-ignore")}</p>
        </div>

        <form action="${request.contextPath}/confirmation-required" method="POST" class="form-row grid gap-3">
          <input type="hidden" name="csrfToken" value="${csrfToken!""}"/>
          [#list request.parameters as key,value]
            [#list value as v]
            <input type="hidden" name="${key!""}" value="${v!""}"/>
            [/#list]
          [/#list]
          [@helpers.button text=theme.message('continue') class="inline-flex h-10 px-4 py-2 w-full items-center justify-center whitespace-nowrap rounded-md text-sm font-medium text-white bg-fuchsia-900 hover:bg-gray-800 transition-colors ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-gray-400 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50" /]
        </form>
      </div>
    [/@helpers.main]

    [@helpers.footer]
      [#-- Custom footer code goes here --]
    [/@helpers.footer]
  [/@helpers.body]
[/@helpers.html]