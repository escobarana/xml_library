# Modelling of an XML Database to store the data of a Library
## Modelling choices

Following the assignment requirements, my XML database has five main elements: Book, Author, Member, Librarian and Reservation.

**Book**: Represents a book element in the library. It has an id attribute which is the unique identifier of the book and ten different elements. There must be at least one book within a library. Required element.
	
    Kinds: Represents a list of categories as a book can have more than one different category. Kind element belongs to this element. Required element.
        
    Kind: Represents the category of the book. It must be at least one of the following: adults, kids, comic, magazine, art, history, science, scifi, politics, nature, business, travel, cooking. One book can have more than one different kind, for example, there can be a book of kind nature and science at the same time. Required element.
	
    Title: Represents the title of the book. Required element.
	
    Authors: Represents a list of authors since a book can have more than one author. The element author is within this element. Required element.
	
    BookAuthor: Represents the author. Within a book, this element will have an attribute authorId which is a key reference to an author element. A book can have more than one different author. Required element.
	
    Editorial: Represents the editorial of the book. Required element.
	
    Type: Represents whether the book can be borrowed, consulted or both. It can have one of the following values: borrow, consult, all. Required element.
	
    ISBN: Represents the ISBN of type 10 of the book. Required element.
	
    PublicationYear: Represents the year the book was published. Required element.
	
    Edition: Represents the number of edition (1st edition, 2nd edition, …) of the book. It is an optional element. Required element.
	
    Abstract: Represent a little resume of the book. It is an optional element.
	
    NbOfCopies: Represent the number of copies of the book purchased by the library and hence available in the library. Required element.
    
    Availability: Represent the number of copies of the book currently available in the library. Required element.
	
    Languages: Represents a list of languages in which the book is written. The element language belongs to this element. Required element.
	
    Language: Represents the language in which a book is written. It must be one of the following values: Spanish, English, French, German, Portuguese. A book can be written in more than one language, for example, the language books used to learn a new language are written in two languages usually. Required element.

**Author**: Represents an author element in the library. It has an id attribute which is the unique identifier of the author and two different elements. There must be at least one author within a library since there’s at least one book, and a book is written by at least one author. Required element.
	
    AuthorFirstName: Represents the author’s name. Required element.
	
    AuthorLastName: Represents the author’s surname. Required element.

**Member**: Represents a member element in the library. It has an id attribute which is the unique identifier of the member and nine different elements as maximum. Possibility of having no members in a library. Dealing with the scenario when a library has recently open or where people only go to consult books or study. Optional element (0 or many members may exist).
	
    MemberFirstName: Represents the member’s name. Required element.
	
    MemberLastName: Represents the member’s surname. Required element.
	
    BirthDate: Represents the member’s birthdate in the format yyyy-mm-dd. Required element.
	
    Email: Represents the member’s email. Required element.
	
    Address: Represents the member’s address, it has up to five elements and minimum four elements. Required element.
	
    Street: Represents the name of the street of the address. Required element.
	
    Number: Represents the number of the address. Required element.
	
    Zipcode: Represents the zipcode of the address. Required element.
	
    City: Represents the city of the address. Required element.
	
    AdditionalInformation: If the member wishes to add anything to his address, he will use this element. Optional element.
	
    JoinedDate: Represents the date in which the member joined the library in the format yyyy-mm-dd. Required element.
	
    Interests: Represents a list of interests of the member. Can be empty if the member doesn’t want to add his interests. Required element.
	
    Interest: Represents a unique interest. Must have one of the following values: adults, kids, comic, magazine, art, history, science, scifi, 
    politics, nature, business, travel, cooking. Optional element.
	
    BorrowedBooks: Represents a list of all borrowed books by the member. Can be empty if no books have been borrowed. Required element.
	
    BorrowedBook: Represents a book borrowed by the member. It must have the following attributes: bookId to identify the borrowed book, librarianId to identify the worker who provided the book and borrowDate to know the date the book has been borrowed. Additionally, if the book has been returned an additional attribute will appear: returnedDate which indicates the date the book has been returned to the library. Optional element.
	
    MemberStatus: Represents the member status. It can take one of the following values: active, cancelled, suspended. Required element.

