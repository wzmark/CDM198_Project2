pico-8 cartridge // http://www.pico-8.com
version 29
__lua__


function _init()
	gameLevel = 0
	busInit()
	passangerInit()
end

function _draw()
	cls()
	
	if(gameLevel <= 3) then
		mapDraw()
		if(bus.xposition > 30) then
			map(115, 28, 14 + bus.xposition-30, 66, 18, 4)
		else
			map(115, 28, 14, 66, 18, 4)
		end
		passangerDraw()
		busDraw()
		
		print(bus.xposition, bus.xposition, 0, 7)

	else
		print("End of Game", 30, 30)
	end
	
	
end

function mapDraw()
	if(gameLevel == 0) then
		map(0, 0, 0, 0, 127, 8)
	elseif(gameLevel == 1) then
		map(0, 8, 0, 0, 127, 8)
	elseif(gameLevel == 2) then
		map(0, 16, 0, 0, 127, 8)
	elseif(gameLevel == 3) then
		map(0, 24, 0, 0, 98, 8)
	

	end

end

function _update()
	busMove()
	pickUp()
	flag = 0
	if(btnp(5)) then
		flag = 1
	end
	if(flag == 1) then
		dropOff()
		flag = 0
	end

	if(bus.xposition > 30) then
		camera(0 + bus.xposition-30, 0)
	else
		camera(0, 0)
	end
	
end




-->8
function busInit()
	bus = {}
	bus.sprite1 = 32
	bus.sprite2 = 36
	bus.xposition = -20
	bus.yposition = 29
	bus.height = 2
	bus.width = 4
	bus.move = 0
	bus.pickList = {}
end

function busMove()
	
	if (btn(0)) then
		if (bus.xposition-1 > 0) then
			bus.xposition = bus.xposition - 10
			bus.move = 1
		end
	elseif (btn(1)) then
		if (bus.xposition + 1 < 987) then
			bus.xposition = bus.xposition + 10
			bus.move = 1
			
		end
	end
	if(gameLevel<3) then
		if(bus.xposition > 984) then 
			gameLevel = gameLevel + 1
			bus.xposition = -20
		end
	else
		if(bus.xposition > 750) then 
			gameLevel = gameLevel + 1
			bus.xposition = -20
		end
	end
	
	
end

