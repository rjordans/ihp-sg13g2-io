v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
L 6 1740 -510 1740 10 {dash=20}
B 2 1370 -930 2170 -530 {flags=graph
y1=3.5
y2=18
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=2e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="pad
padres"
color="4 5"
dataset=-1
unitx=1
logx=0
logy=0
}
B 2 560 -930 1360 -530 {flags=graph
y1=0
y2=1.4
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=2e-06
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=4
node="I_ESD (A); 0 i(c1) -"}
T {VDD isn't used for this test,
 but give it a sane value anyway} 1920 -480 0 0 0.3 0.3 {}
T {outside IC} 1730 -500 1 0 0.4 0.4 {}
T {inside IC} 1770 -500 1 0 0.4 0.4 {}
N 1560 -300 1640 -300 {lab=pad}
N 1430 -300 1500 -300 {lab=#net1}
N 1870 -250 1890 -250 {lab=GND}
N 1890 -250 1890 -210 {lab=GND}
N 1870 -210 1890 -210 {lab=GND}
N 1890 -70 1890 -40 {lab=GND}
N 1870 -300 2150 -300 {lab=padres}
N 1870 -270 1930 -270 {lab=vdd}
N 1870 -230 1910 -230 {lab=iovdd}
N 1400 -360 1400 -340 {lab=vswitch}
N 1380 -360 1380 -340 {lab=GND}
N 1340 -360 1380 -360 {lab=GND}
N 1870 -70 1890 -70 {lab=GND}
N 1890 -110 1890 -70 {lab=GND}
N 1870 -110 1890 -110 {lab=GND}
N 1890 -210 1890 -110 {lab=GND}
N 1870 -90 1910 -90 {lab=iovdd}
N 1910 -230 1910 -90 {lab=iovdd}
N 1870 -130 1930 -130 {lab=vdd}
N 1930 -270 1930 -130 {lab=vdd}
N 1910 -90 1930 -90 {lab=iovdd}
N 1490 -130 1550 -130 {lab=iovdd_ext}
N 1610 -130 1640 -130 {lab=iovdd}
N 1040 -300 1150 -300 {lab=esd_precharge}
N 1210 -300 1370 -300 {lab=esd}
C {capa-2.sym} 1300 -270 0 0 {name=C1
m=1
value=100p
footprint=1206
device=polarized_capacitor}
C {res.sym} 1530 -300 1 0 {name=R1
value=1.5k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 1300 -240 0 0 {name=l1 lab=GND}
C {gnd.sym} 1890 -40 0 0 {name=l2 lab=GND}
C {launcher.sym} 290 -80 0 0 {name=h2
descr=SimulateNGSPICE
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults
puts $sim(spice,1,cmd) 

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,1,cmd) \{ngspice  \\"$N\\" -a\}

# change the simulator to be used (Xyce)
set sim(spice,default) 0

# run netlist and simulation
xschem netlist
simulate
"}
C {simulator_commands_shown.sym} 220 -480 0 0 {name=Libs_ngspice
simulator=ngspice
only_toplevel=false 
value="
** IHP models
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.include diodes.lib

.include sg13g2_stdcell.spice
.include sg13g2_io.spi

* IHP's IO library uses sub! for implicit substrate connections...
.global sub!
vsub gnd sub! 0

* Switch model
.MODEL SWITCH SW 
+ VT=0.9 VH=0.01
+ RON=0.01 ROFF=10G"
"}
C {simulator_commands_shown.sym} 220 -770 0 0 {name=Simulator1
simulator=ngspice
only_toplevel=false 
value="
.save all
.probe i(c1)
.control
  tran 0.1n 2u
  write esd_test_iopadanalog.raw

  rusage
  *quit
.endc
"
"}
C {devices/launcher.sym} 290 -40 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/esd_test_iopadanalog.raw tran"
}
C {lab_pin.sym} 1300 -300 1 0 {name=p1 sig_type=std_logic lab=esd}
C {lab_pin.sym} 1600 -300 1 0 {name=p2 sig_type=std_logic lab=pad}
C {sg13g2_IOPadAnalog.sym} 1790 -300 0 0 {name=x1}
C {gnd.sym} 2010 -360 0 0 {name=l3 lab=GND}
C {vsource.sym} 2010 -390 0 0 {name=V1 value=1.2 savecurrent=false}
C {lab_pin.sym} 1930 -90 0 1 {name=p3 lab=iovdd}
C {lab_pin.sym} 2150 -300 0 1 {name=p5 lab=padres}
C {lab_pin.sym} 1930 -270 0 1 {name=p6 lab=vdd}
C {lab_pin.sym} 2010 -420 0 1 {name=p7 lab=vdd}
C {capa-2.sym} 2000 -270 0 0 {name=C2
m=1
value=500f
footprint=1206
device=polarized_capacitor}
C {gnd.sym} 2000 -240 0 0 {name=l5 lab=GND}
C {switch_ngspice.sym} 1400 -300 1 0 {name=S1 model=SWITCH
}
C {lab_pin.sym} 1400 -360 0 1 {name=p9 lab=vswitch}
C {gnd.sym} 1340 -360 0 0 {name=l7 lab=GND}
C {sg13g2_IOPadIOVdd.sym} 1760 -100 0 0 {name=x2}
C {gnd.sym} 1510 -70 0 0 {name=l4 lab=GND}
C {vsource.sym} 1510 -100 0 0 {name=V2 value=3.3 savecurrent=false
}
C {lab_pin.sym} 1490 -130 0 0 {name=p8 lab=iovdd_ext}
C {res.sym} 1580 -130 1 0 {name=R2
value=10m
footprint=1206
device=resistor
m=1}
C {res.sym} 2130 -270 0 1 {name=R3
value=100MEG
footprint=1206
device=resistor
m=1}
C {gnd.sym} 2130 -240 0 0 {name=l8 lab=GND}
C {gnd.sym} 1060 -240 0 0 {name=l9 lab=GND}
C {vsource.sym} 1060 -270 0 0 {name=V4 value=2000 savecurrent=false
}
C {lab_pin.sym} 1040 -300 0 0 {name=p10 lab=esd_precharge}
C {gnd.sym} 1310 -400 0 0 {name=l11 lab=GND}
C {vsource.sym} 1310 -430 0 0 {name=V5 value="PULSE(0 1.2 0.1u 1n 1n 2u 20u 1)" savecurrent=false}
C {lab_pin.sym} 1310 -460 0 1 {name=p12 lab=vswitch}
C {res.sym} 1180 -300 1 0 {name=R4
value=100MEG
footprint=1206
device=resistor
m=1}
C {simulator_commands_shown.sym} -600 -780 0 0 {name=Simulator
simulator=xyce
only_toplevel=false 
value="
.preprocess replaceground true
.option temp=27
.tran 0.1n 2u
.print tran format=raw file=esd_test_iopadanalog.raw V(*) I(C1)
"
}
C {simulator_commands_shown.sym} -600 -480 0 0 {name=Libs_Xyce
simulator=xyce
only_toplevel=false 
value="tcleval(
.lib $::MODELS_XYCE/cornerMOSlv.lib mos_tt
.lib $::MODELS_XYCE/cornerMOShv.lib mos_tt
.lib $::MODELS_XYCE/cornerHBT.lib hbt_typ
.lib $::MODELS_XYCE/cornerRES.lib res_typ
.lib $::MODELS_XYCE/cornerCAP.lib cap_typ
.include $::MODELS_XYCE/diodes.lib

.include $::env(PDKPATH)/libs.ref/$::env(STD_CELL_LIBRARY)/spice/sg13g2_stdcell.spice
.include $::env(PDKPATH)/libs.ref/sg13g2_io/spice/sg13g2_io.spi

* IHP's IO library uses sub! for implicit substrate connections...
.global sub!
vsub gnd sub! 0

.MODEL SWITCH VSWITCH (VON=0.9 VOFF=0 RON=0.01 ROFF=10G)
)"}
C {launcher.sym} -540 -140 0 0 {name=h1
descr=SimulateXyce
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,3,cmd) \{Xyce -plugin $env(PDK_ROOT)/$env(PDK)/libs.tech/xyce/plugins/Xyce_Plugin_r3_cmc.so,$env(PDK_ROOT)/$env(PDK)/libs.tech/xyce/plugins/Xyce_Plugin_PSP103_VA.so \\"$N\\"\}

# change the simulator to be used (Xyce)
set sim(spice,default) 3

# run netlist and simulation
xschem netlist
simulate
"}
