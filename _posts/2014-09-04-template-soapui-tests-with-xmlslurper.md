---
layout: post
title:  "Template SoapUI tests with XmlSlurper"
---

In between urgent bug fixes and planned sprint work I've been trying to find time to write an automated test suite with [SoapUI](http://www.soapui.org/) to verify some of the things we can't in [unit tests](http://blog.awolski.com/unit-tests-worth-their-weight-in-gold/). After writing a few SoapUI tests by copying the same SOAP request between test cases, but slightly modifying the content of one or two elements, I wondered whether it would be ~~easier~~ smarter to reuse a template SOAP request and somehow replace only the element/attribute content that differs between tests.

With a little bit of Groovy (specifically [XmlSlurper](http://groovy.codehaus.org/Reading+XML+using+Groovy's+XmlSlurper)) you can, and here's how I did it.*

I created a template directory in the same location as my SoapUI project file, in which I store my template SOAP request(s). Load this project path using SoapUI's GroovyUtil:

```groovy
def projectDir = new com.eviware.soapui.support.GroovyUtils(context).getProjectPath()`
```

Then load the specific template you want to use:

```groovy
def template = new java.io.File(projectDir + "/templates/generateAccount_renewalStub.xml")`
```

And create a new XmlSlurper instance reading the template:

```groovy
def root = new XmlSlurper().parse(template).declareNamespace(...)`
```

For each test case, I create test properties in the same [Groovy Bean](http://groovy.codehaus.org/Groovy+Beans) format that XmlSlurper uses to access XML elements and attributes (e.g. `request.inUser.username`). The property values are what I want to replace the template content with. So you can use Eval.x to set the

<pre><code>testRunner.testCase.properties.each() { k, v ->
   // Use Eval.x to update the content of the element at ${k} with the value ${v}
}</code></pre>

Then you can use the content of the updated template request and [transfer it as a property value](http://www.soapui.org/Functional-Testing/transferring-property-values.html) to the next test step (such as a Test Request), the property accessed via `${Properties.testRequest}`

*\* I'm still yet to get the Eval.x working to set properties with indexes, e.g. element[0], so my solution is not yet complete.*
