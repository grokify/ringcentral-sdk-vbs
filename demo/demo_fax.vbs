' This demo provides VBScript code to fax a PDF file using the RingCentral fax API

Function ringcentralFaxFile(baseUrl, accessToken, toPhoneNumber, coverPageText, filename)
  url  = baseUrl & "/restapi/v1.0/account/~/extension/~/fax"

  json = "{""to"":[{""phoneNumber"":""" & toPhoneNumber & """}]," _
    & """coverPageText"":""" & coverPageText & """," _
    & """faxResolution"":""High""}"

  fileBase64   = encodeBase64(readFileAsBytes(filename))

  boundary     = "Boundary-----1234567890"
  boundaryPart = "--" & boundary & vbCrLf
  boundaryEnd  = "--" & boundary & "--" & vbCrLf
  vbCrLf2      = vbCrLf & vbCrLf

  body = boundaryPart & "Content-Type: application/json" & vbCrLf2 & json & vbCrLf2

  body = body & boundaryPart & "Content-Type: application/pdf" & vbCrLf
  body = body & "Content-Transfer-Encoding: base64" & vbCrLf2 & fileBase64

  body = body & vbCrLf2 & boundaryEnd
  
  ' Uncomment the next line if you want to view the output on the console.
  ' WScript.Echo(body)

  ' Both MSXML2.XMLHTTP.3.0 and Microsoft.XMLHTTP have been verified to work.
  ' Set xmlhttp = WScript.CreateObject("Microsoft.XMLHTTP")
  Set xmlhttp = WScript.CreateObject("MSXML2.XMLHTTP.3.0")

  xmlhttp.Open "POST", url, false
  xmlhttp.SetRequestHeader "Authorization", "Bearer " & accessToken
  xmlhttp.SetRequestHeader "Content-Type", "multipart/mixed; boundary=" & boundary
  xmlhttp.Send body
  ringcentralFaxFile = xmlhttp.ResponseText
  Set xmlhttp = Nothing
End Function

Function readFileAsBytes(filename)
  Dim inStream
  Set inStream  = WScript.CreateObject("ADODB.Stream")
  adTypeBinary  = 1
  inStream.Type = adTypeBinary
  inStream.Open
  inStream.LoadFromFile(filename)
  readFileAsBytes= inStream.Read()
End Function

Function encodeBase64(bytes)
  Dim dom, el
  Set dom = CreateObject("Microsoft.XMLDOM")
  Set el  = dom.createElement("tmp")
  el.DataType = "bin.base64"
  el.NodeTypedValue = bytes
  encodeBase64 = el.Text
End Function

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
WScript.Echo "DONE"