--[[TEXT WIDGET v1.2 by Wlourf 15/06/2010
This widget can drawn texts set in the text_settings table with some parameters
http://u-scripts.blogspot.com/2010/06/text-widget.html

The parameters (all optionals) are :
text        - text to display, default = "Conky is good for you"
              use conky_parse to display conky value ie text=conly_parse("${cpu cpu1}")
            - coordinates below are relative to top left corner of the conky window
x           - x coordinate of first letter (bottom-left), default = center of conky window
y           - y coordinate of first letter (bottom-left), default = center of conky window
h_align        - horizontal alignement of text relative to point (x,y), default="l"
              available values are "l": left, "c" : center, "r" : right
v_align        - vertical alignment of text relative to point (x,y), default="b"
              available values "t" : top, "m" : middle, "b" : bottom
font_name   - name of font to use, default = Free Sans
font_size   - size of font to use, default = 14
italic      - display text in italic (true/false), default=false
oblique     - display text in oblique (true/false), default=false (I don' see the difference with italic!)
bold        - display text in bold (true/false), default=false
angle       - rotation of text in degrees, default = 0 (horizontal)
colour      - table of colours for text, default = plain white {{1,0xFFFFFF,1}}
              this table contains one or more tables with format {P,C,A}
              P=position of gradient (0 = beginning of text, 1= end of text)
              C=hexadecimal colour 
              A=alpha (opacity) of color (0=invisible,1=opacity 100%)
              Examples :
              for a plain color {{1,0x00FF00,0.5}}
              for a gradient with two colours {{0,0x00FF00,0.5},{1,0x000033,1}}
              or {{0.5,0x00FF00,1},{1,0x000033,1}} -with this one, gradient will start in the middle of the text
              for a gradient with three colours {{0,0x00FF00,0.5},{0.5,0x000033,1},{1,0x440033,1}}
              and so on ...
orientation    - in case of gradient, "orientation" defines the starting point of the gradient, default="ww"
              there are 8 available starting points : "nw","nn","ne","ee","se","ss","sw","ww"
              (n for north, w for west ...)
              theses 8 points are the 4 corners + the 4 middles of text's outline
              so a gradient "nn" will go from "nn" to "ss" (top to bottom, parallele to text)
              a gradient "nw" will go from "nw" to "se" (left-top corner to right-bottom corner)
radial        - define a radial gradient (if present at the same time as "orientation", "orientation" will have no effect)
              this parameter is a table with 6 numbers : {xa,ya,ra,xb,yb,rb}
              they define two circle for the gradient :
              xa, ya, xb and yb are relative to x and y values above

Needs conky 1.8.0 

To call this script in the conkyrc, in before-TEXT section:
    lua_load /path/to/the/lua/script/text.lua
    lua_draw_hook_pre draw_text
 
v1.0    07/06/2010, Original release
v1.1    10/06/2010    Add "orientation" parameter
v1.2    15/06/2010  Add "h_align", "v_align" and "radial" parameters

]]
require 'cairo'


--FUNCTION FOR DATE AND TIME
function conky_draw_text1()
    text_settings={
        --BEGIN OF PARAMETERS        
        {
        text=conky_parse('Time'),
        x=40,
        y=172,
        font_name="ADELE",
        font_size="32",
        bold=true,
        colour={{1,0xffffff,1}},
        orientation="ww",
        angle= -90,
        },   
{
        text=conky_parse('_________'),
        x=45,
        y=176,
        font_name="monospace",
        bold=true,
        font_size="18",
        colour={{1,0x24BCB4,1}},
        orientation="ww",
        angle= -90,
        },     
  {
        text=conky_parse('Day'),
        x=36,
        y=294,
        font_name="adele",
        font_size="32",
        bold=true,
        colour={{1,0xffffff,1}},
        orientation="ww",
        angle= -90,
        },   
{
        text=conky_parse('_________'),
        x=45,
        y=298,
        font_name="monospace",
        bold=true,
        font_size="18",
        colour={{1,0x24BCB4,1}},
        orientation="ww",
        angle= -90,
        },     
 {
        text=conky_parse('System'),
        x=37,
        y=416,
        font_name="adele",
        font_size="28",
        bold=true,
        colour={{1,0xffffff,1}},
        orientation="ww",
        angle= -90,
        },   
{
        text=conky_parse('_________'),
        x=45,
        y=420,
        font_name="monospace",
        bold=true,
        font_size="18",
        colour={{1,0x24BCB4,1}},
        orientation="ww",
        angle= -90,
        },     
{
        text=conky_parse('Spotify'),
        x=37,
        y=538,
        font_name="adele",
        font_size="28",
        bold=true,
        colour={{1,0xffffff,1}},
        orientation="ww",
        angle= -90,
        },   
{
        text=conky_parse('_________'),
        x=45,
        y=542,
        font_name="monospace",
        bold=true,
        font_size="18",
        colour={{1,0x24BCB4,1}},
        orientation="ww",
        angle= -90,
        }
    }
    
    
--------------END OF PARAMETERS----------------


    if conky_window == nil then return end
    if tonumber(conky_parse("$updates"))<3 then return end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    cr = cairo_create (cs)
    
    for i,v in pairs(text_settings) do
        display_text(v)
    end
    
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end







--FUNCTION FOR INFOS TEXT , KERNEL ....
function conky_draw_text2()
    local h=0
    if conky_window ~=nil then h= conky_window.height end
    text_settings={
        --BEGIN OF PARAMETERS
--info:
        {text=conky_parse("$sysname $kernel") .. " * " .. conky_parse("${exec  openbox --version | grep Openbox}") 
         .. " * Conky " .. conky_version
         .. " * Up. : " .. conky_parse("${uptime_short}"),
        angle=-90,
        font_name="Sans",
        font_size=12,
        x=10,
        y=h-5,
        --09101a
        --715dba
        colour={{1,0xa85d98,0.8},
            {0,0xf1cee6,0.3}
            }
        }  ,
        
    }
    
    
--------------END OF PARAMETERS----------------


    if conky_window == nil then return end
    if tonumber(conky_parse("$updates"))<3 then return end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    cr = cairo_create (cs)
    
    for i,v in pairs(text_settings) do
        display_text(v)
    end
    
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end




--FUNCTION FOR CPU MEMORY  ....
function conky_draw_text3()
    local cpu=tonumber(conky_parse("$cpu"))
    if cpu==nil then cpu=0 end 
    local mem=tonumber(conky_parse("$memperc"))
    if mem==nil then mem=0 end

    if cpu<10 then cpu = "0" .. cpu end
    if mem<10 then mem = "0" .. mem end
    local txt_val="    " .. cpu .. "%       " .. mem ..  conky_parse("%       ${fs_free /home}       ${fs_free /}")
    local txt_txt="cpu           mem          home                      data"
    local xpos,ypos=5,0
    if conky_window ~=nil then ypos = conky_window.height - 5 end
    text_settings={
        --BEGIN OF PARAMETERS
        {text=txt_val,
        font_name="Clarendon",
        font_size="48",
        x=xpos,
        y=ypos,
        colour={{0,0x755585,1},{1,0x190f21,0}},
        orientation="nn",

        },
        {text=txt_val,
        font_name="Clarendon",
        font_size="48",
        x=xpos-2,
        y=ypos,
        colour={{0,0x755585,0.5},{1,0x190f21,0}},
        orientation="nn",
        
        },
        {text=txt_val,
        font_name="Clarendon",
        font_size="48",
        x=xpos+2,
        y=ypos,
        colour={{0,0x755585,0.5},{1,0x190f21,0}},
        orientation="nn",
        
        },
        {text=txt_txt,
        font_name="Clarendon",
        font_size="34",
        x=xpos,
        y=ypos,
        colour={{0,0xd294d6,1},{1,0x190f21,0}},
        orientation="nn",
        
        },
        {text=txt_txt,
        font_name="Clarendon",
        font_size="34",
        x=xpos+2,
        y=ypos,
        colour={{0,0xd294d6,0.5},{1,0x190f21,0}},
        orientation="nn",
        
        },
        {text=txt_txt,
        font_name="Clarendon",
        font_size="34",
        x=xpos-2,
        y=ypos,
        colour={{0,0xd294d6,0.5},{1,0x190f21,0}},
        orientation="nn",
        
        },     
      
    }
    
    
--------------END OF PARAMETERS----------------


    if conky_window == nil then return end
    if tonumber(conky_parse("$updates"))<3 then return end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    cr = cairo_create (cs)
    
    for i,v in pairs(text_settings) do
        display_text(v)
    end
    
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end















function rgb_to_r_g_b(tcolour)
    colour,alpha=tcolour[2],tcolour[3]
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
  
    
    
function rgb_to_r_g_b(tcolour)
    colour,alpha=tcolour[2],tcolour[3]
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function display_text(t)
    if t.text==nil then t.text="Conky is good for you !" end
    if t.x==nil then t.x = conky_window.width/2 end
    if t.y==nil then t.y = conky_window.height/2 end
    if t.colour==nil then t.colour={{1,0xFFFFFF,1}} end
    if t.font_name==nil then t.font_name="Free Sans" end
    if t.font_size==nil then t.font_size=14 end
    if t.angle==nil then t.angle=0 end
    if t.italic==nil then t.italic=false end
    if t.oblique==nil then t.oblique=false end
    if t.bold==nil then t.bold=false end
    if t.radial ~= nil then
        if #t.radial~=6 then 
            print ("error in radial table")
            t.radial=nil 
        end
    end
    if t.orientation==nil then t.orientation="ww" end
    if t.h_align==nil then t.h_align="l" end
    if t.v_align==nil then t.v_align="b" end    
    
    cairo_save(cr)
    cairo_translate(cr,t.x,t.y)
    cairo_rotate(cr,t.angle*math.pi/180)
    local slant = CAIRO_FONT_SLANT_NORMAL
    local weight =CAIRO_FONT_WEIGHT_NORMAL
    if t.italic then slant = CAIRO_FONT_SLANT_ITALIC end
    if t.oblique then slant = CAIRO_FONT_SLANT_OBLIQUE end
    if t.bold then weight = CAIRO_FONT_WEIGHT_BOLD end
    cairo_select_font_face(cr, t.font_name, slant,weight)
    cairo_set_font_size(cr,t.font_size)
    
    for i=1, #t.colour do    
        if #t.colour[i]~=3 then 
            print ("error in color table")
            t.colour[i]={1,0xFFFFFF,1} 
        end
    end
    local te=cairo_text_extents_t:create()
    cairo_text_extents (cr,t.text,te)
    if #t.colour==1 then 
        cairo_set_source_rgba(cr,rgb_to_r_g_b(t.colour[1]))
    else
        local pat
        if t.radial==nil then
            local pts=linear_orientation(t,te)
            pat = cairo_pattern_create_linear (pts[1],pts[2],pts[3],pts[4])
        else
            pat = cairo_pattern_create_radial (t.radial[1],t.radial[2],t.radial[3],t.radial[4],t.radial[5],t.radial[6])
        end
        
        for i=1, #t.colour do
            cairo_pattern_add_color_stop_rgba (pat, t.colour[i][1], rgb_to_r_g_b(t.colour[i]))
        end
        cairo_set_source (cr, pat)
        cairo_pattern_destroy(pat)
    end
    
    local mx,my=0,0
    
    if t.h_align=="c" then
        mx=-te.width/2
    elseif t.h_align=="r" then
        mx=-te.width
    end
    if t.v_align=="m" then
        my=-te.height/2-te.y_bearing
    elseif t.v_align=="t" then
        my=-te.y_bearing
    end
    cairo_move_to(cr,mx,my)
    
    cairo_show_text(cr,t.text)
    cairo_stroke(cr)
    cairo_restore(cr)
end


function linear_orientation(t,te)
    local w,h=te.width,te.height
    local xb,yb=te.x_bearing,te.y_bearing
    
    if t.h_align=="c" then
        xb=xb-w/2
    elseif t.h_align=="r" then
        xb=xb-w
       end    
    if t.v_align=="m" then
        yb=-h/2
    elseif t.v_align=="t" then
        yb=0
       end    
       
    if t.orientation=="nn" then
        p={xb+w/2,yb,xb+w/2,yb+h}
    elseif t.orientation=="ne" then
        p={xb+w,yb,xb,yb+h}
    elseif t.orientation=="ww" then
        p={xb,h/2,xb+w,h/2}
    elseif vorientation=="se" then
        p={xb+w,yb+h,xb,yb}
    elseif t.orientation=="ss" then
        p={xb+w/2,yb+h,xb+w/2,yb}
    elseif vorientation=="ee" then
        p={xb+w,h/2,xb,h/2}        
    elseif t.orientation=="sw" then
        p={xb,yb+h,xb+w,yb}
    elseif t.orientation=="nw" then
        p={xb,yb,xb+w,yb+h}
    end
    return p
end
