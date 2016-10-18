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
from toolspy.simpleHists import SimpleHists
import time

if __name__ == '__main__':
  start = time.clock()
  # maximum number of events (with hits) to process
  maxEvt = 10000
  # beam energy (*q)
  beamEnergy = -5.0  # 680
  # lcio data file
  dataFile = TelFile('run000680-hitmaker.slcio', 'hit')
  # text data file
  #dataFile = TelFile('allhits-613.dat')
  dataFile.open() 
  # GEAR file
  gearFile = "gear.xml"
  # Millepede-II alignment
  mp2 = TelMP2alignment("milleBinary.dat")
  mp2.open()  # open file for alignment
  # estimated alignment error (mimosa, DUT)
  alignmentError = (0.025, 0.025)
  # number of events to show event display
  displayEvents = 0
  
  # parse gear file
  g = GearSetup(gearFile, alignmentError)
  bField = g.getBField()
  detector = g.getDetector()
  # create MP2 steering files
  # for mimosa planes determine positions and XY rotations, fix first plane and position of last as Reference
  parMimosa = ['RRRRRR', '111001', '111001', '111001', '111001', 'RRR001']
  if bField[1] != 0.:
    # for B field in Y fix X position of plane 3 in addition
    parMimosa[3] = 'R11001'
  # for DUT determine positions and (all) rotations
  parDUT = '111001'
  # combined alignment of DUTs (in common plane, need to have same intersection point with Z-axis in gear file)
  #combDUT = (6, 7)
  # don't combine DUTs
  combDUT = None
  mp2.createSteering("steer.txt", detector, parMimosa, parDUT, combDUT)
  #
  # Cuts in (X,Y) for triplet finder, DUT matching 
  #   (peak from true, background from random matches; tail in bending plane for B<>0, electrons)
  #   Doublet definition: X/Y-distances (mean depends on beam direction and Z-distance)
  #   Triplet definition: X/Y-distances of third hit to doublet (RMS = triplet resolution), 'None' to use doublets directly 
  #   Track definition: X/Y-slope differences of pair of triplets (RMS depends on Z-distances)
  #   Track definition: X/Y-position differences of pair of triplets (RMS depends on Z-distances)
  #   DUT matching: X/Y-distances of DUT hit to track
  #cuts = ((2., 2.), None, (0.01, 0.01), (1., 1.), (5., 5.))  # iteration 1, no alignment, B off
  cuts = ((1., 1.), None, (0.0025, 0.0025), (0.1, 0.1), (0.25, 0.25))  # iteration 2, some alignment, B off
  # histograms for cut values
  #hists = None
  hists = SimpleHists(("doubletDx", "doubletDy", "tripletDx", "tripletDy", "dslopeX", "dslopeY", \
                      "dposX", "dposY", "DUT-dx", "DUT-dy", "nTriplets", "nMatches", "match/triplet", "nSegments", \
                      "xScat", "yScat"))  #
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
    finder = TelTriplets(event.getHeader(), detector.keys(), cuts, hists)
    # find tracks and match DUT hits
    event.findTracks(finder, -40.)
    #print " DUTmatches ", finder.getDUTmatches()
    numTrack += event.getNumTracks()
    # fit segments
    event.fitGBL(mp2.getBinaryFile())
    # display event and finder results
    if numEvt < displayEvents:      
      event.plot(False)
      finder.plotTriplets(False) 
      finder.plotSegments() 

    # analyze event
    #event.analyze()
    #event.analyzeScat(hists)
    #event.analyzeRes()
   
  dataFile.close()  
  if hists is not None:
    #hists.dump()
    #hists.plot()
    hists.save("cuts.pdf")
  print " Events ", numEvt
  print " Tracks ", numTrack
  end = time.clock()
  print " Time [s] ", end - start   
