# nmap-bootstrap4-xsl

A Nmap XSL implementation with Bootstrap 4.

## Usage

- Add the `nmap-bootstrap4.xsl` as stylesheet to your Nmap scan. 
- Example: 

```sh
nmap -sS -T4 -A -sC -oA scanme --stylesheet https://github.com/anwiese/nmap-bootstrap4-xsl/raw/master/nmap-bootstrap4.xsl scanme.nmap.org scanme2.nmap.org
```

- Open the scanme.xml with your Web browser.

- Alternatively you can transform the xml to html with

```sh
xsltproc -o scanme.html nmap-bootstrap4.xsl scanme.xml
```

- You will need to download the nmap-bootstrap4.xsl beforehand.

- The third way is to use a online tool like [Free Online XSLT Test Tool](https://xslttest.appspot.com/).

## License

This project is licensed under [![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

## Acknowledgments

This work is based on the work of [Andreas Hontzia](https://github.com/honze-net). Special thanks!
