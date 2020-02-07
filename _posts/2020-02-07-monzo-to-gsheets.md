---
layout: post
title:  "Monzo webhooks to Google spreadsheets"
permalink: /monzo-to-gsheets
---

For years I've used Google spreadsheets to track my finances. I've tried using services like [Money Dashboard](https://www.moneydashboard.com/) in the past, but although they are simple to use, there is always a feature I want that is missing. I prefer to have control of my data so I can add functionality as and when I need it. So despite the setup and maintenance overhead, a spreadsheet is still the way to go in my opinion.

I used to export bank and credit card transactions in csv format and import them manually. Doing so was a laborious and time consuming task which I hated, but writing scripts to automate it seemed like overkill, especially when authentication to Google and numerous banks was involved. Not to mention differences in export format between banks.

Soon after I consolidated my accounts to [Monzo](https://monzo.com/) I realised they had an API, including webhooks. _Transaction webhooks!_ I pondered how easy it would be to push my transaction data to Google spreadsheets in _real time_, eliminating the manual and time consuming process of exporting/importing them myself. I thought if transactions fed directly into my sheet automatically, all I would need to do is categorise them. Simple. I knew it was possible to create web applications GSheets with [Apps Script](), so all the ingredients were there. 

After reading some documentation and hacking about for an hour or so I'd proven it was entirely possible. Now, when a transaction occurs in my Monzo account it appears in the finance spreadsheet within milliseconds. This post explains how I got it working.

<!--more-->

In my Google spreadsheet I have a Transactions sheet with the following columns: Date, Description, Credit, Debit, Split, Balance, Account, Category, and Comments.

![Transaction sheet](/assets/img/transaction-sheet.png)

I created an Apps Script project (**Tools > Script editor**) and the following function (replacing placeholders with appropriate values).

```aidl
function doPost(e) {
  console.log('*** doPost(e) ***');
  if(typeof e !== 'undefined') {
    var contents = JSON.parse(e.postData.contents);
    console.log(contents);
    try { 
      var transaction = contents.data;
      
      var date = transaction.created.split('T')[0];
      var description = Object.keys(transaction.counterparty) == 0 ? transaction.description : transaction.counterparty.name.toUpperCase() + ' REF ' + transaction.notes.toUpperCase();
      var amount = transaction.amount / 100;
      var credit = amount > 0 ? amount : '';
      var debit = credit > 0 ? '' : Math.abs(amount);
      var account = 'Monzo';
      var comments = '';
      
      var sheet= SpreadsheetApp.openById('spreadsheet_id').getSheetByName('Transactions');
      sheet.insertRows(2);
      sheet.getRange(2, 1, 1, 10).setValues([[ date, description, credit, debit, '', '', account, '', comments, e.postData.contents ]]);
    }
    catch(err) {
      console.log(err);
      console.log(err.message);
      console.log(contents);
    }
    finally {
      return ContentService.createTextOutput(JSON.stringify({}));
    }
  }
}
```

To publish the script as a Web App, click **Publish > Deploy as a web app...**. In **Execute the app as** I selected myself (my email address), and for **Who has access to the app** I set _Anonymous, even anonymous_.
 
![Apps script deploy webapp](/assets/img/apps-script-deploy.png)

After clicking publish, the resultant URL is the endpoint needed to create the Monzo webhook.

![Apps script webapp deployed](/assets/img/apps-script-deployed.png)

I then logged into the [Monzo Developer Playground](https://developers.monzo.com/api/playground). To login you enter your email address and you are sent a login link via email. When you visit the link you are required to authorise access from the Monzo app (nice security).

Once logged in, I got a list of my accounts by executing the **List accounts** endpoint. This response is a JSON document with a list of accounts details, from which I copied the account id was interested in.

![Apps script webapp deployed](/assets/img/monzo-list-accounts.png)

Finally, in the Register a webhook endpoint, in the sample JSON post data I replaced `$account_id` and entered the Google Apps Script web app url in the `url` field.

![Apps script webapp deployed](/assets/img/monzo-register-webhook.png)

And that's it. As soon as the webhook is registered you should start receiving data into your spreadsheet. You can debug what's coming in by using Apps Script Stackdriver Logging (**View > Stackdriver Logging**). I found this really useful to iron out a few issues early on. But my transactions have been coming in automatically now for over six months, saving me a tonne of time and frustration.





