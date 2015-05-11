# Table of contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Core Module](#core-module)
4. [Fax](#fax)
4. [SMS](#sms)

***

# Overview

This is an in-development SDK for the RingCentral for Developers platform. At present, it is used for testing purposes only. Many parts of this SDK are not yet implemented and are subject to breaking changes. Use at your own risk.

It attempts to mirror the structure of the official RingCentral SDKs. 

# Installation

## Install Dependencies

```bash
$ go get github.com/pubnub/go/messaging
$ go get github.com/grokify/gotilla/net/httputil
```

## Install SDK

```bash
$ go get github.com/grokify/ringcentral-sdk-go
```

# Core Module

## Instantiate the RCSDK object

The SDK is represented by the global RCSDK constructor. Your application must create an instance of this object.

```go
import(
	"github.com/grokify/ringcentral-sdk-go/rcsdk"
)
// For Production use: "https://platform.ringcentral.com"
// For Sandbox use:  "https://platform.devtest.ringcentral.com"
sdk := rcsdk.NewSdk("yourAppKey", "yourAppSecret", "https://platform.devtest.ringcentral.com")
```

## Get the Platform Singleton

```js
platform := sdk.GetPlatform();
```

## Login

Login is accomplished by calling the `platform.Authorize()` method of the Platform singleton with username, extension
(optional), and password as parameters. A `Promise` instance is returned, resolved with an AJAX `Response` object.

The `username` should be a phone number in E.164 format with or without the leading `+`.

```go
platform.Authorize('+16505551212','101','yourPassword')
```

# Fax

## Fax File

To fax a file, it is recommended to use the fax request helper which will create the required HTTP request body and headers.

More information on usage is available in `./rcsdk/helpers/requesthelpers/README.md`.

```go
import(
	"github.com/grokify/ringcentral-sdk-go/rcsdk/helpers/requesthelpers"
)

fax, _ := requesthelpers.NewReqHelperFaxFile([]byte(`{ 
	"to" : [{"phoneNumber": "16505551212"}],
	"faxResolution" : "High"
}`), "/path/to/myfile.pdf")

resp, err := platform.Post("/account/~/extension/~/fax", url.Values{}, fax.GetBody(), fax.GetHeaders())
```

# SMS

In order to send an SMS using the API, make a POST request to `/account/~/extension/~/sms`:

```go
import(
	"net/http"
	"net/url"
)

resp, err := platform.Post("/account/~/extension/~/sms", url.Values{}, []byte(`{ 
	"to"   : [{"phoneNumber": "14155551212"}],
	"from" :  {"phoneNumber": "16505551212"}, 
	"text" : "Test from Go"
}`), http.Header{})
```

