# Libpostal Docker

This project provides a simple two-step process to try the [Libpostal](https://github.com/openvenues/libpostal) address parsing library in its interactive mode.

It also includes the Python [pypostal](https://github.com/openvenues/pypostal) library for you to try.

## Prerequisites

The only prerequisite for this project is Docker. If you don't have it installed, you can download it from [here](https://www.docker.com/products/docker-desktop).

## TLDR Interactive Mode

This mode lets you type addresses and see how Libpostal parses them. To run it, use the following three commands:

```bash
docker pull rjurney/libpostal-docker:latest
docker run -it rjurney/libpostal-docker:latest bash
../libpostal/src/address_parser
```

## Trying the PyPostal Python Library

To run the Libpostal Docker container, you can use the following commands:

```bash
docker pull rjurney/libpostal-docker:latest
docker run -it rjurney/libpostal-docker:latest bash
ipython
```

And import and use the [pypostal](https://github.com/openvenues/pypostal) library:

```python
from postal.parser import parse_address

parse_address("781 Franklin Ave Crown Heights Brooklyn NYC NY 11216 USA")
```

You should see the result:

```python
Out[2]:
[('781', 'house_number'),
 ('franklin ave', 'road'),
 ('crown heights', 'suburb'),
 ('brooklyn', 'city_district'),
 ('nyc', 'city'),
 ('ny', 'state'),
 ('11216', 'postcode'),
 ('usa', 'country')]
```

## Author

This project was created out of love for [Libpostal](https://github.com/openvenues/libpostal) by [Russell Jurney](https://www.linkedin.com/in/russelljurney/).