**Librarian**: Represents a librarian element in the library. It has an id attribute which is the unique identifier of the librarian and four different elements. There must be at least one librarian working at the library it would not make sense to have a library without a person in charge. Required element.
	
    LibrarianFirstName: Represents the librarian’s name. Required element.
	
    LibrarianLastName: Represents the librarian’s surname. Required element.
	
    WorkEmail: Represents the librarian’s email. Required element.
	
    AreaOfExpertise: Represents the librarian’s area of expertise. Required element.

**Reservation**: Represents a reservation element in the library. It has an id attribute which is the unique identifier of the reservation and four different elements. There exists the possibility of reserve a book by a member when it is currently out of stock when all the copies available have been borrowed. Optional element (0 or many reservations may exist).
	
    ResMember: Represents the idref to the member id who made the reservation. Required element.
	
    ResBook: Represents the idref to the book id reserved. Required element.
	
    ReservationDate: Represents the reservation date in the format yyyy-mm-dd. Required element.
	
    ReservationStatus: Represents the status of the reservation. Can take one of these values: confirmed, pending, cancelled. Required element.


## Advantages
This model knows when a book borrowed by a member has not been returned thanks to the `returnedDate` attribute in member>borrowedBooks>borrowedBook which is empty if the book has not been returned.

Additionally, it can know the interests of its members in order to recommend books within the category of their interests.

It extensively uses `Keys` and `KeyRefs` in order to avoid repetition and have the necessary elements referenced. Five main elements (Book, Author, Librarian, Member, Reservation). Have a look at the diagram which illustrates the relationship between elements (just to illustrate the Keys and KeyRefs on each main element, not any other attributes/elements, see `diagram.png` image).

When a book is out of stock, it treats member’s requests who want a book that is currently unavailable as a reservation until someone returns the book. This is possible thanks to the fields `nbOfCopies` and `availability` that each book element has.
Regarding the processing of data, as I’m using my own date format I noticed that in order to compare two dates I should use the format `yyyy-mm-dd` so I could remove the symbol `-` from the date and treat the result as a number to be able to properly compare dates *(scenario 4)*.


## Disadvantages
I’m not managing the number of books a member can borrow as maximum at once, currently a member can borrow any quantity of books.

I don’t have a maximum period of time a book can be borrowed from the library and what would be the consequences in case a book is not ever returned (a fine to the member for example).


## Transformations and Use Cases answered

**Scenario 1**

*Use case:* List all the books available in the library sorted by descending order of publication year. With each book, the author(s) are shown. Also, the books only available for consult appear in red colour. This scenario is mainly to have an inventory of all the books currently available in the library and highlight those that can only be consulted but not borrowed so this list can be useful for the library members when looking for a concrete book.

**Scenario 2**

*Use case:* Table of all currently active members (ordered by last name) in the library and its joined date. This can give an overall image of how many people are currently using the library and how interesting a library is for its members. 

**Scenario 3**

*Use case:* Keep track of the members who have not returned a book, having information about the member and the borrowed book. So, when a book is missing for a period longer than expected we can contact the member who borrowed the book and see the borrowed date.


**Scenario 4**

*Use case:* Classify our members in terms of `loyalty` depending on its joined date (only applies to currently active members). If a member joined before January 1st, 2016, he is considered as `premium`, otherwise he is considered as `basic`. Some special benefits and advantages can be applied to premium members like the ability to borrow more books so the library can increase its members’ engagement and attract new members too.

**Scenario 5 (Bonus)**

*Use case:* Measure library members’ engagement with the number of books they have borrowed in total since they have joined the library.


## Working Environment and tools used

**Working environment:**

Visual Studio Code for coding with the extensions: DTDL, JSON, Prettify JSON, XML, XML Tools, XSL Transform.

**Other tools and websites:**

Validate XML against XSD: https://www.freeformatter.com/xml-validator-xsd.html 

XSL Transformer (given XML and XSL as inputs): https://www.freeformatter.com/xsl-transformer.html#ad-output 

Validate JSON Schema: https://www.jsonschemavalidator.net/ 

