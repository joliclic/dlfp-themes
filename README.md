A dark CSS theme for linuxfr.org
================================

CSS compilations
----------------

You need [Sass](https://sass-lang.com/)

to compile all css in the public dir:

    sh build.sh

to compile a particular css:

    sass src/dark-faithfull-app.scss public/dark-faithfull.css
or

    sass --style compressed src/dark-faithfull-app.scss public/dark-faithfull.min.css

other example:

    sass src/original-app.scss public/original.css
or

    sass --style compressed src/original-app.scss public/original.min.css


Create a new set of colored icons
---------------------------------

To create a new set of icons with another color than the current `#4E4E50` 
color, for example `#0000ff`:

    sh create-icons.sh 0000ff

This will create (and erase an eventual existing one) the folder 
public/images/icones-0000ff, copy inside all the content of public/images/icones 
then change the color of the concerned svg files, and create and optimize their 
respective relative png file.

To create the png, [svgexport](https://github.com/shakiba/svgexport) or inkscape
must be installed. 
If [trimage](https://trimage.org/) is installed, it will be used to optimize the 
generated pngs.


Screenshots
-----------

dark-faithfull:
![](screenshots/dark-faithfull.png)

original:
![](screenshots/original.png)
