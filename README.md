citibase-csv
============

Interface for UofT CHASS Citibase access.  Use this to get CSV results on the command line.  citiq.sh creates a file called [query].csv containing data series.

Usage
-----

```
citiq.sh [ezproxy-cookie] [query]
```

for example

```
citiq.sh 0a1b2c3d4e5f EXRCAN
```

Determine the ezproxy cookie by looking at the request headers of an authenticated browser session. Finding the cookie is beyond the scope of this script.  If you don't have access to the CHASS API, then I can't help you.

Author
------

Ian Dennis Miller (iandennismiller@gmail.com)
