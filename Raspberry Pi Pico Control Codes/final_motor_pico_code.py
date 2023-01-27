import network
import socket
import time
from machine import Pin, ADC, PWM, UART, Timer
import random
import _thread, math


global desiredAngle

switch = Pin(16,Pin.IN,Pin.PULL_UP)
 

########CIRCUIT_SETUP#######

uart0 = UART(0, baudrate=9600, tx=Pin(0), rx=Pin(1))
rxData=bytes()


vib = Pin(13, Pin.OUT, value=0)
buzz = Pin(11, Pin.OUT, value=0)

encoder_flex = ADC(28)
encoder_ext = ADC(27)
battery = ADC(26)

in1_flex = PWM(Pin(21))
in2_flex = PWM(Pin(20))

in1_ext = PWM(Pin(19))
in2_ext = PWM(Pin(18))

in1_flex.freq(1000)
in2_flex.freq(1000)
in1_ext.freq(1000)
in2_ext.freq(1000)

####################

#########PID_SETUP##########

Kp = 30
Kd = 0
Ki = 0

############################

voltage_max = 4.2
voltage_min = 3.4

def flexionControl():
    global flex_ang, encoder_flex, in1_flex, in2_flex
    while True:
        motorPos(flex_ang,encoder_flex,in1_flex,in2_flex)

def motorPos(desiredAngle,encoder, in1,in2):
        desiredPos = map(desiredAngle, -33, 33, 10000, 52000)
 
        error = 0
        currentTime = 0
        prevError = 0
        prevTime = 0

         
        current_time = 0
        Kp = 30

         

        currentPos = encoder.read_u16()
        error = desiredPos - currentPos
        currentTime = time.ticks_us()
        if abs(error) < 1500:
            error = 0
        output = Kp*error 
        

        if output > 0:
            if abs(output) > 65535:
                output = 65535
            in1.duty_u16(math.floor(abs(output)))
            in2.duty_u16(0)
        else:
            if abs(output) > 65535:
                output = 65535
            in1.duty_u16(0)
            in2.duty_u16(math.floor(abs(output)))
        
#         prevTime = currentTime
#         
#         if(time.ticks_ms() - current_time > 500):
#             current_time = time.ticks_ms()
#             print(str(map(currentPos, 10000, 52000, -33, 33)) + ", " + str(currentPos) + ", " + str(desiredPos))





def map(val, loval, hival, tolow, tohigh):
     if loval <= val <= hival:
         return (val - loval)/(hival-loval)*(tohigh-tolow) + tolow
     elif val < loval:
         return tolow
     else:
         return tohigh





Mode = ''

def recieve():
    while True:
        try:

            request = cl.recv(512)
            request = request.decode('utf-8')
#             print(request)
            a = request.split(',')
            
            if a[0] == '0':
                Mode = 'Walking'
                desiredAngle = -20
                
            elif a[0] == '1':
                Mode = 'Standing'
                desiredAngle = 33
                
            else:
                Mode = 'Running'
                desiredAngle = -33
                
            print(desiredAngle)
            Height = a[1]
            Weight = a[2]
            Foot_Size = a[3]
#             print('Mode is:',Mode,'Height is:',Height,'Weight is:',Weight,'Foot Size is:',Foot_Size)
            
            
#             print('desired angle is: ',desiredAngle)
            desiredPos = map(desiredAngle, -33, 33, 10000, 52000)
     
            error = 0
            currentTime = 0
            prevError = 0
            prevTime = 0

             
            current_time = 0
            Kp = 30

             

            currentPos = encoder_flex.read_u16()
            error = desiredPos - currentPos
            currentTime = time.ticks_us()
            if abs(error) < 2000:
                error = 0
            output = Kp*error 
            

            if output > 0:
                if abs(output) > 65535:
                    output = 65535
                in1_flex.duty_u16(math.floor(abs(output)))
                in2_flex.duty_u16(0)
            else:
                if abs(output) > 65535:
                    output = 65535
                in1_flex.duty_u16(0)
                in2_flex.duty_u16(math.floor(abs(output)))
            
            prevTime = currentTime
            
            if(time.ticks_ms() - current_time > 500):
                current_time = time.ticks_ms()
                print(str(map(currentPos, 10000, 52000, -33, 33)) + ", " + str(currentPos) + ", " + str(desiredPos))
            

                
        except OSError as e:
            cl.close()
            print('connection closed')
            time.sleep(1)
            
old_phase = ''
flag = False
sent_time = 0

flex_ang = -33
thread = _thread.start_new_thread(flexionControl, ())
        
while True:
#     print('burdayım')
#     time.sleep(0.002)
    while uart0.any() > 0:
        rxData += uart0.read(1)
    phase =rxData.decode('utf-8')
    rxData = bytes()
    
    if len(phase) == 1:
#         print(phase)
        if phase == '0':
            ext_ang = 33
            flex_ang = 22
        elif phase == '1':
            ext_ang = -33
            flex_ang = 33
        elif phase == '2':
            ext_ang = 33
            flex_ang = -33
        elif phase == '3':
            ext_ang = -33
            flex_ang = 33
        elif phase == '4':
            ext_ang = 33
            flex_ang = 33
        else:
            pass
            
#         print(data_arr)
#         print(flex_ang,'\n',ext_ang)
#         if old_phase != phase:
        motorPos(ext_ang,encoder_ext,in1_ext,in2_ext)
#         old_phase = phase
    #print('burdayım')
    #time.sleep(0.5)
    
    if switch.value() == 0:
#         print('buraya geldim')
        wlan = network.WLAN(network.STA_IF)
        wlan.active(True)
        wlan.connect('evci','samsunbursa')
        
        # Wait for connect or fail
        max_wait = 10
        while max_wait > 0:
            if wlan.status() < 0 or wlan.status() >= 3:
                break
            max_wait -= 1
            print('waiting for connection...')
            time.sleep(1)

        # Handle connection error
        if wlan.status() != 3:
            raise RuntimeError('network connection failed')
        else:
            print('connected')
            status = wlan.ifconfig()
            print( 'ip = ' + status[0] )
            buzz.toggle()

        # Open socket
        addr = socket.getaddrinfo('0.0.0.0', 80)[0][-1]

        s = socket.socket()
        s.bind(addr)
        s.listen(2)

        print('listening on', addr)
        
        cl, addr = s.accept()
        print('client connected from', addr)
        buzz.toggle()
#         print('buraya da geldim')

        try:
            thread2 = _thread.start_new_thread(recieve, ())
            flag = True
        except Exception as e:
            print("Exception Handled in Main, Details of the Exception:", e)

    
    if flag and ((time.ticks_ms() - sent_time)>500):
        final_voltage= 0
        avg_voltage = 0
        for i in range(10):
            voltage = battery.read_u16()*5/(2**16-1)
            final_voltage = final_voltage + voltage
        avg_voltage=final_voltage/10
        print(avg_voltage)

        battery_percentage = 100*(avg_voltage - voltage_min)/(voltage_max - voltage_min)
    
        if battery_percentage<0:
            battery_percentage=0
        elif battery_percentage>100:
            battery_percentage=100
        if len(phase) == 1:
            print(phase)
            mes = str(int(float(battery_percentage))) + ',' + phase
            cl.send(mes.encode())
            sent_time = time.ticks_ms()

    #time.sleep(1)



