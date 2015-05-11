# Table of contents

1. [Overview](#overview)
2. [Usage](#usage)

# Overview

This demo covers how to fax a PDF file using VBScript.

# Usage

Run the `demo_fax.md` file ensuring that you add your credentials at the bottom of the script.

For this demo, you will need to provide a valid `access_token` received from the `oauth/token` end point.

```vbscript
' Use the proper URL depending on whether you are using Production or Sandbox
Const baseUrlProduction = "https://platform.ringcentral.com"
Const baseUrlSandbox    = "https://platform.devtest.ringcentral.com"

baseUrl       = baseUrlSandbox
accessToken   = "myAccessToken"
toPhoneNumber = "+16505551212"
coverPageText = "From VBScript"
filename      = "test.pdf"

Dim res
res = ringcentralFaxFile(baseUrl, accessToken, toPhoneNumber, coverPageText, filename)
WScript.Echo res
```