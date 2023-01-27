#!/usr/bin/python3
import PySimpleGUI as sg
import serial
from time import sleep
import io
import socket, _thread

# host = '192.168.43.127'  # as both code is running on same pc
host = '192.168.43.166'  # as both code is running on same pc
port = 80  # socket server port number

client_socket = socket.socket()  # instantiate
client_socket.connect((host, port))  # connect to the server

message = '' # message to be sent to pico


def receive_from_pico():
	while 1:
		comingMessage = client_socket.recv(512)
		comingMessage = comingMessage.decode('utf-8')
		print(comingMessage)
		s = comingMessage.split(',')

		battery = s[0]
		phase = s[1]
		if phase=='0':
			phase = 'Loading Response'
		elif phase == '1':
			phase = 'Terminal Stance'
		elif phase == '2':
			phase = 'Initial Swing'
		elif phase == '3':
			phase = 'Terminal Swing'
		elif phase == '4':
			phase = 'An anomaly has beed detected'
		window['battery'].update(battery)
		window['phase'].update(phase)


# THEME
sg.theme('Default1')
# fonts = sg.Text.fonts_installed_list()

# All the stuff inside your window.
# background color #f4f4f4
# proted color #223d83
layout = [	[sg.Image(source='~/ME407/proted_white_small.png',size=(100,100)),
				sg.Text('C-Leg Controller',font='Courier` 15', background_color='#f4f4f4'),
				sg.Image(source='~/ME407/odtü_small.png',size=(120,100),background_color='#f4f4f4')],
			[sg.Text('Height (cm):',font='Courier` 12', background_color='#f4f4f4',text_color='#223d83'),
				sg.Input(size=(10,1), key='Height')],
			[sg.Text('Weight (kg):',font='Courier` 12', background_color='#f4f4f4',text_color='#223d83'),
				sg.Input(size=(10,1), key='Weight')],
			[sg.Text('Foot Size (Eu):',font='Courier` 12', background_color='#f4f4f4',text_color='#223d83'),
				sg.Input(size=(10,1), key='FootSize')],
			[sg.Text('Mode:',font='Courier` 12', background_color='#f4f4f4',text_color='#223d83'),
				sg.Radio('Walking','Modes', background_color='#f4f4f4', enable_events = True, key='Walking'),
				sg.Radio('Standing','Modes', background_color='#f4f4f4', enable_events = True, key='Standing'),
				sg.Radio('Running','Modes', background_color='#f4f4f4', enable_events = True, key='Running')],
			[sg.Button('Send to C-Leg',mouseover_colors=('white','#223d83'))],
			[sg.Text('Battery Percentage:',font='Courier` 12', background_color='#f4f4f4',text_color='#223d83'),
				sg.Text('',key='battery',font='Courier` 12',background_color='#f4f4f4')],
			[sg.Text('Phase:',font='Courier` 12', background_color='#f4f4f4',text_color='#223d83'),
				sg.Text('',key='phase',font='Courier` 12',background_color='#f4f4f4')],
			[sg.Text('ME407 Mechanical Engineering Design Project Group K2',key='phase',font='Courier` 6',background_color='#f4f4f4',text_color='#404040')],
			[sg.Image(source='~/Licenses/cc_s.png',size=(10,10),background_color='#f4f4f4'),
				sg.Image(source='~/Licenses/by_s.png',size=(10,10),background_color='#f4f4f4'),
				sg.Image(source='~/Licenses/nc_s.png',size=(10,10),background_color='#f4f4f4'),
				sg.Image(source='~/Licenses/sa_s.png',size=(10,10),background_color='#f4f4f4'),
				sg.Text('Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)',key='phase',font='Courier` 6',background_color='#f4f4f4',text_color='#404040')]
]

# Create the Window
window = sg.Window('C-LEG CONTROLLER', layout, background_color='#f4f4f4',finalize=True)

# Event Loop to process "events" and get the "values" of the inputs
step = 0
sleep(1) # wait till the window is fully rendered
receive_thread = _thread.start_new_thread(receive_from_pico,()) # staring a thread to receieve information from pico in a loop

while True:
	event, values = window.read(timeout = 1000)

	# Decoding the information to be sent
	if event == 'Walking':
		message = '0'
	elif event == 'Standing':
		message = '1'
	elif event == 'Running':
		message = '2'
	
	# closing the window
	if event == sg.WIN_CLOSED: # if user closes window
		print('Estoy muerto!')
		client_socket.close()
		break
	# sending the information to the pico if Send to C-Leg button is pressed
	if event == 'Send to C-Leg':
		message = message + ',' + values['Height']+','+values['Weight']+','+values['FootSize']
		print(message)
		client_socket.send(message.encode())
		message = ''
		window['Walking'].ResetGroup()


window.close()