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

## Acknowledgments

This work is based on the work of [Andreas Hontzia](https://github.com/honze-net). Special thanks!
