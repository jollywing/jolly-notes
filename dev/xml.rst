
XML basic
==============================

XML Syntax Rules
------------------------------

In XML, it is illegal to omit the closing tag. All elements must have a closing tag:

<p>This is a paragraph.</p>
<br />

XML Tags are Case Sensitive

XML Documents Must Have a Root Element

XML documents must contain one element that is the parent of all other elements. This element is called the root element.

<root>
  <child>
    <subchild>.....</subchild>
  </child>
</root>

XML Attribute Values Must be Quoted

Entity References

Some characters have a special meaning in XML.

If you place a character like "<" inside an XML element, it will generate an error because the parser interprets it as the start of a new element.

To avoid this error, replace the "<" character with an entity reference: ``&lt;``
There are 5 predefined entity references in XML:


&lt;< less than
&gt;> greater than
&amp; &ampersand 
&apos;'apostrophe
&quot;"quotation mark

Note: Only the characters "<" and "&" are strictly illegal in XML. The greater than character is legal, but it is a good habit to replace it.

The syntax for writing comments in XML is similar to that of HTML.

<!-- This is a comment -->

White-space is Preserved in XML

XML Stores New Line as LF

What is an XML Element?
------------------------------

An XML element is everything from (including) the element's start tag to (including) the element's end tag.

An element can contain:

other elements
text
attributes
or a mix of all of the above...

XML Naming Rules
------------------------------

XML elements must follow these naming rules:

Names can contain letters, numbers, and other characters
Names cannot start with a number or punctuation character
Names cannot start with the letters xml (or XML, or Xml, etc)
Names cannot contain spaces
Any name can be used, no words are reserved.

XML Attributes
------------------------------

Attribute values must always be quoted. Either single or double quotes can be used. 

If the attribute value itself contains double quotes you can use single quotes, like in this example:

<gangster name='George "Shotgun" Ziegler'>
or you can use character entities:

<gangster name="George &quot;Shotgun&quot; Ziegler">

Avoid XML Attributes?

Some of the problems with using attributes are:

attributes cannot contain multiple values (elements can)
attributes cannot contain tree structures (elements can)
attributes are not easily expandable (for future changes)
Attributes are difficult to read and maintain. Use elements for data. Use attributes for information that is not relevant to the data.

XML Attributes for Metadata

Sometimes ID references are assigned to elements. These IDs can be used to identify XML elements in much the same way as the id attribute in HTML. This example demonstrates this:

<messages>
  <note id="501">
    <to>Tove</to>
    <from>Jani</from>
    <heading>Reminder</heading>
    <body>Don't forget me this weekend!</body>
  </note>
  <note id="502">
    <to>Jani</to>
    <from>Tove</from>
    <heading>Re: Reminder</heading>
    <body>I will not</body>
  </note>
</messages>
The id attributes above are for identifying the different notes. It is not a part of the note itself.

What I'm trying to say here is that metadata (data about data) should be stored as attributes, and the data itself should be stored as elements.

The XML DOM - Advanced

In an earlier chapter of this tutorial we introduced the XML DOM, and we used the getElementsByTagName() method to retrieve data from an XML document.

In this chapter we will explain some other important XML DOM methods.

You can learn more about the XML DOM in our XML DOM tutorial.

Get the Value of an Element

The XML file used in the examples below: books.xml.

The following example retrieves the text value of the first <title> element:

Example

txt=xmlDoc.getElementsByTagName("title")[0].childNodes[0].nodeValue;

Try it yourself »

Get the Value of an Attribute

The following example retrieves the text value of the "lang" attribute of the first <title> element:

Example

txt=xmlDoc.getElementsByTagName("title")[0].getAttribute("lang");

Try it yourself »

Change the Value of an Element

The following example changes the text value of the first <title> element:

Example

x=xmlDoc.getElementsByTagName("title")[0].childNodes[0];
x.nodeValue="Easy Cooking";

Try it yourself »

Create a New Attribute

The XML DOM setAttribute() method can be used to change the value of an existing attribute, or to create a new attribute.

The following example adds a new attribute (edition="first") to each <book> element:

Example

x=xmlDoc.getElementsByTagName("book");

for(i=0;i<x.length;i++)
  {
  x[i].setAttribute("edition","first");
  }

Try it yourself »

Create an Element

The XML DOM createElement() method creates a new element node.

The XML DOM createTextNode() method creates a new text node.

The XML DOM appendChild() method adds a child node to a node (after the last child).

To create a new element with text content, it is necessary to both create a new element node and a new text node, and then append it to an existing node.

The following example creates a new element (<edition>), with the following text: First, and adds it to the first <book> element:

Example

newel=xmlDoc.createElement("edition");
newtext=xmlDoc.createTextNode("First");
newel.appendChild(newtext);

x=xmlDoc.getElementsByTagName("book");
x[0].appendChild(newel);

Try it yourself »
Example explained:

Create an <edition> element
Create a text node with the following text: First
Append the text node to the new <edition> element
Append the <edition> element to the first <book> element
Remove an Element

The following example removes the first node in the first <book> element:

Example

x=xmlDoc.getElementsByTagName("book")[0];
x.removeChild(x.childNodes[0]);

Try it yourself »
Note: The result of the example above may be different depending on what browser you use. Firefox treats new lines as empty text nodes, Internet Explorer does not. You can read more about this and how to avoid it in our XML DOM tutorial.
