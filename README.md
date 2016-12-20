# Globe Connect for Swift

## Introduction
Globe Connect for Swift platform provides an implementation of Globe APIs e.g Authentication, Amax,
Sms etc. that is easy to use and can be integrated in your existing Swift application. Below shows
some samples on how to use the API depending on the functionality that you need to integrate in your
application.

## Basic Usage

###### Figure 1. Authentication

```swift
import ConnectSwift

Authentication().getAccessToken(
    appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
    appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e",
    code: "M8s6gAarub9pebhgEAqKsxdByxHoM5kzf4Mp5js98Bzot8bqjrfaRdG4H4jknpFzr8gKtdx4jnUqbA8KsxqA48frR698IKLRb5S5LBxauo9EkxCMrzk6uorxGEu67Tay49aTxxzu8ozznukMEaXCBRB8GuKjR5MSpB65zIbkA8Bf5eA94se848KUb589RteGkdEFBEddEH6xqRyfjMBqatE4ppBsAe56Bfq4BkjHrXA9Rsqzp5RhMAA6Mu65MAds",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })

let url = Authentication().getDialogUrl(appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz")
print(url)
```

###### Figure 2. Amax

```swift
import ConnectSwift

let amax = Amax(
    appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
    appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e"
)

amax.sendRewardRequest(
    address: "927XXXXXXX",
    promo: "FREE10MB",
    rewardsToken: "w7hYKxrE7ooHqXNBQkP9lg",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 3. Binary SMS

```swift
import ConnectSwift

let sms = Sms(
    accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA",
    shortCode: "21584130"
)

sms.sendBinaryMessage(
    address: "092XXXXXXXX",
    message: "Lorem ipsum",
    header: "06050423F423F4",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 4. Location

```swift
import ConnectSwift

let locationQuery = LocationQuery(accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA")

locationQuery
    .getLocation(
        address: "092XXXXXXXX",
        success: { json in
            dump(json)
        },
        failure: { error in
            print(error)
        })
```

###### Figure 5. Payment (Send Payment Request)

```swift
import ConnectSwift

let payment = Payment(
    appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
    appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e",
    accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA"
)

payment.sendPaymentRequest(
    amount: 0.00,
    description: "My Application",
    endUserId: "92XXXXXXXX",
    referenceCode: "41301000111",
    transactionOperationStatus: "Charged",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 6. Payment (Get Last Reference ID)

```swift
import ConnectSwift

let payment = Payment(
    appId: "5ozgSgeRyeHzacXo55TR65HnqoAESbAz",
    appSecret: "3dbcd598f268268e13550c87134f8de0ec4ac1100cf0a68a2936d07fc9e2459e",
    accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA"
)

payment.getLastReferenceCode(
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 7. Sms

```swift
import ConnectSwift

let sms = Sms(
    accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA",
    shortCode: "21584130"
)

sms.sendMessage(
    address: "+6392XXXXXXXX",
    message: "Lorem ipsum",
    success: { json in
        dump(json)
        expectation.fulfill()
    },
    failure: { error in
        expectation.fulfill()
    })
```

###### Figure 8. Subscriber (Get Balance)

```swift
import ConnectSwift

let subscriber = Subscriber(accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA")

subscriber.getSubscriberBalance(
    address: "6392XXXXXXXX",
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 9. Subscriber (Get Reload Amount)

```swift
import ConnectSwift

let subscriber = Subscriber(accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA")

subscriber
    .getSubscriberReloadAmount(
        address: "6392XXXXXXXX",
        success: { json in
            dump(json)
        },
        failure: { error in
            print(error)
        })
```

###### Figure 10. USSD (Send)

```swift
import ConnectSwift

let ussd = Ussd(
    accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA",
    shortCode: "21584130"
)

ussd.sendUssdRequest(
    address: "6392XXXXXXXX",
    message: "Simple USSD Message\nOption - 1\nOption - 2",
    flash: false,
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```

###### Figure 11. USSD (Reply)

```swift
import ConnectSwift

let ussd = Ussd(
    accessToken: "kk_my8_77bTbW48zi4ap6SlE4UuybXq_XAsE79IGwhA",
    shortCode: "21584130"
)

ussd.replyUssdRequest(
    address: "6392XXXXXXXX",
    message: "Simple USSD Message\nOption - 1\nOption - 2",
    sessionId: "012345678912",
    flash: false,
    success: { json in
        dump(json)
    },
    failure: { error in
        print(error)
    })
```
