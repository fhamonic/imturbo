script_folder="/home/plaiseek/Projects/imturbo/conan-build"
echo "echo Restoring environment" > "$script_folder/deactivate_conanbuildenv-release-x86_64.sh"
for v in CXX CC PATH
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/deactivate_conanbuildenv-release-x86_64.sh"
    else
        echo unset $v >> "$script_folder/deactivate_conanbuildenv-release-x86_64.sh"
    fi
done


export CXX="/usr/bin/g++-12"
export CC="/usr/bin/gcc-12"
export PATH="/home/plaiseek/.conan2/p/cmake8e5340c297c76/p/bin:$PATH"