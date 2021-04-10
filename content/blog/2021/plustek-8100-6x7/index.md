Title: Modifying a Plustek 8100 to Scan Medium Format 
Date: 2021-1-17 13:00:00
Modified: 2021-1-31 13:00:00
Authors: Christian Chapman
Slug: plustek-8100-6x7
---

The Plustek 8100 is a popular entry-level 35mm film scanner. It produces significantly higher resolution scans than any accessibly priced flatbed scanner but is limited to film formats smaller than 35mm. 
This page details an effort to relax this limitation. 

The punchline is that a modified Plustek 8100 can be used to image a 6×7 film frame by stitching together 4 sweeps, together taking around 6 minutes per frame at the highest resolution setting. 
If we are to believe [filmscanner.info's claim that it captures 3800 ppi](https://www.filmscanner.info/en/PlustekOpticFilm8100.html), we end up with almost 84 effective megapixels or a 33"×28" print at 300 dpi.
It also allows inclusion of borders in plain 35mm scans. 

![Imgur-hosted screenshot of a darktable inversion of a 7200ppi medium format scan, zoomed to 3600ppi](https://imgur.com/vUOe5VX.jpg)

Two changes are involved:

 - Modify the driver to sweep the scan head longer than usual ("taller" in terms of the image plane).
 - Replace a part on the film carriage with one that avoids the scan head's field of view.

My guess is most of this post applies identically to similar-looking Plustek scanners (7200, 7400, 7600i, 8200i) but I can't test this.

## Software

The usual interfaces to this scanner only produce captures of a ~36×24mm region.
Up until a few months ago this device was limited to use with expensive proprietary software (SilverFast, VueScan). 
No longer, thanks to a recent update to the `sane-genesys` backend ([Link to gitlab, cf sane-backends 1.0.31 NEWS](https://gitlab.com/sane-project/backends/-/blob/master/NEWS)). 
With this software, all that is needed to make the 8100 perform longer sweeps is to change some values in the source.
The necessary changes are in a github repository here: 

[Link to github](https://github.com/enthdegree/sane-backends). 

Only the `genesys` backend needs to be compiled.

## Hardware

The film carriage must be modified to enlarge the scanning stage. As it is, the scanner's view is obscured by the carriage for part of the sweep we want. Here a picture of the inside of the device and what needs to be removed: 

![Imgur-hosted picture of the inside of a Plustek 8100 with a frame drawn around the part that needs to go](https://i.imgur.com/QRH0GLB.jpg)

It isn't that difficult to get the part off, but I was conscious of keeping the scan head aperture clean during my process. 
Here is a render of the replacements and their Thingiverse link:

![Imgur-hosted render of the modified carriage pieces](https://imgur.com/vXAVbAo.png)

> [Link to Thingiverse](https://www.Thingiverse.com/thing:4726748).

For fun, here is a picture of the measurements I took to help sketch this in FreeCAD:

![Imgur-hosted picture of carriage measurements](https://i.imgur.com/wfQFVzn.jpg)

Next here's a look at how the prototype parts fit into the carriage.
The parts in this picture actually had too much material on them and couldn't accomodate the larger tray, so I shaved them down. 
I've included these modifications in the Thingiverse files and the render shown up above.

![Imgur-hosted picture of carriage with prototype parts installed](https://i.imgur.com/Pp9UbMh.jpg).


## Scanning

I also designed and printed a crude scan tray. Its files are available in the above Thingiverse link.

![Imgur-hosted picture of the scan tray with film in it](https://imgur.com/52OQbCB.jpg)

A single 6×7 frame must be run 4 times, once for each quadrant, then stitched together. 
Here is a script I wrote to automate this process: 

> [plustek120.sh](blog/2021/plustek-8100-6x7/plustek120.sh). 

This script automatically previews and captures the files, then runs them through a panotools autostitch procedure.
Something went wrong with my scanner and now it creates really strong vertical bands right at the Nyquist frequency. 
I include a 5×5 low-pass step in my script to get rid of this. 
The filter's stop frequency is well beyond the scanner's optical resolution so there's no significant loss in suppressing it. 

---

Here is how a raw scan looks after a darktable inversion, along with some dust and fingerprints:
![Imgur-hosted picture of the merge result of a picture I took on my apartment roof](https://i.imgur.com/dgQ39eT.png)

![Imgur-hosted picture of another merge result.](https://imgur.com/BEqZSbQ.png)

One issue is that my scan tray design is really flimsy. 
This can be remediated with more practice and a better tray design! 

