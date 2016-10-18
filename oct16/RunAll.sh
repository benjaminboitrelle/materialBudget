#!/bin/bash
source PYROOT

## Cut values @ 5 GeV
#DoubletCutXMin=-20.0
#DoubletCutXMax=20.0
#DoubletCutYMin=-20.0
#DoubletCutYMax=20.0
#TripletCutXMin=-20.0
#TripletCutXMax=20.0
#TripletCutYMin=-20.0
#TripletCutYMax=20.0
#SlopeXMin=-1.0
#SlopeXMax=1.0
#SlopeYMin=-1.0
#SlopeYMax=1.0
#PositionXMin=-20.0
#PositionXMax=20.0
#PositionYMin=-20.0
#PositionYMax=20.0

## Cut values @ 5 GeV
#DoubletCutXMin=-0.5
#DoubletCutXMax=0.5
#DoubletCutYMin=-0.5
#DoubletCutYMax=0.5
#TripletCutXMin=-0.05
#TripletCutXMax=0.05
#TripletCutYMin=-0.05
#TripletCutYMax=0.05
#SlopeXMin=-0.002
#SlopeXMax=0.002
#SlopeYMin=-0.002
#SlopeYMax=0.002
#PositionXMin=-0.1
#PositionXMax=0.1
#PositionYMin=-0.1
#PositionYMax=0.1

## Cut values @ 4 GeV
#DoubletCutXMin=-1.0
#DoubletCutXMax=1.0
#DoubletCutYMin=-1.0
#DoubletCutYMax=1.0
#TripletCutXMin=-0.05
#TripletCutXMax=0.05
#TripletCutYMin=-0.05
#TripletCutYMax=0.05
#SlopeXMin=-0.001
#SlopeXMax=0.001
#SlopeYMin=-0.001
#SlopeYMax=0.001
#PositionXMin=-0.1
#PositionXMax=0.1
#PositionYMin=-0.1
#PositionYMax=0.1

## Cut values @ 3 GeV
#DoubletCutXMin=-1.0
#DoubletCutXMax=1.0
#DoubletCutYMin=-1.0
#DoubletCutYMax=1.0
#TripletCutXMin=-0.05
#TripletCutXMax=0.05
#TripletCutYMin=-0.05
#TripletCutYMax=0.05
#SlopeXMin=-0.004
#SlopeXMax=0.004
#SlopeYMin=-0.004
#SlopeYMax=0.004
#PositionXMin=-0.25
#PositionXMax=0.25
#PositionYMin=-0.25
#PositionYMax=0.25

## Cut values @ 1 GeV
#DoubletCutXMin=-1.0
#DoubletCutXMax=1.0
#DoubletCutYMin=-1.0
#DoubletCutYMax=1.0
#TripletCutXMin=-0.05
#TripletCutXMax=0.05
#TripletCutYMin=-0.05
#TripletCutYMax=0.05
#SlopeXMin=-0.004
#SlopeXMax=0.004
#SlopeYMin=-0.004
#SlopeYMax=0.004
#PositionXMin=-0.35
#PositionXMax=0.35
#PositionYMin=-0.35
#PositionYMax=0.35

# Gear file:
GearFile=geometry/gear_5GeV.xml
#GearFile=geometry/gear_4GeV.xml
#GearFile=geometry/gear_3GeV.xml
#GearFile=geometry/gear_2GeV.xml
#GearFile=geometry/gear_1GeV.xml

# Hitmaker:
Hitmaker=/nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000702-hitmaker.slcio
#Hitmaker=/nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000713-hitmaker.slcio
#Hitmaker=/nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000724-hitmaker.slcio
#Hitmaker=/nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000735-hitmaker.slcio
#Hitmaker=/nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000746-hitmaker.slcio

# Energy:
Energy=5.0
#Energy=4.0
#Energy=3.0
#Energy=2.0
#Energy=1.0

# Output:
Output=plume5GeV_run702
#Output=plume4GeV_run713
#Output=plume3GeV_run724
#Output=plume2GeV_run735
#Output=plume1GeV_run746

#Alignment step
#./telmain.py -o ${Output} -a True --alignerror 0.005 -e 2000 -f ${Hitmaker} -g ${GearFile} -b ${Energy} --cuts ${DoubletCutXMin} ${DoubletCutXMax} ${DoubletCutYMin} ${DoubletCutYMax} ${TripletCutXMin} ${TripletCutXMax} ${TripletCutYMin} ${TripletCutYMax} ${SlopeXMin} ${SlopeXMax} ${SlopeYMin} ${SlopeYMax} ${PositionXMin} ${PositionXMax} ${PositionYMin} ${PositionYMax}

