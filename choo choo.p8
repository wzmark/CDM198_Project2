pico-8 cartridge // http://www.pico-8.com
version 29
__lua__


function _init()
	gameLevel = 0
	timeCount = 0
	busInit()
	passangerInit()
end

function _draw()

	
	if((gameLevel < 4) and (gameLevel > 0)) then
		cls()
		mapDraw()
		palt(12, true) 
    	palt(0, false)
		if(bus.xposition > 30) then
			map(115, 28, 14 + bus.xposition-30, 66, 18, 4)
		else
			map(115, 28, 14, 66, 18, 4)
		end
		if(gameLevel == 1) then
			print("Press Direction Key to Move the Bus, Pick Up Passanger, and Drop Off Passanger", 15, 10)
			print("Press X to start Drop Off",20, 20)
		end
		passangerDraw()
		busDraw()
		palt(12, false)
		palt(0, true)
		print(bus.xposition, bus.xposition, 0, 7)
		print(gameLevel, bus.xposition, 14, 7)

	elseif(gameLevel >= 4) then
		cls()
		print("End of Game", 30, 30)
		print("Press X to Restart the Game", 25, 50)
	elseif(gameLevel == 0) then
		cls()
		
		print("Press X to start the Game", 15, 30)
		print()
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
	if(timeCount <= 30) then
		timeCount = timeCount + 1

	else
		timeCount = 0
		if(bus.up) then
			bus.up = false
		else
			bus.up = true
		end
	end
	if((gameLevel < 4) and (gameLevel > 0)) then
		busMove()
		pickUp()
		flag = 0
		if(btnp(5)) then
			flag = 1
		end
		if(flag == 1) then
			if(bus.passangerCount != 0) then
				dropOff()
			end
			
			flag = 0
		end

		if(bus.xposition > 30) then
			camera(0 + bus.xposition-30, 0)
		else
			camera(0, 0)
		end
	elseif(gameLevel >= 4) then
		if(btn(5)) then
			gameLevel = 0
		end
	elseif(gameLevel == 0) then
		if(btn(5)) then
			gameLevel = gameLevel + 1
		end
	end

	
end




