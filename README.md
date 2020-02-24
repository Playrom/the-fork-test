#  Notes on the test

i've noticied that a lot of pictures, expecially the pics_diaporama of width 1350px, returns a 404 error when the HTTP Request is performed, so if you notice some images missing with a gray background the reason is this one.

The Model classes has been generated using the website https://app.quicktype.io , and they have been adapted after the generation analyzing the possible type of each attribute from the json itself, but the parsing can fail becouse there is no documentation of the endpoint. ( example a integer could be in reality a double, but i have not any information about that ).

Wherever is possible i'm using a sort of MVVM architecture, creating some simple view models.

I've mostly left the code comment-less becouse all the classes and views are pretty simple and self-descripting, and it's useless to wrote dozens of comments describing a line of code if this line is clear and simple to understand the reason why it has been wrote.

I've create just a few unit tests, becouse the only "logic" of the app is the download of a JSON from remote. UI Testing may be useful but they were outside the scope of this project requirements.
