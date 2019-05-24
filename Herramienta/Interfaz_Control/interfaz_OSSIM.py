import tkinter
import os
from tkinter import *
from PIL import ImageTk, Image
from tkinter import messagebox
from tkinter.ttk import Progressbar

dir_path = os.path.dirname(os.path.realpath(__file__))
path0 = dir_path + "/scripts/"
path1 = dir_path + "/logos/logo2.png"
path2 = dir_path + "/logos/logo3.png"

current_id = 0

def init(str):
	os.system("sh "+path0+str+".sh")
	selection = "              " 
	label_0 = tkinter.Label(root)
	label_0.config(text = selection)
	label_0.place(x=530, y=300, width=150, height=30)

def init_id_1(str, id):
	os.system("sh "+path0+str+".sh")
	current_id = id
	selection = "Cargado Escenario 1" 
	label_1 = tkinter.Label(root)
	label_1.config(text = selection)
	label_1.place(x=530, y=300, width=200, height=50)
	messagebox.showinfo( "Elementos levantados para el Escenario 1", "192.168.1.110 Elasticsearch\n192.168.1.120 Logstash\n192.168.1.130 Kibana\nmodo host Suricata\n192.168.1.136 Kali Linux\n192.168.1.140 IEC Server\n192.168.1.141 IEC Client"),

def init_id_2(str, id):
	os.system("sh "+path0+str+".sh")
	current_id = id
	selection = "Cargado Escenario 2" 
	label_2 = tkinter.Label(root)
	label_2.config(text = selection)
	label_2.place(x=530, y=300, width=200, height=50)
	messagebox.showinfo( "Elementos levantados para el Escenario 2", "192.168.1.10 Elasticsearch\n192.168.1.20 Logstash\n192.168.1.30 Kibana\nmodo host Suricata\n192.168.1.60 Kali Linux\n192.168.1.70 ModBus Server\n192.168.1.80 ModBus Client"),

def init_id_3(str, id):
	os.system("sh "+path0+str+".sh")
	current_id = id
	selection = "Cargado Escenario 3" 
	label_3 = tkinter.Label(root)
	label_3.config(text = selection)
	label_3.place(x=530, y=300, width=200, height=50)
	messagebox.showinfo( "Elementos levantados para el Escenario 3", "192.168.1.200 Elasticsearch\n192.168.1.204 Logstash\n192.168.1.203 Kibana\nmodo host Suricata\n192.168.1.206 Kali Linux\nDNP3 Server [VM]\nDNP3 Client[VM]"),

def network_map_1():
	network_map_1 = tkinter.Toplevel()
	network_map_1.title("Mapa de Red Escenario 1")
	network_map_1.geometry("800x600")
	network_map_1.configure(background='grey')

	path_map_1 = '/home/mario/Documentos/TFM/Interfaz_Dinamica/Desarrollo/mapa_red/1.png'

	img = ImageTk.PhotoImage(Image.open(path_map_1))
	panel = tkinter.Label(network_map_1, image = img)
	panel.pack(side = "bottom", fill = "both", expand = "yes")
	network_map_1.mainloop()

def network_map_2():
	network_map_2 = tkinter.Toplevel()
	network_map_2.title("Mapa de Red Escenario 2")
	network_map_2.geometry("800x600")
	network_map_2.configure(background='grey')

	path_map_2 = '/home/mario/Documentos/TFM/Interfaz_Dinamica/Desarrollo/mapa_red/2.png'

	img = ImageTk.PhotoImage(Image.open(path_map_2))
	panel = tkinter.Label(network_map_2, image = img)
	panel.pack(side = "bottom", fill = "both", expand = "yes")
	network_map_2.mainloop()

def network_map_3():
	network_map_3 = tkinter.Toplevel()
	network_map_3.title("Mapa de Red Escenario 3")
	network_map_3.geometry("800x600")
	network_map_3.configure(background='grey')

	path_map_3 = '/home/mario/Documentos/TFM/Interfaz_Dinamica/Desarrollo/mapa_red/3.png'

	img = ImageTk.PhotoImage(Image.open(path_map_3))
	panel = tkinter.Label(network_map_3, image = img)
	panel.pack(side = "bottom", fill = "both", expand = "yes")
	network_map_3.mainloop()

root = tkinter.Tk()
root.option_add('*Dialog.msg.width', 30)
root.title("Simulador Infraestructuras Criticas")
root.configure(width=730, height=610)
root.config(bd=15)

