application(1).
application(2).
task(1,1).
task(1,2).
task(10,1).
task(10,2).
task(13,1).
task(13,2).
task(14,1).
task(14,2).
task(15,1).
task(15,2).
task(16,2).
task(17,1).
task(17,2).
task(18,1).
task(18,2).
task(2,1).
task(2,2).
task(21,1).
task(21,2).
task(22,1).
task(22,2).
task(23,2).
task(24,1).
task(24,2).
task(25,1).
task(26,1).
task(29,1).
task(3,1).
task(30,1).
task(32,1).
task(5,1).
task(5,2).
task(6,1).
task(6,2).
task(9,1).
task(9,2).
comm(task(1,1),task(3,1),1).
comm(task(1,2),task(13,2),2).
comm(task(10,1),task(26,1),1).
comm(task(10,2),task(6,2),2).
comm(task(13,1),task(15,1),1).
comm(task(13,2),task(15,2),2).
comm(task(13,2),task(16,2),2).
comm(task(14,1),task(6,1),1).
comm(task(14,2),task(2,2),2).
comm(task(15,1),task(14,1),1).
comm(task(15,2),task(14,2),2).
comm(task(16,2),task(14,2),2).
comm(task(17,1),task(29,1),1).
comm(task(17,2),task(1,2),2).
comm(task(17,2),task(5,2),2).
comm(task(18,1),task(26,1),1).
comm(task(2,1),task(30,1),1).
comm(task(2,2),task(18,2),2).
comm(task(21,1),task(24,1),1).
comm(task(21,1),task(25,1),1).
comm(task(21,2),task(23,2),2).
comm(task(21,2),task(24,2),2).
comm(task(22,2),task(10,2),2).
comm(task(23,2),task(22,2),2).
comm(task(24,1),task(22,1),1).
comm(task(24,2),task(22,2),2).
comm(task(25,1),task(17,1),1).
comm(task(25,1),task(9,1),1).
comm(task(26,1),task(22,1),1).
comm(task(29,1),task(1,1),1).
comm(task(29,1),task(32,1),1).
comm(task(3,1),task(2,1),1).
comm(task(30,1),task(18,1),1).
comm(task(32,1),task(30,1),1).
comm(task(5,1),task(13,1),1).
comm(task(5,2),task(9,2),2).
comm(task(6,1),task(10,1),1).
comm(task(6,2),task(18,2),2).
comm(task(9,1),task(5,1),1).
comm(task(9,2),task(21,2),2).
send(task(29,1),comm(task(29,1),task(1,1),1)).
send(task(9,1),comm(task(9,1),task(5,1),1)).
send(task(25,1),comm(task(25,1),task(9,1),1)).
send(task(5,1),comm(task(5,1),task(13,1),1)).
send(task(25,1),comm(task(25,1),task(17,1),1)).
send(task(17,2),comm(task(17,2),task(1,2),2)).
send(task(17,2),comm(task(17,2),task(5,2),2)).
send(task(5,2),comm(task(5,2),task(9,2),2)).
send(task(21,1),comm(task(21,1),task(25,1),1)).
send(task(17,1),comm(task(17,1),task(29,1),1)).
send(task(1,2),comm(task(1,2),task(13,2),2)).
send(task(9,2),comm(task(9,2),task(21,2),2)).
send(task(2,1),comm(task(2,1),task(30,1),1)).
send(task(6,1),comm(task(6,1),task(10,1),1)).
send(task(10,1),comm(task(10,1),task(26,1),1)).
send(task(14,1),comm(task(14,1),task(6,1),1)).
send(task(18,1),comm(task(18,1),task(26,1),1)).
send(task(2,2),comm(task(2,2),task(18,2),2)).
send(task(6,2),comm(task(6,2),task(18,2),2)).
send(task(10,2),comm(task(10,2),task(6,2),2)).
send(task(26,1),comm(task(26,1),task(22,1),1)).
send(task(30,1),comm(task(30,1),task(18,1),1)).
send(task(14,2),comm(task(14,2),task(2,2),2)).
send(task(22,2),comm(task(22,2),task(10,2),2)).
send(task(21,1),comm(task(21,1),task(24,1),1)).
send(task(29,1),comm(task(29,1),task(32,1),1)).
send(task(13,2),comm(task(13,2),task(15,2),2)).
send(task(13,2),comm(task(13,2),task(16,2),2)).
send(task(21,2),comm(task(21,2),task(23,2),2)).
send(task(21,2),comm(task(21,2),task(24,2),2)).
send(task(1,1),comm(task(1,1),task(3,1),1)).
send(task(13,1),comm(task(13,1),task(15,1),1)).
send(task(24,1),comm(task(24,1),task(22,1),1)).
send(task(32,1),comm(task(32,1),task(30,1),1)).
send(task(15,2),comm(task(15,2),task(14,2),2)).
send(task(16,2),comm(task(16,2),task(14,2),2)).
send(task(23,2),comm(task(23,2),task(22,2),2)).
send(task(24,2),comm(task(24,2),task(22,2),2)).
send(task(3,1),comm(task(3,1),task(2,1),1)).
send(task(15,1),comm(task(15,1),task(14,1),1)).
read(task(1,1),comm(task(29,1),task(1,1),1)).
read(task(5,1),comm(task(9,1),task(5,1),1)).
read(task(9,1),comm(task(25,1),task(9,1),1)).
read(task(13,1),comm(task(5,1),task(13,1),1)).
read(task(17,1),comm(task(25,1),task(17,1),1)).
read(task(1,2),comm(task(17,2),task(1,2),2)).
read(task(5,2),comm(task(17,2),task(5,2),2)).
read(task(9,2),comm(task(5,2),task(9,2),2)).
read(task(25,1),comm(task(21,1),task(25,1),1)).
read(task(29,1),comm(task(17,1),task(29,1),1)).
read(task(13,2),comm(task(1,2),task(13,2),2)).
read(task(21,2),comm(task(9,2),task(21,2),2)).
read(task(30,1),comm(task(2,1),task(30,1),1)).
read(task(10,1),comm(task(6,1),task(10,1),1)).
read(task(26,1),comm(task(10,1),task(26,1),1)).
read(task(6,1),comm(task(14,1),task(6,1),1)).
read(task(26,1),comm(task(18,1),task(26,1),1)).
read(task(18,2),comm(task(2,2),task(18,2),2)).
read(task(18,2),comm(task(6,2),task(18,2),2)).
read(task(6,2),comm(task(10,2),task(6,2),2)).
read(task(22,1),comm(task(26,1),task(22,1),1)).
read(task(18,1),comm(task(30,1),task(18,1),1)).
read(task(2,2),comm(task(14,2),task(2,2),2)).
read(task(10,2),comm(task(22,2),task(10,2),2)).
read(task(24,1),comm(task(21,1),task(24,1),1)).
read(task(32,1),comm(task(29,1),task(32,1),1)).
read(task(15,2),comm(task(13,2),task(15,2),2)).
read(task(16,2),comm(task(13,2),task(16,2),2)).
read(task(23,2),comm(task(21,2),task(23,2),2)).
read(task(24,2),comm(task(21,2),task(24,2),2)).
read(task(3,1),comm(task(1,1),task(3,1),1)).
read(task(15,1),comm(task(13,1),task(15,1),1)).
read(task(22,1),comm(task(24,1),task(22,1),1)).
read(task(30,1),comm(task(32,1),task(30,1),1)).
read(task(14,2),comm(task(15,2),task(14,2),2)).
read(task(14,2),comm(task(16,2),task(14,2),2)).
read(task(22,2),comm(task(23,2),task(22,2),2)).
read(task(22,2),comm(task(24,2),task(22,2),2)).
read(task(2,1),comm(task(3,1),task(2,1),1)).
read(task(14,1),comm(task(15,1),task(14,1),1)).
router(1,1,1,1).
resourceCost(router(1),26).
staticPower(router(1),28).
router(10,2,3,1).
resourceCost(router(10),25).
staticPower(router(10),29).
router(11,3,3,1).
resourceCost(router(11),23).
staticPower(router(11),29).
router(12,4,3,1).
resourceCost(router(12),20).
staticPower(router(12),29).
router(13,1,4,1).
resourceCost(router(13),26).
staticPower(router(13),50).
router(14,2,4,1).
resourceCost(router(14),50).
staticPower(router(14),49).
router(15,3,4,1).
resourceCost(router(15),37).
staticPower(router(15),22).
router(16,4,4,1).
resourceCost(router(16),25).
staticPower(router(16),20).
router(2,2,1,1).
resourceCost(router(2),42).
staticPower(router(2),24).
router(3,3,1,1).
resourceCost(router(3),39).
staticPower(router(3),50).
router(4,4,1,1).
resourceCost(router(4),45).
staticPower(router(4),44).
router(5,1,2,1).
resourceCost(router(5),40).
staticPower(router(5),32).
router(6,2,2,1).
resourceCost(router(6),20).
staticPower(router(6),40).
router(7,3,2,1).
resourceCost(router(7),41).
staticPower(router(7),47).
router(8,4,2,1).
resourceCost(router(8),49).
staticPower(router(8),27).
router(9,1,3,1).
resourceCost(router(9),41).
staticPower(router(9),28).
processor(1,1,1,1).
resourceCost(processor(1),40).
staticPower(processor(1),44).
processor(10,2,3,1).
resourceCost(processor(10),50).
staticPower(processor(10),38).
processor(11,3,3,1).
resourceCost(processor(11),37).
staticPower(processor(11),27).
processor(12,4,3,1).
resourceCost(processor(12),23).
staticPower(processor(12),31).
processor(13,1,4,1).
resourceCost(processor(13),21).
staticPower(processor(13),45).
processor(14,2,4,1).
resourceCost(processor(14),38).
staticPower(processor(14),34).
processor(15,3,4,1).
resourceCost(processor(15),48).
staticPower(processor(15),38).
processor(16,4,4,1).
resourceCost(processor(16),44).
staticPower(processor(16),33).
processor(2,2,1,1).
resourceCost(processor(2),49).
staticPower(processor(2),33).
processor(3,3,1,1).
resourceCost(processor(3),49).
staticPower(processor(3),27).
processor(4,4,1,1).
resourceCost(processor(4),30).
staticPower(processor(4),34).
processor(5,1,2,1).
resourceCost(processor(5),48).
staticPower(processor(5),23).
processor(6,2,2,1).
resourceCost(processor(6),48).
staticPower(processor(6),36).
processor(7,3,2,1).
resourceCost(processor(7),26).
staticPower(processor(7),23).
processor(8,4,2,1).
resourceCost(processor(8),47).
staticPower(processor(8),33).
processor(9,1,3,1).
resourceCost(processor(9),46).
staticPower(processor(9),31).
link(router(1),processor(1)).
link(router(2),processor(2)).
link(router(3),processor(3)).
link(router(4),processor(4)).
link(router(5),processor(5)).
link(router(6),processor(6)).
link(router(7),processor(7)).
link(router(8),processor(8)).
link(router(9),processor(9)).
link(router(10),processor(10)).
link(router(11),processor(11)).
link(router(12),processor(12)).
link(router(13),processor(13)).
link(router(14),processor(14)).
link(router(15),processor(15)).
link(router(16),processor(16)).
link(router(1),router(2)).
link(router(2),router(3)).
link(router(3),router(4)).
link(router(5),router(6)).
link(router(6),router(7)).
link(router(7),router(8)).
link(router(9),router(10)).
link(router(10),router(11)).
link(router(11),router(12)).
link(router(13),router(14)).
link(router(14),router(15)).
link(router(15),router(16)).
link(router(1),router(5)).
link(router(2),router(6)).
link(router(3),router(7)).
link(router(4),router(8)).
link(router(5),router(9)).
link(router(6),router(10)).
link(router(7),router(11)).
link(router(8),router(12)).
link(router(9),router(13)).
link(router(10),router(14)).
link(router(11),router(15)).
link(router(12),router(16)).
link(router(16),router(12)).
link(router(15),router(11)).
link(router(14),router(10)).
link(router(13),router(9)).
link(router(12),router(8)).
link(router(11),router(7)).
link(router(10),router(6)).
link(router(9),router(5)).
link(router(8),router(4)).
link(router(7),router(3)).
link(router(6),router(2)).
link(router(5),router(1)).
link(router(16),router(15)).
link(router(15),router(14)).
link(router(14),router(13)).
link(router(12),router(11)).
link(router(11),router(10)).
link(router(10),router(9)).
link(router(8),router(7)).
link(router(7),router(6)).
link(router(6),router(5)).
link(router(4),router(3)).
link(router(3),router(2)).
link(router(2),router(1)).
link(processor(16),router(16)).
link(processor(15),router(15)).
link(processor(14),router(14)).
link(processor(13),router(13)).
link(processor(12),router(12)).
link(processor(11),router(11)).
link(processor(10),router(10)).
link(processor(9),router(9)).
link(processor(8),router(8)).
link(processor(7),router(7)).
link(processor(6),router(6)).
link(processor(5),router(5)).
link(processor(4),router(4)).
link(processor(3),router(3)).
link(processor(2),router(2)).
link(processor(1),router(1)).
map(m21x1x12,task(21,1),processor(12)).
executionTime(m21x1x12,278).
dynamicEnergy(m21x1x12,1476).
map(m16x2x11,task(16,2),processor(11)).
executionTime(m16x2x11,245).
dynamicEnergy(m16x2x11,490).
map(m15x1x5,task(15,1),processor(5)).
executionTime(m15x1x5,376).
dynamicEnergy(m15x1x5,1504).
map(m2x1x15,task(2,1),processor(15)).
executionTime(m2x1x15,351).
dynamicEnergy(m2x1x15,1170).
map(m17x2x2,task(17,2),processor(2)).
executionTime(m17x2x2,338).
dynamicEnergy(m17x2x2,1613).
map(m17x1x14,task(17,1),processor(14)).
executionTime(m17x1x14,93).
dynamicEnergy(m17x1x14,632).
map(m10x1x6,task(10,1),processor(6)).
executionTime(m10x1x6,263).
dynamicEnergy(m10x1x6,1309).
map(m16x2x13,task(16,2),processor(13)).
executionTime(m16x2x13,81).
dynamicEnergy(m16x2x13,735).
map(m1x1x8,task(1,1),processor(8)).
executionTime(m1x1x8,165).
dynamicEnergy(m1x1x8,1149).
map(m13x1x11,task(13,1),processor(11)).
executionTime(m13x1x11,110).
dynamicEnergy(m13x1x11,220).
map(m5x2x12,task(5,2),processor(12)).
executionTime(m5x2x12,411).
dynamicEnergy(m5x2x12,1909).
map(m32x1x15,task(32,1),processor(15)).
executionTime(m32x1x15,243).
dynamicEnergy(m32x1x15,1388).
map(m22x2x14,task(22,2),processor(14)).
executionTime(m22x2x14,160).
dynamicEnergy(m22x2x14,1528).
map(m3x1x12,task(3,1),processor(12)).
executionTime(m3x1x12,394).
dynamicEnergy(m3x1x12,1356).
map(m29x1x6,task(29,1),processor(6)).
executionTime(m29x1x6,273).
dynamicEnergy(m29x1x6,1369).
map(m23x2x2,task(23,2),processor(2)).
executionTime(m23x2x2,111).
dynamicEnergy(m23x2x2,892).
map(m13x2x7,task(13,2),processor(7)).
executionTime(m13x2x7,358).
dynamicEnergy(m13x2x7,2802).
map(m23x2x8,task(23,2),processor(8)).
executionTime(m23x2x8,55).
dynamicEnergy(m23x2x8,669).
map(m2x2x6,task(2,2),processor(6)).
executionTime(m2x2x6,229).
dynamicEnergy(m2x2x6,916).
map(m22x1x11,task(22,1),processor(11)).
executionTime(m22x1x11,254).
dynamicEnergy(m22x1x11,838).
map(m3x1x6,task(3,1),processor(6)).
executionTime(m3x1x6,307).
dynamicEnergy(m3x1x6,1402).
map(m22x1x13,task(22,1),processor(13)).
executionTime(m22x1x13,95).
dynamicEnergy(m22x1x13,1067).
map(m24x2x6,task(24,2),processor(6)).
executionTime(m24x2x6,284).
dynamicEnergy(m24x2x6,1266).
map(m30x1x14,task(30,1),processor(14)).
executionTime(m30x1x14,115).
dynamicEnergy(m30x1x14,1216).
map(m1x2x8,task(1,2),processor(8)).
executionTime(m1x2x8,173).
dynamicEnergy(m1x2x8,1033).
map(m24x1x6,task(24,1),processor(6)).
executionTime(m24x1x6,96).
dynamicEnergy(m24x1x6,579).
map(m1x2x6,task(1,2),processor(6)).
executionTime(m1x2x6,170).
dynamicEnergy(m1x2x6,831).
map(m26x1x10,task(26,1),processor(10)).
executionTime(m26x1x10,146).
dynamicEnergy(m26x1x10,701).
map(m22x1x5,task(22,1),processor(5)).
executionTime(m22x1x5,305).
dynamicEnergy(m22x1x5,1220).
map(m30x1x15,task(30,1),processor(15)).
executionTime(m30x1x15,304).
dynamicEnergy(m30x1x15,1007).
map(m25x1x12,task(25,1),processor(12)).
executionTime(m25x1x12,429).
dynamicEnergy(m25x1x12,1997).
map(m1x2x12,task(1,2),processor(12)).
executionTime(m1x2x12,245).
dynamicEnergy(m1x2x12,884).
map(m14x1x13,task(14,1),processor(13)).
executionTime(m14x1x13,141).
dynamicEnergy(m14x1x13,1951).
map(m9x1x7,task(9,1),processor(7)).
executionTime(m9x1x7,280).
dynamicEnergy(m9x1x7,1734).
map(m15x1x13,task(15,1),processor(13)).
executionTime(m15x1x13,106).
dynamicEnergy(m15x1x13,1592).
map(m18x1x14,task(18,1),processor(14)).
executionTime(m18x1x14,104).
dynamicEnergy(m18x1x14,1190).
map(m17x1x5,task(17,1),processor(5)).
executionTime(m17x1x5,316).
dynamicEnergy(m17x1x5,1264).
map(m14x2x14,task(14,2),processor(14)).
executionTime(m14x2x14,141).
dynamicEnergy(m14x2x14,1482).
map(m13x1x8,task(13,1),processor(8)).
executionTime(m13x1x8,110).
dynamicEnergy(m13x1x8,550).
map(m14x1x14,task(14,1),processor(14)).
executionTime(m14x1x14,141).
dynamicEnergy(m14x1x14,974).
map(m2x2x8,task(2,2),processor(8)).
executionTime(m2x2x8,57).
dynamicEnergy(m2x2x8,687).
map(m13x2x10,task(13,2),processor(10)).
executionTime(m13x2x10,393).
dynamicEnergy(m13x2x10,1966).
map(m24x2x8,task(24,2),processor(8)).
executionTime(m24x2x8,184).
dynamicEnergy(m24x2x8,1307).
map(m30x1x3,task(30,1),processor(3)).
executionTime(m30x1x3,167).
dynamicEnergy(m30x1x3,988).
map(m6x2x12,task(6,2),processor(12)).
executionTime(m6x2x12,382).
dynamicEnergy(m6x2x12,1840).
map(m15x2x4,task(15,2),processor(4)).
executionTime(m15x2x4,96).
dynamicEnergy(m15x2x4,502).
map(m15x2x1,task(15,2),processor(1)).
executionTime(m15x2x1,102).
dynamicEnergy(m15x2x1,639).
map(m13x2x9,task(13,2),processor(9)).
executionTime(m13x2x9,358).
dynamicEnergy(m13x2x9,2006).
map(m16x2x15,task(16,2),processor(15)).
executionTime(m16x2x15,122).
dynamicEnergy(m16x2x15,1225).
map(m10x2x9,task(10,2),processor(9)).
executionTime(m10x2x9,393).
dynamicEnergy(m10x2x9,2010).
map(m5x2x6,task(5,2),processor(6)).
executionTime(m5x2x6,268).
dynamicEnergy(m5x2x6,1418).
map(m2x1x14,task(2,1),processor(14)).
executionTime(m2x1x14,136).
dynamicEnergy(m2x1x14,1406).
map(m18x2x15,task(18,2),processor(15)).
executionTime(m18x2x15,357).
dynamicEnergy(m18x2x15,1820).
map(m16x2x8,task(16,2),processor(8)).
executionTime(m16x2x8,245).
dynamicEnergy(m16x2x8,1225).
map(m10x2x1,task(10,2),processor(1)).
executionTime(m10x2x1,240).
dynamicEnergy(m10x2x1,1573).
map(m1x1x6,task(1,1),processor(6)).
executionTime(m1x1x6,243).
dynamicEnergy(m1x1x6,1092).
map(m26x1x8,task(26,1),processor(8)).
executionTime(m26x1x8,87).
dynamicEnergy(m26x1x8,641).
map(m18x2x14,task(18,2),processor(14)).
executionTime(m18x2x14,139).
dynamicEnergy(m18x2x14,1430).
map(m10x2x7,task(10,2),processor(7)).
executionTime(m10x2x7,393).
dynamicEnergy(m10x2x7,2822).
map(m2x1x3,task(2,1),processor(3)).
executionTime(m2x1x3,195).
dynamicEnergy(m2x1x3,1165).
map(m14x1x15,task(14,1),processor(15)).
executionTime(m14x1x15,243).
dynamicEnergy(m14x1x15,1700).
map(m14x1x11,task(14,1),processor(11)).
executionTime(m14x1x11,323).
dynamicEnergy(m14x1x11,1709).
map(m15x1x15,task(15,1),processor(15)).
executionTime(m15x1x15,188).
dynamicEnergy(m15x1x15,1184).
map(m2x2x2,task(2,2),processor(2)).
executionTime(m2x2x2,114).
dynamicEnergy(m2x2x2,916).
map(m18x1x6,task(18,1),processor(6)).
executionTime(m18x1x6,180).
dynamicEnergy(m18x1x6,1085).
map(m17x1x15,task(17,1),processor(15)).
executionTime(m17x1x15,158).
dynamicEnergy(m17x1x15,1034).
map(m18x1x15,task(18,1),processor(15)).
executionTime(m18x1x15,297).
dynamicEnergy(m18x1x15,1750).
map(m15x1x11,task(15,1),processor(11)).
executionTime(m15x1x11,221).
dynamicEnergy(m15x1x11,1448).
map(m17x2x10,task(17,2),processor(10)).
executionTime(m17x2x10,348).
dynamicEnergy(m17x2x10,1852).
map(m6x1x12,task(6,1),processor(12)).
executionTime(m6x1x12,576).
dynamicEnergy(m6x1x12,2447).
map(m5x1x10,task(5,1),processor(10)).
executionTime(m5x1x10,393).
dynamicEnergy(m5x1x10,1973).
map(m14x2x15,task(14,2),processor(15)).
executionTime(m14x2x15,370).
dynamicEnergy(m14x2x15,1897).
map(m9x1x9,task(9,1),processor(9)).
executionTime(m9x1x9,280).
dynamicEnergy(m9x1x9,1394).
map(m17x2x7,task(17,2),processor(7)).
executionTime(m17x2x7,348).
dynamicEnergy(m17x2x7,2071).
map(m15x2x8,task(15,2),processor(8)).
executionTime(m15x2x8,165).
dynamicEnergy(m15x2x8,1027).
map(m21x1x14,task(21,1),processor(14)).
executionTime(m21x1x14,92).
dynamicEnergy(m21x1x14,1100).
map(m1x1x12,task(1,1),processor(12)).
executionTime(m1x1x12,303).
dynamicEnergy(m1x1x12,1029).
map(m15x2x7,task(15,2),processor(7)).
executionTime(m15x2x7,159).
dynamicEnergy(m15x2x7,1255).
map(m5x1x9,task(5,1),processor(9)).
executionTime(m5x1x9,357).
dynamicEnergy(m5x1x9,2056).
map(m9x2x10,task(9,2),processor(10)).
executionTime(m9x2x10,384).
dynamicEnergy(m9x2x10,1921).
map(m23x2x6,task(23,2),processor(6)).
executionTime(m23x2x6,223).
dynamicEnergy(m23x2x6,892).
map(m24x1x5,task(24,1),processor(5)).
executionTime(m24x1x5,193).
dynamicEnergy(m24x1x5,772).
map(m9x1x10,task(9,1),processor(10)).
executionTime(m9x1x10,280).
dynamicEnergy(m9x1x10,1513).
map(m6x2x6,task(6,2),processor(6)).
executionTime(m6x2x6,254).
dynamicEnergy(m6x2x6,1340).
map(m25x1x6,task(25,1),processor(6)).
executionTime(m25x1x6,327).
dynamicEnergy(m25x1x6,1592).
map(m26x1x7,task(26,1),processor(7)).
executionTime(m26x1x7,136).
dynamicEnergy(m26x1x7,875).
map(m10x1x12,task(10,1),processor(12)).
executionTime(m10x1x12,358).
dynamicEnergy(m10x1x12,1682).
map(m24x2x12,task(24,2),processor(12)).
executionTime(m24x2x12,349).
dynamicEnergy(m24x2x12,1177).
map(m29x1x12,task(29,1),processor(12)).
executionTime(m29x1x12,390).
dynamicEnergy(m29x1x12,1666).
map(m5x1x1,task(5,1),processor(1)).
executionTime(m5x1x1,232).
dynamicEnergy(m5x1x1,1657).
map(m13x2x1,task(13,2),processor(1)).
executionTime(m13x2x1,230).
dynamicEnergy(m13x2x1,1616).
map(m24x1x8,task(24,1),processor(8)).
executionTime(m24x1x8,193).
dynamicEnergy(m24x1x8,965).
map(m21x1x15,task(21,1),processor(15)).
executionTime(m21x1x15,275).
dynamicEnergy(m21x1x15,1483).
map(m22x2x15,task(22,2),processor(15)).
executionTime(m22x2x15,381).
dynamicEnergy(m22x2x15,1942).
map(m21x2x14,task(21,2),processor(14)).
executionTime(m21x2x14,150).
dynamicEnergy(m21x2x14,1578).
map(m9x1x2,task(9,1),processor(2)).
executionTime(m9x1x2,306).
dynamicEnergy(m9x1x2,1343).
map(m6x1x6,task(6,1),processor(6)).
executionTime(m6x1x6,419).
dynamicEnergy(m6x1x6,2055).
map(m21x2x15,task(21,2),processor(15)).
executionTime(m21x2x15,394).
dynamicEnergy(m21x2x15,1817).
map(m9x2x1,task(9,2),processor(1)).
executionTime(m9x2x1,230).
dynamicEnergy(m9x2x1,1694).
map(m26x1x1,task(26,1),processor(1)).
executionTime(m26x1x1,77).
dynamicEnergy(m26x1x1,408).
map(m22x1x15,task(22,1),processor(15)).
executionTime(m22x1x15,152).
dynamicEnergy(m22x1x15,1297).
map(m10x2x10,task(10,2),processor(10)).
executionTime(m10x2x10,421).
dynamicEnergy(m10x2x10,2123).
map(m24x1x13,task(24,1),processor(13)).
executionTime(m24x1x13,64).
dynamicEnergy(m24x1x13,579).
map(m17x2x9,task(17,2),processor(9)).
executionTime(m17x2x9,348).
dynamicEnergy(m17x2x9,1593).
map(m18x1x12,task(18,1),processor(12)).
executionTime(m18x1x12,332).
dynamicEnergy(m18x1x12,1680).
map(m32x1x14,task(32,1),processor(14)).
executionTime(m32x1x14,100).
dynamicEnergy(m32x1x14,974).
routingDelay(20).
routingEnergy(47).
period(5796).
