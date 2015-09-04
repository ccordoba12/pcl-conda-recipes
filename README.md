Conda recipes to create packages for the Point Cloud Library (PCL)
and its Python bindings on Windows, Mac and Linux.

See http://pointclouds.org/

----

The build order to follow is this:

* `conda build pkg-config`
* `conda build cmake`       (only on Windows)
* `conda build eigen3`
* `conda build flann`
* `conda build icu`         (only on Linux and Mac)
* `conda build boost`
* `conda build vtk`         (only on Windows)
* `conda build gtest`       (only on Windows)
* `conda build pcl`
* `conda build python-pcl`
