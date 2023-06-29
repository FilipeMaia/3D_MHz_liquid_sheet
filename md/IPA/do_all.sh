#!/bin/zsh
# DESY's Maxwell specific modules
source /etc/profile.d/modules.sh
module load maxwell
module load gromacs/2021.4
gmx grompp -f minim.mdp -c out.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
gmx grompp -f nvt.mdp -c em.gro -p topol.top -o nvt.tpr
gmx mdrun -v -deffnm nvt
gmx grompp -f npt -c nvt.gro -p topol.top -o npt.tpr
gmx mdrun -v -deffnm npt
echo 0 | gmx saxs -f npt.trr -s npt.tpr -xvg none -energy 8 -endq 20 -dt 5
