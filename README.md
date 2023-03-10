okay imagine you want to copy want to transfer a directory of text files to your server.
you have access to the terminal there, so you can paste something in.
easy, `tar -cz ... | base64`, copy, `base64 -d | tar -xz`, paste, ctrl+d.

but what if you for some reason wanted to be able to keep that copied thing around and edit it?
you could probably hack up a shell script to `mkdir ...` and `cat >...`.

**dump.sh** is a little program for generating that shell script.

## example use

```console
$ ls -l test
total 12
drwxr-xr-x 2 wh0 wh0 4096 Mar  9 22:31 directory
-rwxr-xr-x 1 wh0 wh0    5 Mar  9 22:31 executable
-rw-r--r-- 1 wh0 wh0    3 Mar  9 22:31 file
lrwxrwxrwx 1 wh0 wh0    4 Mar  9 22:31 symlink -> file
$ dump.sh t
mkdir test
cat >test/file <<'DUMP_EOF'
hi
DUMP_EOF
cat >test/executable <<'DUMP_EOF'
true
DUMP_EOF
chmod +x test/executable
ln -s file test/symlink
mkdir test/directory
```

## suitability

**works with:**

- well-behaved text files
- directories
- symbolic links
- the execute bit

**doesn't work with:**

- binary files
- text files that don't have a newline at the end
- text files that have the `DUMP_EOF` delimiter
- weird files like block/character special, named pipes, and sockets
- any permissions and other metadata
- situations where you're worried about overwriting anything when extracting

## q&a

**so how do I insta--**

it's a one-liner.
just copy it and paste it into your command line.

**what if I need t--**

then use tar.

**yeah but I--**

then use [shar](https://www.gnu.org/software/sharutils/).

**oh no it just--**

refer to the license for your options.