function pickUp()
	if (btn(2)) then
		if((bus.xposition < passanger.xposition1) and (passanger.xposition1 < bus.xposition + 20)) then
			passanger.pickCheck1 = 1
			bus.pickList[#bus.pickList+1] = 1
		elseif((bus.xposition < passanger.xposition2) and (passanger.xposition2 < bus.xposition + 20)) then
			passanger.pickCheck2 = 1
			bus.pickList[#bus.pickList+1] = 2
		elseif((bus.xposition < passanger.xposition3) and (passanger.xposition3 < bus.xposition + 20)) then
			passanger.pickCheck3 = 1
			bus.pickList[#bus.pickList+1] = 3
		elseif((bus.xposition < passanger.xposition4) and (passanger.xposition4 < bus.xposition + 20)) then
			passanger.pickCheck4 = 1
			bus.pickList[#bus.pickList+1] = 4
		elseif((bus.xposition < passanger.xposition5) and (passanger.xposition5 < bus.xposition + 20)) then
			passanger.pickCheck5 = 1
			bus.pickList[#bus.pickList+1] = 5
		elseif((bus.xposition < passanger.xposition6) and (passanger.xposition6 < bus.xposition + 20)) then
			passanger.pickCheck6 = 1
			bus.pickList[#bus.pickList+1] = 6
		elseif((bus.xposition < passanger.xposition7) and (passanger.xposition7 < bus.xposition + 20)) then
			passanger.pickCheck7 = 1
			bus.pickList[#bus.pickList+1] = 7
		end
	end

end

function dropOff()
	select = 1
	selectFlag = 0
	
	

	while(selectFlag == 0) do
		select = rnd(7) + 1
		if(select == 1) then
		if(passanger.pickCheck1 == 1) then
		selectFlag = 1
		passanger.pickCheck1 = 0
		passanger.xposition1 = bus.xposition
		
		end
	elseif (select == 2) then
		if(passanger.pickCheck2 == 1) then
		selectFlag = 1
		passanger.pickCheck2 = 0
		passanger.xposition2 = bus.xposition
		end
	elseif (select == 3) then
		if(passanger.pickCheck3 == 1) then
		selectFlag = 1
		passanger.pickCheck3 = 0
		passanger.xposition3 = bus.xposition
		end
	elseif (select == 4) then
		if(passanger.pickCheck4 == 1) then
		selectFlag = 1
		passanger.pickCheck4 = 0
		passanger.xposition4 = bus.xposition
		end
	elseif (select == 5) then
		if(passanger.pickCheck5 == 1) then
		selectFlag = 1
		passanger.pickCheck5 = 0
		passanger.xposition5 = bus.xposition
		end
	elseif (select == 6) then
		if(passanger.pickCheck6 == 1) then
		selectFlag = 1
		passanger.pickCheck6 = 0
		passanger.xposition6 = bus.xposition
		end
	elseif (select == 7) then
		if(passanger.pickCheck7 == 1) then
		selectFlag = 1
		passanger.pickCheck7 = 0
		passanger.xposition7 = bus.xposition
		end
	end

	end
	
	

end

function busDraw()
	if(bus.move == 1) then
		spr(bus.sprite2, bus.xposition, bus.yposition, bus.width, bus.height)
		bus.move = 0
	elseif(bus.move == 0) then
		spr(bus.sprite1, bus.xposition, bus.yposition, bus.width, bus.height)
	end
	
	

end
-->8

function passangerInit()
	passanger = {}
	passanger.sprite1 = 5
	passanger.sprite2 = 6 
	passanger.sprite3 = 7
	passanger.sprite4 = 9
	passanger.sprite5 = 10
	passanger.sprite6 = 10
	passanger.sprite7 = 10
	passanger.xposition1 = 68 + rnd(60)
	passanger.xposition2 = passanger.xposition1 + rnd(60) + 10
	passanger.xposition3 = passanger.xposition2 + rnd(60) + 10
	passanger.xposition4 = passanger.xposition3 + rnd(60) + 10
	passanger.xposition5 = passanger.xposition4 + rnd(60) + 10
	passanger.xposition6 = passanger.xposition5 + rnd(60) + 10
	passanger.xposition7 = passanger.xposition6 + rnd(60) + 10
	passanger.yposition = 32
	passanger.pickCheck1 = 0
	passanger.pickCheck2 = 0
	passanger.pickCheck3 = 0
	passanger.pickCheck4 = 0
	passanger.pickCheck5 = 0
	passanger.pickCheck6 = 0
	passanger.pickCheck7 = 0
	passanger.pickSprite1 = 21
	passanger.pickSprite2 = 22
	passanger.pickSprite3 = 23
	passanger.pickSprite4 = 24
	passanger.pickSprite5 = 25
	passanger.pickSprite6 = 26
	passanger.pickSprite7 = 27
end



function passangerDraw()

	if(passanger.pickCheck1 == 0) then
		spr(passanger.sprite1, passanger.xposition1, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite1, 28 + bus.xposition-30, 80)
		else
			spr(passanger.pickSprite1, 28, 80)
			
		end

		
	end
	if(passanger.pickCheck2 == 0) then
		spr(passanger.sprite2, passanger.xposition2, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite2, 38 + bus.xposition-30, 80)
		else
			spr(passanger.pickSprite2, 38, 80)
			
		end
	end
	if(passanger.pickCheck3 == 0) then
		spr(passanger.sprite3, passanger.xposition3, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite3, 48 + bus.xposition-30, 80)
		else
			spr(passanger.pickSprite3, 48, 80)
			
		end
	end
	if(passanger.pickCheck4 == 0) then
		spr(passanger.sprite4, passanger.xposition4, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite4, 58 + bus.xposition-30, 80)
		else
			spr(passanger.pickSprite4, 58, 80)
			
		end
	end
	if(passanger.pickCheck5 == 0) then
		spr(passanger.sprite5, passanger.xposition5, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite5, 68 + bus.xposition-30, 80)
		else
			spr(passanger.pickSprite5, 68, 80)
			
		end
	end
	if(passanger.pickCheck6 == 0) then
		spr(passanger.sprite6, passanger.xposition6, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite6, 78 + bus.xposition-30, 80)
		else
			spr(passanger.pickSprite6, 78, 70)
			
		end
	end
	if(passanger.pickCheck7 == 0) then
		spr(passanger.sprite7, passanger.xposition7, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite7, 88 + bus.xposition-30, 80)
		else
			spr(passanger.pickSprite7, 88, 80)
			
		end
	end

end
__gfx__
0000000044444444cccccccc66666666ccaaaacc000000000000000000aaaaa000000000000000000000000000000000cccc22cccc9999cccceeeeccc555555c
0000000044444444cccccccc66666156caaaaaac000099000000000000a1aa10000000000eee00000000000000101000cc22222ccc9889ccc8888eecc588885c
0070070044444444cccccccc66666556aa000aaa000999900022220002aaaaa0000000000e5e00000099000003333300c220202ccc9889cc888888eec577775c
0007700044444444ccccccccaa6aaa6aaa0aa0aa0097997000d22d0002aaaaa0000606000eee00000097000003333330c222222ccc9559cc8888888ec577775c
0007700044444444ccccccccaa615a6aaa000aaa0f9999900222222002aaaaa0000000000eee50005599000000333330ceeeeeeccc9559cc8888888ec588885c
0070070044444444cccccccc66655666aa0a00aa0f9999900222222000aaaaa00b0000000eee055005559000000b0b00c4eeee4ccc9559cc8888888ec5a88a5c
0000000044444444cccccccc66666666caaaaaac0f0f0f000f2222f0000200200b0000000404055005669000000b0b00c4eeee4ccc9559ccc888888cc505505c
0000000044444444cccccccc66666666ccaaaacc000f0f00000fcf0000020020000b00000404005005665000000b0b00cc4c4ccccc9999cccc8888ccc555555c
66666666ffffffffcccccccc5555555566667766000000000000000000000000000000000eee00000000000000000000cccccccccc9999cccc9999ccccc55ccc
6666666644444444cccccccc555555556666776600990000000000000aaa0000000000000ee50000000000000b0b0000cccccccccc9559cccc9559ccccc55ccc
6666666644444444cccccccc555555556666776609999000002020000aa00000000000000eee00000009900000b0b000cccccccccc9559cccc9559ccccc55ccc
aa6aaa6a44444444ccc3333c95999599aa66776a979970f00020d00002aa0000006060b00eee00000009700000b0b000cccccccccc9aa9cccc9559ccccc55ccc
aa6aaa6a44444444cc33b38395999599aa66776af9999f000020200002aa000000000b00500400000559900003333300cccccccccc9aa9cccc9559ccccc55ccc
66666666444444443bb333b35555555566667766f9999f0000f0220002aa00000b000000055400000055590003333330f444f444cc9559cccc9bb9ccccc55ccc
6666666644444444b833b8335555555566667766ff0f0000000022f0000200000b0b0000055000000056690000333330ffffffffcc9559cccc9bb9ccccc55ccc
6666666644444444bb3333b355555555666677660f0f000000000f0000020000000b000000500000005665000001010044f44f44cc9999cccc9999ccccc55ccc
00000077777777777777777770000000000000000000000000000000000000000009900007777770cccccccccccccccc11111111111111111111111111111111
00000777777777777777777777700000000000077777777777777777700000000099990007070070cceccccccccccccc11111115555555555555555551111111
00000777777777777777777777700000000007777777777777777777777000000999999007707070ceaecc8ccccccccc11111555555555555555555555511111
88888888888888888888888888888800000007777777777777777777777000009900909907777770ccecc8a8cccccccc11111555555555555555555555511111
888888888888888888888888888888008888888888888888888888888888880099090909070700703c3ccc8ccccccccc800000000000000a0000000000000a11
88888888888888888888888888887700888888888888888888888888888888000999999007070070c33c33ccf466cccc00000000000000000000000000000011
8877788777887778877788555a587700888888888888888888888888888877000099990007070070bc3cc3bcfffff66c00000000000000000000000000007711
88777887778877788777885aa55877008877788777887778877788555a58770000099000077777703b33b33344f44f4400777007770077700777000000007711
8877788777887778877788777778770088777887778877788777885aa55877000000000000000000000000000000000000777007770077700777000a0a007711
88777887778877788777887777787700887778877788777887778877777877000000000000000000000000000000000000777007770077700777000aa0007711
88888888888888888888888888887700887778877788777887778877777877000000000000000000000000000000000000777007770077700777000000007711
88888888888888888888888888888800888888888888888888888888888877000000000000000000000000000000000000000000000000000000000000007711
88885555888888888555588888888a00888888888888888888888888888888000000000000000000000000000000000080000000000000000000000000000011
8888566588888888856658888888880088885555888888888555588888888a000000000000000000000000000000000000000000000000000000000000000a11
00005665000000000566500000000000888855558888888885555888888888000000000000000000000000000000000080000000000000000000000000000011
00005555000000000555500000000000000055550000000005555000000000000000000000000000000000000000000011110000111111111000011111111111
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000777777777777777777777777777777777777777777777700000000000000000000000000000000000000000000000000000000000000000000000
00000000007777777777777777777777777777777777777777777777777000000000000000000000000000000000000000000000000000000000000000000000
00000077777777777777777777777777777777777777777777777777777770000000000000000000000022222222000000000000000000000000000000000000
0000077777777777777777777777777777777777777777777777777777777700000000000000000000ee88888888220000000000000000000000000000000000
99888888888888888888888888888888888aaa88888888888888888888888888888888aa000000000e8888888888882000000000000000000000000000000000
8888888888888888888888888888888888888888888888888888888888888888888888880000000ee88888888888888220000000000000000000000000000000
8888886666566666665666666666655666656666666566666665666665568888888888880000000e888888888888888820000000000000000000000000000000
888886666665666666656666666655666656666666556666665666665566688888887777000000e8877788888888888882000000000000000000000000000000
88886666666566666665666666665666665666666656666665566666566666888887777700000e88878888888888888888200000000000000000000000000000
88885555555555555555666666665666665666666556666665666666566666688887777700000e88878888888888888888200000000000000000000000000000
888866cccccc666cccc5c6666666566666566666656666666566666656666668888777770000e888888886555558888888820000000000000000000000000000
888866cccccc666ccc55c6666665555555555555555555555555555555555558888777770000e888888886888858888888820000000000000000000000000000
888866cccccc666ccc5cc66666656cccccc66ccc5cc66cccccc65cccccc66668888777770000e888888886777758888888820000000000000000000000000000
8888ddcccccdd66cccacc66666656cccccc66ccc5cc66cccccc65cccccc66668888777770000e888888886777758888888820000000000000000000000000000
8888ddcccccdd66ccc5cc66666656cccccc66ccc5cc66cccccc65cccccc66668888777770000e888888886888858888888820000000000000000000000000000
8888dd66666dd66666566666666a6ddcccc6ddccaccddcccccddacccccc66668888777770000e888888886a88a58888888820000000000000000000000000000
8888dddd666dddd66656666666656ddcccc6ddcc5ccddcccccdd5cccccc66668888777770000e888888886055058888888820000000000000000000000000000
8888dddd666dddd66656666666656dd66666dd66566dd66666dd566666666668888777770000e888888886666678888888820000000000000000000000000000
98881661666166166656666666656dddd666dddd566dddd666dd5d66666666688887777700000e88888888888888888888200000000000000000000000000000
98881661666166166656666666656dddd666dddd566dddd666dd5d66666666688888777700000e88888888888888888888200000000000000000000000000000
888855555555555555566666666561661666166156616616661651666666666888888888000000e8888888888888888882000000000000000000000000000000
9888555555555555555566666665616616661661566166166616516666666668888888880000000e888888888888888820000000000000000000000000000000
9888885555555555555555aaaaa55555555555555555555555555555511111a88888888a0000000ee88888888888888220000000000000000000000000000000
88888885555555555555555555555555555555555555555555555555558888888888888a000000000e8888888888882000000000000000000000000000000000
0008888888888888888888888888888888888888888888888888888888888888888880000000000000ee88888888220000000000000000000000000000000000
000888888556666558888888888888888888888888556666655888888888888888888000000000000000eeeeeeee000000000000000000000000000000000000
00000000055666655000000000000000000000000055666665500000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055666655000000000000000000000000055666665500000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055666655000000000000000000000000055666665500000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055555555000000000000000000000000055555555500000000000000000000000000000000000000000000000000000000000000000000000000000
22cccc5522222222ccccccccccccccccccccccccccccccccccccccccccccfccfccccccccccccccccccccccccccccccccccccccccccccccccccc777cccccccccc
222cc55522222222ccccccccccccccccccccccccccccccccccccc333ccc77777ccccccccccccccccccccccccccccccccccccccccc7777ccccc77777ccccc777c
2222555522222222cccccccccccccccccccccccccccccccccccb3333cccc7070cccccccccccccccccccc777ccccccccccccccc7777777cccc777777cccc77777
2222255522222222ccccccccccccccccccccccccccccccccc4333433c0777070ccccccccccccccccccc77777ccccccccccccc77777777ccc7777777ccc777777
2222255522222222cccccccccccccccccccccccccccccccc4444444407707eeeccccc777cccccccccc777777ccccccccccc77777777777cc7777777cc7777777
2222225522222222ccccccccccccccccccccccceccccccccc433343b077770e0ccc777777ccccccccc777777ccccccccccc777777777777c666666ccc7777777
2222222522222222ccccccc66ccccccccccccceecccccccc44444444c707077ccc77777777cccccccc666666ccccccccc77777777777777cccccccccc6666666
2222222222222222cccccc66666ccccccccceeeecccccecc343334337c7c7c7cc7777777777cccccccccccccccccccccc777777777777777cccccccccccccccc
22cccc55cccccccccccc6666666dccccccccccccccccee22ccccccccccccccccc6777777777cccccccccccccc7777cccc777777777777777cccccccccccccccc
222cc555ccccccccccc666d6666ddddccccccccccce2ee22cccccccc333ccccccc6666666cccc77ccccccc777777777cc777777777777777ccc77ccccc7777cc
22225555cccccccccc66666666dddddcccccccccceeee2222ccccccc333b3cccccccccccccc7777cccc777777777777cc666667777777777cc7777ccc777777c
22255555cccccccc6666666d6ddddddddddcccceeeeee2222ccccccc343334ccccccccccccc77777ccc77777777777ccc666666666666666cc77777cc7777777
22555555ccccccc66666d6d6ddddddddddddccce22ee222222cccccc44444444cccccccccc777777ccc66777777777ccccccccccccccccccc7777777c7777777
25555555ccccccc6d666666dddddddddddddee2eeee22222222ccccc34b3343ccccccccccc666666cccc666666666cccccccccccccccccccc7777777c7777777
55555555cccccc66666666dddddddddddddd2eeeeee22222222ccccc44444444cccccccccccccccccccccccccccccccccccccccccccccccccc77777cc6666666
55555555cccccc66666666666ddddddddddddeee2e2222222222cccc34333433ccccccccccccccccccccccccccccccccccccccccccccccccccc6666ccccccccc
ccccccccccccc66666d666663b3bbbbbdddddddddd22222222222cccccccccccccccccbbbbbccccc666666ddddddddddcccccccccc663333636d63cccccccccc
cccccccccccc66666d66666d33b33333dddddddddd22222222222ccccccccccccccccb333bbbbccc666666ddddddddddcccccccc33633dd633553d6ccccccccc
cccccccccccc6666666666dd3333333bdddddddddd22222222222ccccccccccccc333333333bbccc66d66dddddddddddccccccc3365566dddd535566cccccccc
ccccccccccc66666d666dddd34333433ddddddddddd22222222222cccccccccccc33b333b333bccc6666ddddddddddddcccccc636550666d650305d3cccccccc
cccccccccc66666666dddddd44444444ddddddddddd222222222222ccccccccccc3333333333bbbc66dddddddd366dddcccccc66550006dd30300053cccccccc
cccccccccc66666d66dddddd343b3433ddddddddddd2222222222222cccccccccc33333333333bbcdddddddd633d3d6dccccc636500006d66000005366cccccc
ccccccccd66666d66ddddddd44444444ddddddd6dddd22222222222222ccccccccc3333b333333bcddddddd663d63336ccccc665500006dd6000000636d6cccc
cccccccd666666666ddddddd34333433dddddd66dddddd222222222222ccccccccc333333333ccccdddddd6655066d36cccc66550000006d3000000363666ccc
ccccccdd66666666ccccc444dddddddd22ccccccddddddd2222222222222cccccccccc444442ccccdddddd655000663d666635000000006d3000005360000036
cccccdddd666666dccccccc4dddddddd222cccccdddddddd2222222222222ccccccccc444442ccccddddd6550000063366663300000000333300005d60000053
ccccdddddddd66ddccccccc4dddddddd2222ccccdddddddd22222222222222cccccccc444442ccccddddd6550000006d66666666666666d3d6666666d0000056
cccdddddddddddddccccccc4dddddddd22222cccddddddddd2222222222222ccccccc4442422ccccdddd355000000063aa6aaa6aaa6aaa56d66aaa6a60000053
ccddddddddddddddcccccc44dddddddd22222cccddddddddd22222222222222cccccc4444421ccccdddd355000000033aa6aaa6aaa6aaa63366aaa6a30000056
cdddddddddddddddcccccc44dddddddd222222ccdddddddddd22222222222222cccc44244421ccccdddd35000000003366666666666666633666666660000056
ddddddddddddddddccccc442dddddddd2222222cddddddddddd2222222222222cccc444444211cccdddd6500000000d366666666666666666666666660000056
ddddddddddddddddcccc4444dddddddd22222222ddddddddddd2222222222222cc444444422221ccdddd6500000000d666666666666666666666666630000053
000000160000000edddddddd0000000e6d000000cccc9999aaaccccccccc2222eeeccccc00000000000000000000000000000000000000000000000000000000
000006de6e000016dddddddd000000a6e6e00000cc999999aaaacccccc222222eeeecccc00000000000000000000000000000000000000000000000000000000
000e6dd61d600d6ddddddddd0000006edad6ae00c999999999aaaaccc222222222eeeecc00000000000000000000000000000000000000000000000000000000
06d1edddddde61dedddddddd00000eddddddd60099999999999aaaac22222222222eeeec00000000000000000000000000000000000000000000000000000000
0d6d6dddddddde6ddddddddd000006addddddd60999999999999aaaa222222222222eeee00000000000000000000000000000000000000000000000000000000
e1dddddddddddddddddddddd00000deddddddea0999999999999aaaa222222222222eeee00000000000000000000000000000000000000000000000000000000
6deddddddddddddddddddddd0000006adddddd6d9999999999999aaa2222222222222eee00000000000000000000000000000000000000000000000000000000
dddddddddddddddddddddddd00000006ddddddd69999999999999aaa2222222222222eee00000000000000000000000000000000000000000000000000000000
e6dddddddddddd16dddddddde0000000444444449999999a99999aaa2222222e22222eee00000000000000000000000000000000000000000000000000000000
deddddddddddddedddddddddd600000044444444999999a9999aaaaa222222e2222eeeee00000000000000000000000000000000000000000000000000000000
6ddddddddddddd60ddddddddad00000044444444999a999999aaaaaa222e222222eeeeee00000000000000000000000000000000000000000000000000000000
1edddddddddd6ed0ddddddddd60000004444444499a9999aaaaaaacc22e2222eeeeeeecc00000000000000000000000000000000000000000000000000000000
0616ddddd1dd1600deddadddded000004444444f999999a9aaaccccc222222e2eeeccccc00000000000000000000000000000000000000000000000000000000
00de1ded6de60000d6ded6dddd6000004444444499999999accccccc22222222eccccccc00000000000000000000000000000000000000000000000000000000
0006e6d1e1600000ea60006e6ae00000444444449999999aaccccccc2222222eeccccccc00000000000000000000000000000000000000000000000000000000
00000d6d600000006000000ad600000044444444999999a9accccccc222222e2eccccccc00000000000000000000000000000000000000000000000000000000
0000006d000000000000000000000000cccccccc99999999accccccc22222222eccccccc00000000000000000000000000000000000000000000000000000000
000000d1000000000000000000000000ccccccccc9999999aaccccccc2222222eecccccc00000000000000000000000000000000000000000000000000000000
006d0000000000000000000000000000cccccccccc999999aaaccccccc222222eeeccccc00000000000000000000000000000000000000000000000000000000
00d10000000000000000000000000000cccccccccc999999aaaccccccc222222eeeccccc00000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000ccccccccccc99999aaaaccccccc22222eeeecccc00000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000ccccccccccc999999aaaaaacccc222222eeeeeec00000000000000000000000000000000000000000000000000000000
6d000000000000000000000000000000cc9999cccc999999aaaaaaaacc222222eeeeeeee00000000000000000000000000000000000000000000000000000000
d100000000000000000000000000000099999999c99999999aaaaaaac22222222eeeeeee00000000000000000000000000000000000000000000000000000000
00000000000000000000000022222ccc66666666c99999999aaaaaaac22222222eeeeeee00000000000000000000000000000000000000000000000000000000
000000000000000000000000222552cc611611169999999999aaaaaa2222222222eeeeee00000000000000000000000000000000000000000000000000000000
0000000000000000000000002555555c6116111699999999999aaaaa22222222222eeeee00000000000000000000000000000000000000000000000000000000
0000000000000000000000005555555561161116c99999999999aaaac22222222222eeee00000000000000000000000000000000000000000000000000000000
0000000000000000000000005555555566666666c99999999999aaaac22222222222eeee00000000000000000000000000000000000000000000000000000000
0000000000000000000000002666666261161116999999999999aaaa222222222222eeee00000000000000000000000000000000000000000000000000000000
000000000000000000000000264461626116111699999999999aaacc22222222222eeecc00000000000000000000000000000000000000000000000000000000
0000000000000000000000002644666266666666c999999999aaccccc222222222eecccc00000000000000000000000000000000000000000000000000000000
__map__
0202020202020202020202020202020202020202020202020202028c8d020282830284959602020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020282
02028e02020202020202020202028a8b0202020202020202029e029c9d02919293949581a602028a8b0202020202020202020202028c8d0202020202020202020202020202020202020202020202020202020202020202020202028c8d02020202020202028a8b02020202020202020202020202028c8d020202020202029192
af0202029f0202020202020202029a9b0202020202020202020202020202a1a2b3b3a58181b4029a9b0202020202020202020202029c9d0202020202028a8b8b020202020202020202028c8d0202020202020202020202028a8b029c9d02020202020202029a9b02020202020202020202020202029c9d0202020202020292a2
ae020202020202020202020202020202020f02020202020202a8a90202a1a2b3b3b3b5b68181b40202020202290202020202a8a9020202a8a9a8a902029a9b0fa8a902020202020202029c9d02020202020202a8a90202029a9b02020202a8a90202020202020202020202020202020f0202020202020202a8a9020202a1aaab
bf2a0202020202020202020202020212021f1c1c1c1c1c1c2bb8b902b0b1b3b3b3b3b3a5818181b7020202021f0202020202b8b902022ab8b9b8b9020202021fb8b91c1c1c1c1c2b0202020202020202020212b8b9020202020202020202b8b92a02020202020202020202120202021f1c1c2b2a02020202b8b90212b0b3babb
be1010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010bcbd
1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101
0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202828302850202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202028283
af020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202919293949596020202020202a8a90202020202020202020202020202020202020202020202020202020202020202020202020202020202020202029293
ae020202020202020202020e0202020202020202020287020202870287020202020202020202020202020202020f0202020202020202020202020202020202020202a0a1a2b3b3a5a6a70202020287b8b90202020202a8a902a8a90202a8a902020202a8a90202a8a9a8a9a8a90202020202a8a9020202020202020202a1aaab
bf020202020202020202021f020202020202020c86a3a3a3a3a3a3a3a3972a02020202020202020202020202871f0202020202020202020202020202020202020202b0b1b3b3b3b5b6b7020286a3a3a3a39702020202b8b902b2b90202b8b90202b8b9b8b90202b8b9b8b9b8b90202020202b8b90202020202020202b0b3babb
be1010101010101010101014101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010bcbd
1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101
020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202e4e4020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202028283028502
0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202c5d5d5c6020202f402020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202919293949596
af02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202e5d5f4d60202020202f402020202020202020202020202020202020202020202020202020202020202020202020202020202020202c7c7c802020202a1a2b3b3a5f3
ae020202020202020202020202020202021e0202020202020202020202020202020202020202020202020202020202020202020202020202020202a8a902e5d5d5e6020f0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202e7d7f4e80fa0a1a2b3b3b3a4ab
bf020202020202020202020202020202021f0202020202020202020202020202020202020202020202020202020202020202020202020202020202b8b902f5d4d5f6021f0202d40202020202020202020202020202020202020202020202020202020202020202020202020202020202020202f7d4d7f81fb0b1b3b3b3b3babb
be1010101010101010101010101010101410101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010bcbd
1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101
0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000
02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202028200000000000000c0c1c1c1c40000000000000000000000000000000000000000
af02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202028283a1000000000000c3c2c2c2c2c2d300000000000000000000000000000000000000
ae0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202a1aaab000000000000c3c2c2c2c2c2d300000000000000000000000000000000000000
bf02020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202b0b3babb00000000000000d0d2d2d2d100000000000000404142434445464748494a4b4c
be101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010bcbd000000000000e0000000000000000000000000505152535455565758595a5b5c
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100000000000000000000000000000000000000606162636465666768696a6b6c
01010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010100000000000000000000000000000000000000707172737475767778797a7b7c
__sfx__
010a000026320283202a3202c3202f3202f300253001f300030000300002000020000200002000020000100002000020000100001000010000100000000010000100002000010000200001000010000200000000
010a00002f3202c3202a3202832026320263002f30009300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010700002c4202d4202e4102d4202a420294202a4202e4102a4202a4202c4202b4102a4202b42028420284102f4102e4202f4202c4202a4202b4102e4102f4202e4202a4102d4202d420304102e4202b4102e400
000900002e05029050320501e50020500205001c5001e50023500275002b5002e500345003550016500165001750018500195001b5001d5001e5001f5001e5001d5001c5001a5001950019500195001950020500
001200002b050290502705024050210501f0501b0501b0501b0501e0001c0001c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01120000290502a0502a0502805028050290502b0502c0502f050310503405034000350003b0003a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
