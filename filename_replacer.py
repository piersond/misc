import os

### user specify #################
target_folder = 'C:\SOM_temp'
replace_what = 'a'
replace_with = 'z'
##################################


# Run script
##################################
paths = (os.path.join(root, filename)
        for root, _, filenames in os.walk(target_folder)
        for filename in filenames)

for path in paths:
    newname = path.replace(replace_what, replace_with)
    if newname != path:
        os.rename(path, newname)