-->8
function busInit()
	bus = {}
	bus.up = true
	bus.sprite1 = 32
	bus.sprite2 = 36
	bus.xposition = -20
	bus.yposition = 29
	bus.height = 2
	bus.width = 4
	bus.move = 0
	bus.pickList = {}
	bus.passangerCount = 0
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
			bus.passangerCount = bus.passangerCount + 1
		elseif((bus.xposition < passanger.xposition2) and (passanger.xposition2 < bus.xposition + 20)) then
			passanger.pickCheck2 = 1
			bus.pickList[#bus.pickList+1] = 2
			bus.passangerCount = bus.passangerCount + 1
		elseif((bus.xposition < passanger.xposition3) and (passanger.xposition3 < bus.xposition + 20)) then
			passanger.pickCheck3 = 1
			bus.pickList[#bus.pickList+1] = 3
			bus.passangerCount = bus.passangerCount + 1
		elseif((bus.xposition < passanger.xposition4) and (passanger.xposition4 < bus.xposition + 20)) then
			passanger.pickCheck4 = 1
			bus.pickList[#bus.pickList+1] = 4
			bus.passangerCount = bus.passangerCount + 1
		elseif((bus.xposition < passanger.xposition5) and (passanger.xposition5 < bus.xposition + 20)) then
			passanger.pickCheck5 = 1
			bus.pickList[#bus.pickList+1] = 5
			bus.passangerCount = bus.passangerCount + 1
		elseif((bus.xposition < passanger.xposition6) and (passanger.xposition6 < bus.xposition + 20)) then
			passanger.pickCheck6 = 1
			bus.pickList[#bus.pickList+1] = 6
			bus.passangerCount = bus.passangerCount + 1
		elseif((bus.xposition < passanger.xposition7) and (passanger.xposition7 < bus.xposition + 20)) then
			passanger.pickCheck7 = 1
			bus.pickList[#bus.pickList+1] = 7
			bus.passangerCount = bus.passangerCount + 1
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
				bus.passangerCount = passangerCount - 1
			end
		elseif (select == 2) then
			if(passanger.pickCheck2 == 1) then
				selectFlag = 1
				passanger.pickCheck2 = 0
				passanger.xposition2 = bus.xposition
				bus.passangerCount = passangerCount - 1
			end
		elseif (select == 3) then
			if(passanger.pickCheck3 == 1) then
				selectFlag = 1
				passanger.pickCheck3 = 0
				passanger.xposition3 = bus.xposition
				bus.passangerCount = passangerCount - 1
			end
		elseif (select == 4) then
			if(passanger.pickCheck4 == 1) then
				selectFlag = 1
				passanger.pickCheck4 = 0
				passanger.xposition4 = bus.xposition
				bus.passangerCount = passangerCount - 1
			end
		elseif (select == 5) then
			if(passanger.pickCheck5 == 1) then
				selectFlag = 1
				passanger.pickCheck5 = 0
				passanger.xposition5 = bus.xposition
				bus.passangerCount = passangerCount - 1
			end
		elseif (select == 6) then
			if(passanger.pickCheck6 == 1) then
				selectFlag = 1
				passanger.pickCheck6 = 0
				passanger.xposition6 = bus.xposition
				bus.passangerCount = passangerCount - 1
			end
		elseif (select == 7) then
			if(passanger.pickCheck7 == 1) then
				selectFlag = 1
				passanger.pickCheck7 = 0
				passanger.xposition7 = bus.xposition
				bus.passangerCount = passangerCount - 1
			end
		end

	end
	
	

end

function busDraw()
	if(bus.up) then
		spr(bus.sprite1, bus.xposition, bus.yposition, bus.width, bus.height)
	else
		spr(bus.sprite2, bus.xposition, bus.yposition, bus.width, bus.height)
	end
	
	
	
	

end
-->8

function passangerInit()
	passanger = {}
	passanger.sprite1 = 5 --3
	passanger.sprite2 = 6  --6
	passanger.sprite3 = 7 --1
	passanger.sprite4 = 8 --4
	passanger.sprite5 = 9 --5
	passanger.sprite6 = 10 --7
	passanger.sprite7 = 11 --2
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
			
			spr(passanger.pickSprite1, 35 + bus.xposition - 30, 82)
		else
			spr(passanger.pickSprite1, 35, 82)
			
		end

		
	end
	if(passanger.pickCheck2 == 0) then
		spr(passanger.sprite2, passanger.xposition2, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite2, 63 + bus.xposition-30, 79)
		else
			spr(passanger.pickSprite2, 63, 79)
			
		end
	end
	if(passanger.pickCheck3 == 0) then
		spr(passanger.sprite3, passanger.xposition3, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite3, 19 + bus.xposition-30, 78)
		else
			spr(passanger.pickSprite3, 19, 78)
			
		end
	end
	if(passanger.pickCheck4 == 0) then
		spr(passanger.sprite4, passanger.xposition4, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite4, 44 + bus.xposition-30, 80)
		else
			spr(passanger.pickSprite4, 44, 80)
			
		end
	end
	if(passanger.pickCheck5 == 0) then
		spr(passanger.sprite5, passanger.xposition5, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite5, 58 + bus.xposition-30, 82)
		else
			spr(passanger.pickSprite5, 58, 82)
			
		end
	end
	if(passanger.pickCheck6 == 0) then
		spr(passanger.sprite6, passanger.xposition6, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite6, 69 + bus.xposition-30, 82)
		else
			spr(passanger.pickSprite6, 69, 82)
			
		end
	end
	if(passanger.pickCheck7 == 0) then
		spr(passanger.sprite7, passanger.xposition7, passanger.yposition)
	else
		if(bus.xposition > 30) then
			
			spr(passanger.pickSprite7, 26 + bus.xposition-30, 76)
		else
			spr(passanger.pickSprite7, 26, 76)
			
		end
	end

end
__gfx__
0000000044444444cccccccc66666666ccaaaaccccccccccccccccccccaaaaaccccccccccccccccccccccccccccccccccccc22cccc9999cccceeeeccc555555c
0000000044444444cccccccc66666156caaaaaaccccc99cccccccccccca1aa1cccccccccceeecccccccccccccc1c1ccccc22222ccc9889ccc8888eecc588885c
0070070044444444cccccccc66666556aa000aaaccc9999ccc2222ccc2aaaaacccccccccce5ecccccc99ccccc33333ccc220202ccc9889cc888888eec577775c
0007700044444444ccccccccaa6aaa6aaa0aa0aacc97997cccd22dccc2aaaaacccc0c0ccceeecccccc97ccccc333333cc222222ccc9559cc8888888ec577775c
0007700044444444ccccccccaa615a6aaa000aaacf99999cc222222cc2aaaaacccccccccceee5ccc5599cccccc33333cceeeeeeccc9559cc8888888ec588885c
0070070044444444cccccccc66655666aa0a00aacf99999cc222222cccaaaaaccbccccccceeec55cc5559ccccccbcbccc4eeee4ccc9559cc8888888ec5a88a5c
0000000044444444cccccccc66666666caaaaaaccfcfcfcccf2222fcccc2cc2ccbccccccc4c4c55cc5669ccccccbcbccc4eeee4ccc9559ccc888888cc505505c
0000000044444444cccccccc66666666ccaaaacccccfcfcccccfcfccccc2cc2ccccbccccc4c4c05cc5665ccccccbcbcccc4c4ccccc9999cccc8888ccc555555c
66666666ffffffffcccccccc5555555566667766ccccccccccccccccccccccccccccccccceeecccccccccccccccccccccccccccccc9999cccc9999ccccc55ccc
6666666644444444cccccccc5555555566667766cc99cccccccccccccaaacccccccccccccee5cccccccccccccbcbcccccccccccccc9559cccc9559ccccc55ccc
6666666644444444cccccccc5555555566667766c9999ccccc2c2ccccaa0ccccccccccccceeeccccccc99cccccbcbccccccccccccc9559cccc9559ccccc55ccc
aa6aaa6a44444444ccc3333c95999599aa66776a97997cfccc2cdcccc2aacccccc0c0cbcceeeccccccc97cccccbcbccccccccccccc9aa9cccc9559ccccc55ccc
aa6aaa6a44444444cc33b38395999599aa66776af9999fcccc2c2cccc2aacccccccccbcc5cc4ccccc5599cccc33333cccccccccccc9aa9cccc9559ccccc55ccc
66666666444444443bb333b35555555566667766f9999fccccfc22ccc2aacccccbccccccc554cccccc5559ccc333333cf444f444cc9559cccc9bb9ccccc55ccc
6666666644444444b833b8335555555566667766ffcfcccccccc22fcccc2cccccbcbccccc55ccccccc5669cccc33333cffffffffcc9559cccc9bb9ccccc55ccc
6666666644444444bb3333b35555555566667766cfcfcccccccccfccccc2cccccccbccccc05ccccccc5665ccccc1c1cc44f44f44cc9999cccc9999ccccc55ccc
cccccc7777777777777777777cccccccccccccccccccccccccccccccccccccccccc99cccc777777ccccccccccccccccc11111111111111111111111111111111
ccccc7777777777777777777777cccccccccccc777777777777777777ccccccccc9999ccc707007ccceccccccccccccc11111115555555555555555551111111
ccccc7777777777777777777777cccccccccc7777777777777777777777cccccc999999cc770707cceaecc8ccccccccc11111555555555555555555555511111
888888888888888888888888888888ccccccc7777777777777777777777ccccc99009099c777777cccecc8a8cccccccc11111555555555555555555555511111
888888888888888888888888888888cc888888888888888888888888888888cc99090909c707007c3c3ccc8ccccccccc800000000000000a0000000000000a11
888888888888888888888888888877cc888888888888888888888888888888ccc999999cc707007cc33c33ccf466cccc00000000000000000000000000000011
8877788777887778877788555a5877cc888888888888888888888888888877cccc9999ccc707007cbc3cc3bcfffff66c00000000000000000000000000007711
88777887778877788777885aa55877cc8877788777887778877788555a5877ccccc99cccc777777c3b33b33344f44f4400777007770077700777000000007711
887778877788777887778877777877cc88777887778877788777885aa55877cc4544445444444744cccccccccccccccc00777007770077700777000a0a007711
887778877788777887778877777877cc887778877788777887778877777877cc6566665644444774cc9ccccccccccccc00777007770077700777000aa0007711
888888888888888888888888888877cc887778877788777887778877777877cc4544445444447444c9a9cc1c444444cc00777007770077700777000000007711
888888888888888888888888888888cc888888888888888888888888888877cc6566665644474444cc9cc1a1666664cc00000000000000000000000000007711
88880000888888888000088888888acc888888888888888888888888888888cc45444454477444443c3ccc1c444444cc80000000000000000000000000000011
888800008888888880000888888888cc88880000888888888000088888888acc6566665644744444c33c33cc222222cc00000000000000000000000000000a11
cccc0000ccccccccc0000ccccccccccc888800008888888880000888888888cc4544445444444444bc3cc3bc444444cc80000000000000000000000000000011
cccc0000ccccccccc0000ccccccccccccccc0000ccccccccc0000ccccccccccc65666656444444443b33b333ccccc4cc11110000111111111000011111111111
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000
fffffffffff7777777777777777777777777777777777777777777777fffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000
ffffffffff7777777777777777777777777777777777777777777777777fffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000
ffffff7777777777777777777777777777777777777777777777777777777fffffffffffffffffffffff22222222ffffffffffff000000000000000000000000
fffff777777777777777777777777777777777777777777777777777777777ffffffffffffffffffffee8888888822ffffffffff000000000000000000000000
99888888888888888888888888888888888aaa88888888888888888888888888888888aafffffffffe8888888888882fffffffff000000000000000000000000
888888888888888888888888888888888888888888888888888888888888888888888888fffffffee8888888888888822fffffff000000000000000000000000
888888666656666666566666666665566665666666656666666566666556888888888888fffffffe88888888888888882fffffff000000000000000000000000
888886666665666666656666666655666656666666556666665666665566688888887777ffffffe8877788888888888882ffffff000000000000000000000000
888866666665666666656666666656666656666666566666655666665666668888877777fffffe888788888888888888882fffff000000000000000000000000
888855555555555555556666666656666656666665566666656666665666666888877777fffffe888788888888888888882fffff000000000000000000000000
888866111111666111151666666656666656666665666666656666665666666888877777ffffe88888888655555888888882ffff000000000000000000000000
888866111111666111551666666555555555555555555555555555555555555888877777ffffe88888888688885888888882ffff000000000000000000000000
888866111111666111511666666561111116611151166111111651111116666888877777ffffe88888888677775888888882ffff000000000000000000000000
8888dd11111dd66111a11666666561111116611151166111111651111116666888877777ffffe88888888677775888888882ffff000000000000000000000000
8888dd11111dd66111511666666561111116611151166111111651111116666888877777ffffe88888888688885888888882ffff000000000000000000000000
8888dd66666dd66666566666666a6dd11116dd11a11dd11111dda1111116666888877777ffffe888888886a88a5888888882ffff000000000000000000000000
8888dddd666dddd66656666666656dd11116dd11511dd11111dd51111116666888877777ffffe88888888605505888888882ffff000000000000000000000000
8888dddd666dddd66656666666656dd66666dd66566dd66666dd56666666666888877777ffffe88888888666667888888882ffff000000000000000000000000
98881661666166166656666666656dddd666dddd566dddd666dd5d666666666888877777fffffe888888888888888888882fffff000000000000000000000000
98881661666166166656666666656dddd666dddd566dddd666dd5d666666666888887777fffffe888888888888888888882fffff000000000000000000000000
888855555555555555566666666561661666166156616616661651666666666888888888ffffffe8888888888888888882ffffff000000000000000000000000
988855555555555555556666666561661666166156616616661651666666666888888888fffffffe88888888888888882fffffff000000000000000000000000
9888885555555555555555aaaaa55555555555555555555555555555511111a88888888afffffffee8888888888888822fffffff000000000000000000000000
88888885555555555555555555555555555555555555555555555555558888888888888afffffffffe8888888888882fffffffff000000000000000000000000
111888888111111118888888888888888888888888111111111888888888888888888111ffffffffffee8888888822ffffffffff000000000000000000000000
111888888111111118888888888888888888888888111111111888888888888888888111ffffffffffffeeeeeeeeffffffffffff000000000000000000000000
fffffffff11111111fffffffffffffffffffffffff111111111fffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000
fffffffff11111111fffffffffffffffffffffffff111111111fffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000
ffffffffff111111fffffffffffffffffffffffffff1111111ffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000
fffffffffff1111fffffffffffffffffffffffffffff11111fffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000
22cccc5522222222ccccccccccccccccccccccccccccccccccccccccccccfccfccccccccccccccccccccccccccccccccccccccccccccccccccc777cccccccccc
222cc55522222222ccccccccccccccccccccccccccccccccccccc333ccc77777ccccccccccccccccccccccccccccccccccccccccc7777ccccc77777ccccc777c
2222555522222222cccccccccccccccccccccccccccccccccccb3333cccc7070cccccccccccccccccccc777ccccccccccccccc7777777cccc777777cccc77777
2222255522222222ccccccccccccccccccccccccccccccccc4333433c0777070ccccccccccccccccccc77777cc44421cccccc77777777ccc7777777ccc777777
2222255522222222cccccccccccccccccccccccccccccccc4444444407707eeeccccc777cccccccccc777777cc42421cccc77777777777cc7777777cc7777777
2222225522222222ccccccccccccccccccccccceccccccccc433343b077770e0ccc777777ccccccccc777777c444421cccc777777777777c666666ccc7777777
2222222522222222ccccccc66ccccccccccccceecccccccc44444444c707077ccc77777777cccccccc66666644444221c77777777777777cccccccccc6666666
2222222222222222cccccc66666ccccccccceeeecccccecc343334337c7c7c7cc7777777777ccccccccccccc42442221c777777777777777cccccccccccccccc
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
cccccccccd66666d66dddddd343b3433ddddddddddd2222222222222cccccccccc33333333333bbcdddddddd633d3d6dccccc636500006d66000005366cccccc
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
000000160000000edddddddd0000000e6d000000cccc9999aaaccccccccc2222eeeccccccccc1111222ccccc0000000000000000000000000000000000000000
000006de6e000016dddddddd000000a6e6e00000cc999999aaaacccccc222222eeeecccccc1111112222cccc0000000000000000000000000000000000000000
000e6dd61d600d6ddddddddd0000006edad6ae00c999999999aaaaccc222222222eeeeccc1111111112222cc0000000000000000000000000000000000000000
06d1edddddde61dedddddddd00000eddddddd60099999999999aaaac22222222222eeeec111111111112222c0000000000000000000000000000000000000000
0d6d6dddddddde6ddddddddd000006addddddd60999999999999aaaa222222222222eeee11111111111122220000000000000000000000000000000000000000
e1dddddddddddddddddddddd00000deddddddea0999999999999aaaa222222222222eeee11111111111122220000000000000000000000000000000000000000
6deddddddddddddddddddddd0000006adddddd6d9999999999999aaa2222222222222eee11111111111112220000000000000000000000000000000000000000
dddddddddddddddddddddddd00000006ddddddd69999999999999aaa2222222222222eee11111111111112220000000000000000000000000000000000000000
e6dddddddddddd16dddddddde0000000244444449999999a99999aaa2222222e22222eee11111112111112220000000000000000000000000000000000000000
deddddddddddddedddddddddd600000024444444999999a9999aaaaa222222e2222eeeee11111121111222220000000000000000000000000000000000000000
6ddddddddddddd60ddddddddad00000024444444999a999999aaaaaa222e222222eeeeee11121111112222220000000000000000000000000000000000000000
1edddddddddd6ed0ddddddddd60000002444444499a9999aaaaaaacc22e2222eeeeeeecc11211112222222cc0000000000000000000000000000000000000000
0616ddddd1dd1600deddadddded000002444444f999999a9aaaccccc222222e2eeeccccc11111121222ccccc0000000000000000000000000000000000000000
00de1ded6de60000d6ded6dddd6000002444444499999999accccccc22222222eccccccc111111112ccccccc0000000000000000000000000000000000000000
0006e6d1e1600000ea60006e6ae00000244444449999999aaccccccc2222222eeccccccc111111122ccccccc0000000000000000000000000000000000000000
00000d6d600000006000000ad600000024444444999999a9accccccc222222e2eccccccc111111212ccccccc0000000000000000000000000000000000000000
0000006d88888888cccccccccccccccccccccccc99999999accccccc22222222eccccccc111111112ccccccc0000000000000000000000000000000000000000
000000d188888888ccccccccccccccccccccccccc9999999aaccccccc2222222eeccccccc111111122cccccc0000000000000000000000000000000000000000
006d000088888888cccccccccccccccccccccccccc999999aaaccccccc222222eeeccccccc111111222ccccc0000000000000000000000000000000000000000
00d1000088888888cccccccccccccccccccccccccc999999aaaccccccc222222eeeccccccc111111222ccccc0000000000000000000000000000000000000000
0000000088888888ccccccccccccccccccccccccccc99999aaaaccccccc22222eeeeccccccc111112222cccc0000000000000000000000000000000000000000
0000000088888888ccccccccccccccccccccccccccc999999aaaaaacccc222222eeeeeecccc111111222222c0000000000000000000000000000000000000000
6d00000088888888cc1111cccc2222cccc9999cccc999999aaaaaaaacc222222eeeeeeeecc111111222222220000000000000000000000000000000000000000
d100000088888888111111112222222299999999c99999999aaaaaaac22222222eeeeeeec1111111122222220000000000000000000000000000000000000000
0000000000000000ccccccc222222ccc66666666c99999999aaaaaaa222222222eeeeeeec1111111122222220000000000000000000000000000000000000000
0000000000000000cccccc22222552cc611611169999999999aaaaaa2222222222eeeeee11111111112222220000000000000000000000000000000000000000
0000000000000000cccccc222555555c6116111699999999999aaaaa22222222222eeeee11111111111222220000000000000000000000000000000000000000
0000000000000000cccccc225555555561161116c99999999999aaaac22222222222eeeec1111111111122220000000000000000000000000000000000000000
0000000000000000cccccc225555555566666666c99999999999aaaac22222222222eeeec1111111111122220000000000000000000000000000000000000000
0000000000000000ccccccc22666666261161116999999999999aaaa222222222222eeee11111111111122220000000000000000000000000000000000000000
0000000000000000ccccccc2264461626116111699999999999aaacc22222222222eeecc11111111111222cc0000000000000000000000000000000000000000
0000000000000000ccccccc22644666266666666c999999999aaccccc222222222eeccccc11111111122cccc0000000000000000000000000000000000000000
__map__
0202020202020202020202020202020202020202020202020202028c8d020282830284959602020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020282
02028e0202e1e1e1e1e1e1e102028a0202e1e1e1e1e1e1e1029e029c9d02919293949581a602028a0202e1e1e1e1e1e1e1020202028c8de1e1e1e1e1e102020202e1e1e1e1e1e1e1020202020202020202020202020202020202028c8d02020202020202028a0202020202020202020202020202028c8d02e1e1e1e1e1029192
af0202029f02e1e1e1e1e1e1e1029a9b0202e1e1e1e1e1e1020202020202a1a2b3b3a58181b4029a9b0202e1e1e1e1e1e1020202029c9d02e1e1e1e1e18a0202020202e1e1e1e1e102028c8d0202020202020202020202028a02029c9d02020202020202029a9b02020202020202020202020202029c9d020202e1e1e10292a2
ae020202020202020202020202020202020f02020202020202a8a90202a1a2b3b3b3b5b68181b40202020202290202020202a8a9020202a8a9a8a902029a9b0fa8a902020202020202029c9d02020202020202a8a90202029a9b02020202a8a90202020202020202020202020202020f0202020202020202a8a9020202a1aaab
bf2a0202020202020202020202020212021f1c1c1c1c1c1c2bb8b902b0b1b3b3b3b3b3a5818181b7020202021f3a02020202b8b902022ab8b9b8b9020202021fb8b91c1c1c1c1c2b0202020202020202020212b8b9020202020202020202b8b92a02020202020202020202120202021f1c1c2b2a02020202b8b90212b0b3babb
be101010101010101010101010101010101010101010101010101010101010101010e1101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010e1101010101010101010101010101010101010101010101010101010101010101010bcbd
1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
0101010101010101010101010101010101010101010101010101010101010101010101013901010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101013901010101010101010101010101010101010101010101010101010101010101010101010101
0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202
029e0202028a0202020202020202020288890202020202029e020202020202028a0202020202020202020202020202028a020202020202020202888902020202020202028283028502028c8d020202020202020202020202028f02020202020202020202028c8d02020202020202020202020202020202888902020202028283
af020202029a9b020202020202020202989902020202020202020202020202029a9b0202020202028f020202020202029a9b02020202028a0202989902020202020202919293949596029c9d029e02a8a902020202020202020202020202020202020202029c9d0202020202020202029e020202020202989902020202029293
aea8a902020202020202020e02029f0202020202020287023a028702870202020202020f020202020202a8a90202020202020e02020202020202020202020f020202a0a1a2b3b3a5a6a70202020287b8b9020f020202a8a902a8a90202a8a9020ea8a9a8a90202a8a9a8a9a8a90f02020202a8a90202020202020e0202a1aaab
bfb8b93a020202120202021f020202020212020c86a3a3a3a3a3a3a3a3972a028b02871f1c1c1c2b0202b8b91202020202021f020202020202020202022a1f1c2b02b0b1b3b3b3b5b6b7020286a3a3a3a3971f1c2b02b8b93ab2b9028bb8b9021fb2b9b8b90202b8b9b2b9b8b91f1c1c1c2bb8b902023a0202021f02b0b3babb
be101010101010101010e11410101010101010101010101010101010101010101010101010e11010101010101010101010e114101010101010101010101010101010101010e110101010101010101010101010101010101010101010101010e1141010101010101010e1101010101010101010101010101010e114101010bcbd
1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
3901010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010139010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101013901
020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202e4e402020202020202020202020288890202020202020202e2e2020202020202020202020202e5f4d5d5d602020202020202020202020202020202028283028502
0202020202020202028a02020202020202020202020202020202888902020202028f020202020202028a020202020202020202020202028c8d0202028e02c5d5d5c6020202f40202020202020298990202e302020202c9d9d9ea02020202028a0202020202f5d5d5f4e602020202020288890202020202020202919293949596
af029f0202020202029a9b0202020202020202020202020202029899020202020202020202020202029a9b0202020202020202020202029c9d0202020202e5d5f4d60202020202f40202020202020202c7d7c8020202e9f4d9da02029e02029a9b02020202e5f4d5d5f6020202020202989902c7c7c802020202a1a2b3b3a5f3
ae0202020f02020202020202a8a90202021e02020202020202a8a9020202020e020202020202020f02020202020202020202021e02020202020202a8a902e5d5d5e6022902020202020f020202020ef2f4d7d8020202f9d9f4ea020f02020202020e02a8a9e5d5d5f4c6a8a902020f02020202e7d7f4e802a0a1a2b3b3b3a4ab
bf0202021f1c1c1c2b3a0202b2b90202021f0202022a3a2a2ab8b92a3a02021f020212020202021f1c1c1c1c2b0202020202021f02020212020202b2b92af5d4d5f6021f0202d402021f1c1c2b021f02f7d4e8120202e9d4d9fa2a1f1c1c1c2b021f12b2b9f5d5d4d5d6b8b902021f1c1c2b2af7d4d7f83ab0b1b3b3b3b3babb
be1010101010e11010101010101010e11410101010101010101010101010e1141010101010101010101010101010101010e11410101010101010101010101010101010101010101010e1101010e1141010101010101010101010101010101010e11410101010101010101010101010e11010101010101010101010100310bcbd
1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
0101010101010101010101010101010101010101010101010101013901010101010101010101010101010101010101010101010101010101010101010101010101010139010101010101010101010101010101010101010101010101010101010101010101010101010139010101010101010101010101010101010101010101
0202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000
02028c8d02020202020202020202028a0202020202020202020282839f850202020202028c8d0202020202029f02020202020202020202028a0202020202e202020202029e020202020202020202020202020202020202020202028a0202028200000000000000c0c1c1c1c40000000000000000000000000000000000000000
af029c9d02020202020202020202029a9b020202020202029f91929394959602020202029c9d02020202020202028f0202020202020202029a9b020202c9d9ca0202020202020202a8a902020202020202020202020202020202029a9b8283a1000000000000c3c2c2c2c2c2d300000000000000000000000000000000000000
ae02020202020202020202040202020202020f0202020202a0a1a2b3b3a5a6a7020202020202020202021e02020202020202020f020202020202020202e9d9f4ea020e022a028702b8b9870287020202020f0202020202020204020202a1aaab000000000000c3c2c2c2c2c2d300000000000000000000000000000000000000
bf3a0202020202020202121f0202020202021f1c1c1c2b02b0b1b3b3b3b5b6b7020202020202020202021f02120202020202021f1c1c1c1c2b02020212f9d4d9fa021f86a3a3a3a3a3a3a3a3a3972a02021f1c1c1c2b0212021f0202b0b3babb00000000000000d0d2d2d2d100000000000000404142434445464748494a4b4c
be101010101010101010e114381010101010101010101010101010101010101010e1031010101010e1141010101010101010101010101010101010101010101010e114101010101010101010101010101010101010101010e11038101010bcbd000000000000e0000000000000000000000000505152535455565758595a5b5c
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100000000000000000000000000000000000000606162636465666768696a6b6c
01010101010101010101010101390101010101010101010101010101010101010101010101010101010101010101390101010101010101010101010101010101010101010101010101010101010101010101010101010101390101010101010100000000000000000000000000000000000000707172737475767778797a7b7c
__sfx__
010a000026320283202a3202c3202f3202f300253001f300030000300002000020000200002000020000100002000020000100001000010000100000000010000100002000010000200001000010000200000000
010a00002f3202c3202a3202832026320263002f30009300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010700002c4202d4202e4102d4202a420294202a4202e4102a4202a4202c4202b4102a4202b42028420284102f4102e4202f4202c4202a4202b4102e4102f4202e4202a4102d4202d420304102e4202b4102e400
010900002e05029050320501e50020500205001c5001e50023500275002b5002e500345003550016500165001750018500195001b5001d5001e5001f5001e5001d5001c5001a5001950019500195001950020500
001200002b050290502705024050210501f0501b0501b0501b0501e0001c0001c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01120000290502a0502a0502805028050290502b0502c0502f050310503405034000350003b0003a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011200001f000210002300023000210001f0001f000210002300023000210001e0001f00021000210001f0001e0001e0001f0002100021000180001f000210002300023000210001f0001f000210002300023000
01140000210001f0001c0001c0001c0002b0002b0002d0002800028000280002b0002b0002b000240002400026000260002800028000320002400024000240002600026000280002800028000280002600026000
0110000026000260002400024000240002b000240002800028000280002b0002b0002b00024000240002600026000280002800028000280002800026000260002400024000260002600026000260002600026000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01140000280552a0552c05524005205551e5551c55524205280552a0552c0552f0002c055240002a0002700027055280552a055240051e5551c5551b5552400527055280552a055240052a055240002b00028000
011400001c5551e5552055500005147552a0352804500005287552a7552c7552f0002c055000002a0552805521055000000000034000340002d000215002d700370003000024500307001d5001f500215002d000
0114000000000290001d5001f5002150024000260002b0002b000240002400029000290000000000000340003400000000340002d0002d0002c0002d00030000300003000029000290001d5001f5002150000000
01140000240002b0002b000290002b000290002b000000000000000000000002d000000002d7002d70030000320003070030700290001d5001f500215002d00029000240002b0002b0002d0002d0002d0002d000
011400002b0002b0002b0002b00029000290002900029000000002f00028000260002600000000000003400000000340002d000240002b0003000030000000003000030000290002400029000290002900000000
01140000187001a7001c7000c7000e70010700137001570017700157002b000280002a00000000340003400000000320003000030000000003000030000300003000030000300003000000000000000000000000
011400000c0333c21514735147350c0331800010735107350c0333c2153c0150c0330c03314755147550c0000c0333c21512735127350c033180000f7350f7350c0333c2153c0150c0330c03312755127550c000
011400000c0333c215147551475514755180003c0150c0330c0333c2153c015205550c033000003c0000c0000c033123351032509325093000c0330c05515615156153c2150c0553c0150c053117251372515725
011400003c2003c0000c0003c20015500155000c0003c20013500135000c0000c00011500115000c0000c0000c0001270010700097000c2000c0003c00015700157003c2003c0000c0000c000000000000000000
011400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000400004000040000400004000040000400004000040000400004000040000400004000040000400008000080000800008000080000800008000080000800008000080000800008000080000800008000
011400000474204732047220471204742047320472204712047420473204722047120474204732047220471208742087320872208712087420873208722087120874208732087220871208742087320872208712
011400000d7420d7320d7220d7120d7420d7320d7220d7120d7420d7320d7220d7120d7420d7320d7220d71209742097320972209712097420973209742097320972209712097420973209742097320972209712
0114000009700097000d7000d7000d7000d7000d7000d7000d7000d7000d7000870008700087000870008700087000870008700087000d7000d7000d7000d7000d7000d7000d7000d70008700087000870008700
001400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 0a101544
00 0b111644
00 0a101544
00 0b111644
00 4e545944
04 4a424344
00 0a424344