text1 = tkinter.Label(root, text="IEC 104", fg="blue",font=("Comic Sans", 11))
text2 = tkinter.Label(root, text="ModBus", fg="blue",font=("Comic Sans", 11))
text3 = tkinter.Label(root, text="DNP3", fg="blue",font=("Comic Sans", 11))
text4 = tkinter.Label(root, text="Personalizado", fg="blue",font=("Comic Sans", 11))
text1.place(x=50, y=20, width=150, height=30)
text2.place(x=210, y=20, width=150, height=30)
text3.place(x=370, y=20, width=150, height=30)
text4.place(x=530, y=20, width=150, height=30)

button_1 = tkinter.Button(root, text="Iniciar Escenario 1", command=lambda: init_id_1("escenario1",1))
button_2 = tkinter.Button(root, text="Iniciar Escenario 2", command=lambda: init_id_2("escenario2",2))
button_3 = tkinter.Button(root, text="Iniciar Escenario 3", command=lambda: init_id_3("escenario3",3))
button_4 = tkinter.Button(root, text="Iniciar Escenario 4", command=lambda: init("dynamic-compose"))
button_1.place(x=50, y=50, width=150, height=30)
button_2.place(x=210, y=50, width=150, height=30)
button_3.place(x=370, y=50, width=150, height=30)
button_4.place(x=530, y=50, width=150, height=30)

button_5 = tkinter.Button(root, text="Parar Escenario 1", command=lambda: init("stop_escenario_1"))
button_6 = tkinter.Button(root, text="Parar Escenario 2", command=lambda: init("stop_escenario_2"))
button_7 = tkinter.Button(root, text="Parar Escenario 3", command=lambda: init("stop_escenario_3"))
button_8 = tkinter.Button(root, text="Parar Escenario 4", command=lambda: init("stop_escenario_4"))
button_5.place(x=50, y=100, width=150, height=30)
button_6.place(x=210, y=100, width=150, height=30)
button_7.place(x=370, y=100, width=150, height=30)
button_8.place(x=530, y=100, width=150, height=30)

button_9 = tkinter.Button(root, text="Reiniciar Escenario 1", command=lambda: init("start_escenario_1"))
button_10 = tkinter.Button(root, text="Reinciar Escenario 2", command=lambda: init("start_escenario_2"))
button_11 = tkinter.Button(root, text="Reiniciar Escenario 3", command=lambda: init("start_escenario_3"))
button_12 = tkinter.Button(root, text="Reiniciar Escenario 4", command=lambda: init("start_escenario_4"))
button_9.place(x=50, y=150, width=150, height=30)
button_10.place(x=210, y=150, width=150, height=30)
button_11.place(x=370, y=150, width=150, height=30)
button_12.place(x=530, y=150, width=150, height=30)

button_13 = tkinter.Button(root, text="Eliminar Escenario 1", command=lambda: init("down_escenario_1"))
button_14 = tkinter.Button(root, text="Eliminar Escenario 2", command=lambda: init("down_escenario_2"))
button_15 = tkinter.Button(root, text="Eliminar Escenario 3", command=lambda: init("down_escenario_3"))
button_16 = tkinter.Button(root, text="Eliminar Escenario 4", command=lambda: init("down_escenario_4"))
button_13.place(x=50, y=200, width=150, height=30)
button_14.place(x=210, y=200, width=150, height=30)
button_15.place(x=370, y=200, width=150, height=30)
button_16.place(x=530, y=200, width=150, height=30)

button_17 = tkinter.Button(root, text="Ver Escenario 1", command=network_map_1)
button_18 = tkinter.Button(root, text="Ver Escenario 2", command=network_map_2)
button_19 = tkinter.Button(root, text="Ver Escenario 3", command=network_map_3)
button_17.place(x=50, y=250, width=150, height=30)
button_18.place(x=210, y=250, width=150, height=30)
button_19.place(x=370, y=250, width=150, height=30)


# Logo UPM
logo1 = ImageTk.PhotoImage(Image.open(path1))
panel1 = tkinter.Label(root, image = logo1)
panel1.place(x=500, y=450)

# Logo Industrial
logo2 = ImageTk.PhotoImage(Image.open(path2))
panel2 = tkinter.Label(root, image = logo2)
panel2.place(x=50, y=300)

root.mainloop()
