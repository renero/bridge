bridge
======

Get Hadoop logs from S3 (in Python) and nicely display main ones in Cocoa App.Communicating Objective-C and Python
====================================
It happens, sometimes, that whatever you need from your application is far more easily to be developed using a language like Python than trying to code everything in Objective C. I think there're two reasons for that:

1. A language like Python obviously allows you to get a proof of concept more quickly.
2. Python has a larger amount of contributions to help you with that specific task you've in mind.

To me, it was clearly the second. I don't rush when it comes to develop an application. I usually write code for the pleasure of doing it, so doing it quickly simply does not apply to my case. But when I started with Objective-C, I got frustrated a couple of times, when I couldn't find any straightforward mechanism to accomplish some of the tasks I wanted to incorporate into my app.

I started reading about the possibility of communicating Python and Objective-C one month ago, and surprisingly I couldn't find any good example that will simply bring me there. Either, the examples were focused on very specific topics on how both languages bridge together, or don't have all the information so that they are difficult to extend. I haven't written a page like this in years, since my times in the University, so I apologize in advance for inaccuracies, or lack of precision. I did this for fun, but in any case, any comments are welcome.

My understanding
----------------
I have been using the py2app way of communicating Objective C and Python. ``py2app`` is a Python ``setuptools`` command which will allow you to make standalone application bundles and plugins from Python scripts.
