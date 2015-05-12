# Table of contents

1. [Overview](#overview)
2. [Usage](#usage)

# Overview

This is a no-dependency VBScript example that sends a PDF file stored on the file system via the RingCentral for Developers fax API.

After downloading the `demo_fax.vbs` file, edit the credentials and run the file using `cscript.exe`. This example requires you to request an `access_token` via another means, e.g. the API Explorer at http://ringcentral.github.io/api-explorer/. Once you have the `access_token`, you can save this file, edit the 4 variables and run it as shown below.

This code has been verified to work on Windows 8.1 Enterprise Edition.

# Usage

To use this example, save the `demo_fax.vbs` file and edit the following variables as appropriate.

| Variable | Description |
|----------|-------------|
| `baseUrl`  | Set to either constant `baseUrlProduction` or `baseUrlSandbox`. |
| `accessToken` | Valid `access_token` retrieved via another means. |
| `toPhoneNumber` | Recipient phone number in E.164 format, e.g. +16505551212 |
| `coverPageText` | Cover page text. This is a very simple demo so ensure your strings are properly escaped, e.g. double quotes ". |
| `filename` | Path to PDF file accessible on file system. |

Note: for this demo, you will need to provide a valid `access_token` received from the `oauth/token` end point.

The following is the portion of `demo_fax.vbs` that should be edited.

```vbscript
' Use the proper URL depending on whether you are using Production or Sandbox
Const baseUrlProduction = "https://platform.ringcentral.com"
Const baseUrlSandbox    = "https://platform.devtest.ringcentral.com"

baseUrl       = baseUrlSandbox
accessToken   = "myAccessToken"
toPhoneNumber = "+16505551212"
coverPageText = "RingCentral fax via VBScript"
filename      = "test.pdf"

Dim res
res = ringcentralFaxFile(baseUrl, accessToken, toPhoneNumber, coverPageText, filename)
WScript.Echo res
```

After ensuring your credentials are correct, you can run the code with the following command:

```dos
C:\> cscript.exe demo_fax.vbs
```