# Kink Angle measurement
./telmain.py -o ${Output} -e 200000 -f ${Hitmaker} -g ${GearFile} -b ${Energy} --cuts ${DoubletCutXMin} ${DoubletCutXMax} ${DoubletCutYMin} ${DoubletCutYMax} ${TripletCutXMin} ${TripletCutXMax} ${TripletCutYMin} ${TripletCutYMax} ${SlopeXMin} ${SlopeXMax} ${SlopeYMin} ${SlopeYMax} ${PositionXMin} ${PositionXMax} ${PositionYMin} ${PositionYMax}


##Tin Foil (No DUT) Alignment 1
#./telmain.py -o tinNoDUT -a True --alignerror 1 -f /nfs/dust/atlas/user/hamnett/ilcsoft-24072015/v01-17-05/Eutelescope/trunk/jobsub/examples/GBL/X0/output/lcio/run002594-hitlocal.slcio -g gear_carbon.xml -b -4.4 --cuts -0.5 0.5 -0.5 0.5 -0.1 0.1 -0.1 0.1 -0.001 0.001 -0.001 0.001 -0.1 0.1 -0.1 0.1 -e 1000
##Tin Foil (No DUT) Alignment 2
#./telmain.py -o tinNoDUT -a True --alignerror 0.018 -f /nfs/dust/atlas/user/hamnett/ilcsoft-24072015/v01-17-05/Eutelescope/trunk/jobsub/examples/GBL/X0/output/lcio/run002594-hitlocal.slcio -g gear_tin.xml -b -4.4 --cuts -0.5 0.5 -0.5 0.5 -0.1 0.1 -0.1 0.1 -0.001 0.001 -0.001 0.001 -0.1 0.1 -0.1 0.1 -e 1000
##Tin Foil (No DUT) Alignment 3
#./telmain.py -o tinNoDUT -a True --alignerror 0.003 -f /nfs/dust/atlas/user/hamnett/ilcsoft-24072015/v01-17-05/Eutelescope/trunk/jobsub/examples/GBL/X0/output/lcio/run002594-hitlocal.slcio -g gear_tin.xml -b -4.4 --cuts -0.2 0.2 -0.2 0.2 -0.01 0.01 -0.01 0.01 -0.00025 0.00025 -0.00025 0.00025 -0.025 0.025 -0.025 0.025 -e 1000

#Tin Foil 0.25mm
#./telmain.py -o tin1.0mm5.0GeV -f /nfs/dust/atlas/user/hamnett/ilcsoft-24072015/v01-17-05/Eutelescope/trunk/jobsub/examples/GBL/X0/output/lcio/run002616-hitlocal.slcio -g gear_tin1.0mm.xml -b -5.0 --cuts -0.2 0.2 -0.2 0.2 -0.01 0.01 -0.01 0.01 -0.00025 0.00025 -0.00025 0.00025 -0.025 0.025 -0.025 0.025 -e 1000

## PLUME
#./telmain.py -o plume2GeV -a True  --alignerror 0.006 -e 1000 -f /nfs/dust/ilc/user/bboitrel/gbl_MaterialBudget/run000836-hitmaker.slcio -g geometry/gear.xml -b 2.0 --cuts -1 1 -1 1 -0.01 0.01 -0.01 0.01 -0.005 0.005 -0.005 0.005 -0.25 0.25 -0.25 0.25 

## Alignment done (because Phill finds no align confusing)
#./telmain.py -o plume2GeV -e 10000 -f /nfs/dust/ilc/user/bboitrel/gbl_MaterialBudget/run000836-hitmaker.slcio -g geometry/gear.xml -b 2.0 --cuts -1 1 -1 1 -0.01 0.01 -0.01 0.01 -0.005 0.005 -0.005 0.005 -0.25 0.25 -0.25 0.25 


