# Building Python Containers

Managing Python dependencies can be challenging. This guide covers how to use
Docker to iterate over a set of dependencies to find a stable image. This 
image can then be used in different environments without dependency drift or
other dependency-related issues.

## Requirements

You'll need to have Docker installed. Follow instructions from the [official
documentation](https://docs.docker.com/get-docker/).

## Project Structure

I suggest that you place a `requirements.txt` file at the root of your project.
That file will contain all the dependencies you need to correctly setup
your environment.

```shell
.
├── requirements.txt
└── src
    ├── model.py
    └── __init__.py
```

We will iterate over the contents of `requirements.txt`.

## Base Image

I suggest chosing an official Docker Hub image for the version of Python
that is compatible with your project. For example, if you need Python 3.8
then use:

```
FROM python:3.8
```

You can find a list of images here: https://hub.docker.com/_/python

## Dockerfile

Let's put a `Dockerfile` together that copies both the source code and the
`requirements.txt` file then installs your requirements in the image.

```dockerfile
FROM python:3.8

RUN mkdir /project


COPY . /project
COPY requirements.txt project/requirements.txt

WORKDIR /project
RUN pip install -r requirements.txt
```

Then we can attempt to build the image. If the requirements are compatible
and correct then the image will be correctly.

```shell
$ docker build . --tag test
```
If the image builds correctly, the dependencies can resolve as expected.
If they cannot then you can:

1. iterate over the version of packages in `requirements.txt`
2. install additional system packages using `RUN`

## Testing the Image

After the image builds successfully, you can run your script inside the image
with:

```shell
$ docker run test python src/model.py
PyTorch Lightning correctly installed. Version: 1.4.1
```
