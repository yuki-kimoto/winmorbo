# winmorbo

Tool to make Mojolicious Development server "morbo" work well in Windows

# Usage

    winmorbo app.pl

# Description

In Windows, Mojolicious development server morbo don't work well
because worker process can't be receive parent TERM signal well.

For this reason, in windows, Web development is not fun and hard.

I hack Mojo::Server::Morbo in a simple way to make morbo work well in Windows.

# How to use winmorbo?

## Donwload winmorbo.bat

At first download **winmorb.bat** in your Mojolicious project directory.

Click winmorbo.bat on GitHub and click Raw button to download winmorbo.bat

## Excecute winmorbo.bat

Execute the following command.

You don't specify **.bat** extension because this is windows batch file.

In this example, Mojolicious application is **app.pl**.

    winmorbo app.pl

If you the follwoing window, it is success.

    C:\Users\kimot\labo>cmd /C perl -x -S winmorbo app.pl
    Server available at http://127.0.0.1:3000

If you stop Mojolicious application, you can use Ctrl + C.

## FAQ

### I see "Can't opendir(templates)" Error

This is Windows problem because Windows have **Templates** directory in user directory.

Mojolicious also use **templates** directory.

To resolve this problem, you create a directory, for example, **labo**.

    cd C:\Users\kimot
    mkdir labo
    cd labo

Let's create app.pl in labo diretory.