## PLUME - 5 GeV
#./telmain.py -o plume5GeV -a True --alignerror 0.003 -e 1000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000824-hitmaker.slcio -g geometry/gear5gev.xml -b 5.0 --cuts -0.5 0.5 -0.5 0.5 -0.01 0.01 -0.01 0.01 -0.005 0.005 -0.005 0.005 -0.15 0.15 -0.15 0.15
#./telmain.py -o plume5GeV -a True --alignerror 0.003 -e 1000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000824-hitmaker.slcio -g geometry/gear5gev.xml -b 5.0 --cuts -1.5 1.5 -1.5 1.5 -1.1 1.1 -1.1 1.1 -0.5 0.5 -0.5 0.5 -1.15 1.15 -1.15 1.15
#./telmain.py -o plume5GeV -a True --alignerror 0.003 -e 1000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000824-hitmaker.slcio -g geometry/gear5gev.xml -b 5.0 --cuts -0.5 0.5 -0.5 0.5 -0.01 0.01 -0.01 0.01 -0.005 0.005 -0.005 0.005 -0.15 0.15 -0.15 0.15

#PLUME 5 GeV Alignment done
#./telmain.py -o plume5GeV_run824 -e 200000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000824-hitmaker.slcio -g geometry/gear5gev.xml -b 5.0 --cuts -0.5 0.5 -0.5 0.5 -0.01 0.01 -0.01 0.01 -0.005 0.005 -0.005 0.005 -0.15 0.15 -0.15 0.15
#./telmain.py -o plume5GeV_run825 -e 200000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000825-hitmaker.slcio -g geometry/gear5gev.xml -b 5.0 --cuts -0.5 0.5 -0.5 0.5 -0.01 0.01 -0.01 0.01 -0.005 0.005 -0.005 0.005 -0.15 0.15 -0.15 0.15

# PLUME - 3 GeV Kink angle
#DoubletCutXMin=-0.5
#DoubletCutXMax=0.5
#DoubletCutYMin=-0.5
#DoubletCutYMax=0.5
#TripletCutXMin=-0.08
#TripletCutXMax=0.08
#TripletCutYMin=-0.1
#TripletCutYMax=0.1
#SlopeXMin=-0.004
#SlopeXMax=0.004
#SlopeYMin=-0.004
#SlopeYMax=0.004
#PositionXMin=-0.4
#PositionXMax=0.4
#PositionYMin=-0.4
#PositionYMax=0.4
#./telmain.py -o plume3GeV_run724 -a True --alignerror 0.003 -e 2000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000724-hitmaker.slcio -g geometry/gear_x0.xml -b 3.0 --cuts ${DoubletCutXMin} ${DoubletCutXMax} ${DoubletCutYMin} ${DoubletCutYMax} ${TripletCutXMin} ${TripletCutXMax} ${TripletCutYMin} ${TripletCutYMax} ${SlopeXMin} ${SlopeXMax} ${SlopeYMin} ${SlopeYMax} ${PositionXMin} ${PositionXMax} ${PositionYMin} ${PositionYMax}
#./telmain.py -o plume3GeV_run724 -a True --alignerror 0.008 -e 2000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000724-hitmaker.slcio -g geometry/gear_x0.xml -b 3.0 --cuts -12.0 12.0 -12.0 12.0 -20.04 20.04 -20.04 20.04 -0.3 0.3 -0.3 0.3 -50.1 50.1 -50.1 50.1

#./telmain.py -o plume3GeV_run724 -e 2000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000724-hitmaker.slcio -g geometry/gear_x0.xml -b 3.0 --cuts ${DoubletCutXMin} ${DoubletCutXMax} ${DoubletCutYMin} ${DoubletCutYMax} ${TripletCutXMin} ${TripletCutXMax} ${TripletCutYMin} ${TripletCutYMax} ${SlopeXMin} ${SlopeXMax} ${SlopeYMin} ${SlopeYMax} ${PositionXMin} ${PositionXMax} ${PositionYMin} ${PositionYMax}

###################################
# PLUME - 3 GeV with hitmaker global
#./telmain.py -o plume3GeV_run724 -a True --alignerror 0.008 -e 2000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000724-hitmaker.slcio -g geometry/gear_x0_triplets.xml -b 3.0 --cuts -2.0 2.0 -2.0 2.0 -0.04 0.04 -0.04 0.04 -0.003 0.003 -0.003 0.003 -0.1 0.1 -0.1 0.1

# PLUME - 3 GeV Alignment done with hit maker global
#./telmain.py -o plume3GeV_run724 -e 1000 -f /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000724-hitmaker.slcio -g geometry/gear_x0_triplets.xml -b 3.0 --cuts -2.0 2.0 -2.0 2.0 -0.04 0.04 -0.04 0.04 -0.003 0.003 -0.003 0.003 -0.1 0.1 -0.1 0.1

