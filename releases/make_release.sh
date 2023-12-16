# get directory paths
releases=$(cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)
parent=$(dirname $releases)
src=$parent/src

# get release info
name=$(jq .name $src/info.json -r)
version=$(jq .version $src/info.json -r)

# copy src files into tmp dir with name $name
cd $releases
mkdir tmp
mkdir tmp/$name
cp $src/* tmp/$name -r

# create zip file
cd tmp
zip -r $releases/$name"_"$version.zip $name

# remove tmp dir
cd $releases
rm -rf tmp


