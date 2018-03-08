A dark CSS theme for linuxfr.org

to compile the css:
sass src/darkyronron-app.scss public/darkyronron.css
or
sass --style compressed src/darkyronron-app.scss public/darkyronron.css

sass src/original-app.scss public/original.css


To create a new set of icons with another color than the current #4E4E50 color,
for example #0000ff:
sh create-icons.sh 0000ff

This will create (and erase an eventual existing one) the folder 
public/images/icones-0000ff, copy inside all the content of public/images/icones
then change the color of the concerned svg files, and create and optimize their 
respective relative png file.
To create the png, svgexport (https://github.com/shakiba/svgexport) or inkscape
must be installed. 
If trimage (https://trimage.org/) is installed, it will be used to optimize the 
generated pngs.


TODO:
Should we adapt common/statitics.scss and common/markitup.scss too? 
