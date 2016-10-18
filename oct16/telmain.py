'''
Created on Jun 8, 2015

@author: kleinwrt
'''
## \file
# main program
#
# telescope track finding and fitting

from eutelpy.telgear import GearSetup
from eutelpy.televent import TelEvent
from eutelpy.teltriplets import TelTriplets
from eutelpy.telfile import TelFile
from eutelpy.telalign import TelMP2alignment
from eutelpy.teltree import TelTree
from toolspy.simpleHists import SimpleHists
import time

if __name__ == '__main__':
  start = time.clock()
  # maximum number of events (with hits) to process
  maxEvt = 10000
  # beam energy (*q)
  #beamEnergy = -5.0  # 702
  #beamEnergy = -4.0  # 713
  #beamEnergy = -3.0  # 724
  #beamEnergy = -2.0  # 735
  beamEnergy = -1.0  # 746
  # lcio data file
  #dataFile = TelFile('data/run000746-hitmaker.slcio', 'local_hit')
  dataFile = TelFile('/nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000702-hitmaker.slcio', 'local_hit')
  /nfs/dust/ilc/user/bboitrel/Eutelescope/v01-17-05/Eutelescope/trunk/jobsub/examples/plume_desy_2016/output/lcio/run000702-hitmaker.slcio
  # text data file
  #dataFile = TelFile('allhits-613.dat')
  dataFile.open() 
  # GEAR file
  #gearFile = "gear/gear-713-746.xml"
  gearFile = "gear/gear-702.xml"
  #gearFile = "gear/gear-2020.xml"
  # Millepede-II alignment
  mp2 = TelMP2alignment("milleBinary.dat")
  mp2.open()  # open file for alignment
  # estimated alignment error (mimosa, DUT)
  #alignmentError = (0.001, 0.0025)
  alignmentError = (0.0, 0.01)
  # number of events to show event display
  displayEvents = 0
  # ROOT tree file
  #tree = None
  tree = TelTree("test.root")
  
  # parse gear file
  g = GearSetup(gearFile, alignmentError)
  bField = g.getBField()
  detector = g.getDetector()
  order = g.getMimosaOrder()
  # beam line constraint (at first detector layer in non-bending planes)
  # virtual measurement (average beam direction and divergence)
  #consBL = ((0.0, 0.0), (0.001, 0.001))
  consBL = None
  # fit DUT scattering ?
  #fitDUTscat = False
  fitDUTscat = True
  
  # create MP2 steering files
  # for mimosa planes determine positions and XY rotations, fix first plane and position of last as Reference
  parMimosa = [ '111001' for i in order]
  print ' parMimosa ', parMimosa
  # fix position and orientation of first plane
  parMimosa[order[0]] = 'RRRRRR'
  # fix position of last plane
  parMimosa[order[-1]] = 'RRR001'   
  if bField[1] != 0.:
    # for B field in Y fix X position of plane 3 in addition
    parMimosa[3] = 'R11001'
  # for DUT determine positions and (all) rotations
  parDUT = '111001'
  #parDUT = '101011'
  # combined alignment of DUTs (in common plane, need to have same intersection point with Z-axis in gear file)
  #combDUT = (6, 7)
  # don't combine DUTs
  combDUT = None
  mp2.createSteering("steer.txt", detector, parMimosa, parDUT, combDUT)
  #
  # Cuts in (X,Y) for triplet finder, DUT matching 
  #   (peak from true, background from random matches; tail in bending plane for B<>0, electrons)
  #   Doublet definition: X/Y-distances (mean depends on beam direction and Z-distance)
  #   Triplet definition: X/Y-distances of third hit to doublet (RMS = triplet resolution)
  #   Track definition: X/Y-slope differences of pair of triplets (RMS depends on Z-distances)
  #   Track definition: X/Y-position differences of pair of triplets (RMS depends on Z-distances)
  #   DUT matching: X/Y-distances of DUT hit to track (optionally different DUT types)
  #cuts = ((1., 1.), (0.05, 0.05), (0.01, 0.01), (0.2, 0.2), (10., 10.))  # iteration 1, no alignment, B off
  cuts = ((0.5, 0.5, 2.5, 2.5), (0.025, 0.025, 0.05, 0.05), (0.01, 0.01), (0.25, 0.25), (10., 1., 0.2, 0.25))  # 2058, B off

  # histograms for cut values
  #hists = None
  #hists = SimpleHists(("doubletDx", "doubletDy", "tripletDx", "tripletDy", "dslopeX", "dslopeY", \
  #                    "dposX", "dposY", "DUT-dx0", "DUT-dy0", "DUT-dx1", "DUT-dy1", "nTriplets", "nMatches", "match/triplet", "nSegments", \
  #                    "xScat", "yScat", "Pseg", "Pgbl"))  #
  hists = SimpleHists(("doubletDx0", "doubletDx1", "doubletDy0", "doubletDy1", "tripletDx0", "tripletDx1", "tripletDy0", "tripletDy1", "dslopeX", "dslopeY", \
                       "dposX", "dposY", "DUT-dx0", "DUT-dy0", "DUT-dx1", "DUT-dy1", "nTriplets", "nMatches", "match/triplet", "nSegments", "xScat", "yScat"))
  #
  numEvt = 0
  numTrack = 0
  while numEvt < maxEvt:
    event = TelEvent(detector, beamEnergy, bField)
    event.read(dataFile)
    if not event.isValid():
      break
    # event read
    if event.getNumHits() <= 0:
    #if event.getNumDUThits() <= 0:
      continue
    numEvt += 1 
    #event.dump()
    # triplet finder
    finder = TelTriplets(event.getHeader(), detector.keys(), order, cuts, hists)
    # find tracks and match DUT hits
    event.findTracks(finder, -40.)
    #print " DUTmatches ", finder.getDUTmatches()
    numTrack += event.getNumTracks()
    # fit segments
    event.fitGBL(mp2.getBinaryFile(), consBL, fitDUTscat)
    # display event and finder results
    if numEvt < displayEvents:      
      event.plot(False)
      finder.plotTriplets(False) 
      finder.plotSegments() 

    # analyze event
    #event.analyze(tree)
    event.analyzeScat()
    #event.analyzeMom(hists)
    
  dataFile.close()
  # write and close tree file 
  if tree is not None:
    tree.write()
  # plot/save histograms   
  if hists is not None:
    #hists.dump()
    #hists.plot()
    hists.save("cuts.pdf")
  print " Events ", numEvt
  print " Tracks ", numTrack
  end = time.clock()
  print " Time [s] ", end - start   
