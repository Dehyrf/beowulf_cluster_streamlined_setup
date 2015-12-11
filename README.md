# beowulf_cluster_streamlined_setup


## Synopsis

This project was created to simplify the setting up of beowulf cluster computing systems. This setup tool will reduce the time needed to go from computing hardware to a fully-functional cluster that can run C, C++ and Fortran programs on the collective computing power of your cluster using MPICH. 

## Prerequisites

For this project's hardware, you will need a computer dedicated for use as a master compute node, at least one slave node, a gateway (router), and an ethernet switch if you have enough nodes to fill up your router's ports and then some. For software, all nodes should be running linux, and more specifically, a debian based OS like Trisquel, Ubuntu, or Debian. For use with other distros, you may need to modify the script for the distro-specific commands. Finally, you will need a flash drive with the contents of this repository downloaded on it and temporary internet access at the beginning of the setup process. 

## Installation



## Tests

These setup scripts were tested on the following debian based systems: Trisquel 7.0, Raspbian, and Xubuntu.

## Resources

For reference in this project, I used material and examples from others during setup. For troubleshooting or research please visit the [best setup guide I found online](https://hemprasad.wordpress.com/2014/12/25/building-a-beowulf-cluster-with-ubuntu/). 

## License

This setup guide is open and is licensed under [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html) for your use, modification, and distribution.
