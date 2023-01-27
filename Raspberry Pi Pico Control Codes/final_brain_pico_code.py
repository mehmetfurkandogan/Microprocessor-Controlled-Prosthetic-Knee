import utime
from machine import Pin, PWM, ADC, UART, Timer
from time import sleep, ticks_ms

def map(val, loval, hival, tolow, tohigh):
     if loval <= val <= hival:
         return (val - loval)/(hival-loval)*(tohigh-tolow) + tolow
     elif val < loval:
         return tolow
     else:
         return tohigh

Gauge_Moment= ADC(27)
Gauge_Axial = ADC(26)
knee_angle = ADC(28)
Past_Knee_Angle =[0] * 20
Raw_Past_Knee_Angle =[0] * 20
Raw_Moment = 0
Raw_Axial = 0
Raw_KneeAngle = 0
Moment_bandwidth = 500
Moment = 0
Axial = 0
KneeAngle = 0
Phase = ""

Timer_freq = 10
Knee_Angle_Error_Compansation = 20 / Timer_freq # in degrees



uart0 = UART(0, baudrate=9600, tx=Pin(0), rx=Pin(1))

def tick(timer):
    global Raw_Moment, Raw_Axial, Raw_Past_Knee_Angle
    Raw_Moment = Gauge_Moment.read_u16()
    Raw_Axial = Gauge_Axial.read_u16()
    Raw_KneeAngle = knee_angle.read_u16()
    for i in range(len(Raw_Past_Knee_Angle)-1):
        Raw_Past_Knee_Angle[i+1]=Raw_Past_Knee_Angle[i]
    Raw_Past_Knee_Angle[0] = Raw_KneeAngle

    
Timer().init(freq=Timer_freq, mode=Timer.PERIODIC, callback=tick)

while 1:
    ## Data Modifying ##
    
    for i in range(len(Raw_Past_Knee_Angle)):
        Past_Knee_Angle[i] = map(Raw_Past_Knee_Angle[i],30900,44000,130,0)
        
    Raw_Normalized_Moment = Raw_Moment-15470
        
    ## Debugging Prints ##
    
#     if ((sum(Past_Knee_Angle)/len(Past_Knee_Angle)) - Knee_Angle_Error_Compansation) > Past_Knee_Angle[0]:
#         print("Knee angle has decreased")
#     elif ((sum(Past_Knee_Angle)/len(Past_Knee_Angle)) + Knee_Angle_Error_Compansation) < Past_Knee_Angle[0]:
#         print("Knee angle has increased")
#     else:
#         print("")
# 
#     
#     print("Gauge_Moment: %.2f   Gaule_Axial: %.2f   Knee angle: %.2f°" % (Raw_Normalized_Moment, Raw_Axial, Past_Knee_Angle[0]))
#     
#     
#     if (Raw_Normalized_Moment < -Moment_bandwidth):
#         print("heel contact")
#     elif (Raw_Normalized_Moment > Moment_bandwidth):
#         print("toe contact")
#     else:
#         print("")
        
        
################### DECISION AND SENDING INSTRUCTIONS ###############################

    if (((sum(Past_Knee_Angle)/len(Past_Knee_Angle)) + Knee_Angle_Error_Compansation*10) < Past_Knee_Angle[0]):
        uart0.write("4")
        Phase = "Error"
        sleep(5)
        
    elif (Raw_Normalized_Moment < - Moment_bandwidth):
        Phase = "Loading Response"
    elif (Raw_Normalized_Moment > Moment_bandwidth*5):
        Phase = "Terminal Stance"
    elif (((sum(Past_Knee_Angle)/len(Past_Knee_Angle)) + Knee_Angle_Error_Compansation) < Past_Knee_Angle[0]):
        Phase = "Initial Swing"
    elif(((sum(Past_Knee_Angle)/len(Past_Knee_Angle)) - Knee_Angle_Error_Compansation) > Past_Knee_Angle[0]):
        Phase = "Terminal Swing"
    else:
#         Phase = "Not detected"
        pass
    
    if Phase == "Loading Response":
        uart0.write("0")
    elif Phase == "Terminal Stance":
        uart0.write("1")
    elif Phase == "Initial Swing":
        uart0.write("2")
    elif Phase == "Terminal Swing":
        uart0.write("3")
    
    print(Phase)
    

###############################################################
    sleep(0.001)




