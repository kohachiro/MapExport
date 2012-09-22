-- J2me Map
function num_to_char ( number )
 return ( string.char ( math.mod ( math.mod ( number, 256 ) + 256, 256 ) ) )
end
function main ()
 local w = mappy.getValue(mappy.MAPWIDTH)
 local h = mappy.getValue(mappy.MAPHEIGHT)
 if (w == 0) then
  mappy.msgBox ("导出J2me地图格式", "请先绘制一个地图", mappy.MMB_OK, mappy.MMB_ICONINFO)
 else
 if(w>127 or h>127)then
  mappy.msgBox ("错误", "不支持超过宽或高大于127的地图", mappy.MMB_OK, mappy.MMB_ICONINFO)
 else
  local isok,x = mappy.doDialogue ("设置障碍图块", "请输入最后一个障碍图块编号", "0", mappy.MMB_DIALOGUE2)
  if isok == mappy.MMB_OK then
   x = tonumber (x)
   local isok,asname = mappy.fileRequester (".", "Textfiles (*.map)", "*.map", mappy.MMB_SAVE)
   if isok == mappy.MMB_OK then
    if (not (string.sub (string.lower (asname), -4) == ".map")) then
     asname = asname .. ".map"
    end
    outas = io.open (asname, "w")
    outas:write (num_to_char(x))
    outas:write (num_to_char(w))
    outas:write (num_to_char(h))
    local x = 0
    while x < w do
     local y = 0
     while y < h do
	temp=mappy.getBlock (x, y)
	if(temp==0)then
		temp=255;
	else
		temp=temp-1;
	end
       outas:write (num_to_char(temp))
       y = y + 1
     end
     x = x + 1
    end
    outas:close ()
   end
  end
 end
 end
end
test, errormsg = pcall( main )
if not test then
    mappy.msgBox("Error ...", errormsg, mappy.MMB_OK, mappy.MMB_ICONEXCLAMATION)
end