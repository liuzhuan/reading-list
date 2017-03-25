# DOM Enlightenment

Author: Cody Lindley

Date: 2017/03/25

## 1.4 Node attribues and methods

Node attributes

* childNodes
* firstChild
* lastChild
* nextSibling
* nodeName ? string value `#text`
* nodeType ? 
* nodeValue ? integer number
* parentNode
* previousSibling

Node methods

* appendChild()
* cloneNode()
* comparentDocumentPosition() ?
* contains() ?
* hasChildNodes() ?
* insertBefore()
* isEqualNode() ?
* removeChild()
* replaceChild()

Document methods

* document.createElement()
* document.createTextNode()

HTML*Element attributes

* innerHTML
* outerHTML
* textContent
* innerText 
* outerText ?
* firstElementChild
* lastElementChild
* nextElementChild
* previousElementChild
* children

HTML*Element methods

* insertAdjacentHTML() ?

Frequently used nodeType and nodeName

 node | nodeName | nodeType
 --- | --- | ---
 document.doctype | html | 10
 document | #document | 9
 document fragment | #document-fragment | 11
 anchor | A | 1
 text | #text | 3
