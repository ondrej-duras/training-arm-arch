#!/usr/bin/env python

import socket
import threading
import time

# Konstanty pre sieťové prepojenie
RENODE_IP = "127.0.0.1"
RENODE_COMMAND_PORT = 12345  # TCP port, kde Renode prijíma príkazy
PYTHON_RECEIVE_PORT = 5005   # UDP port, kam Renode posiela stav GPIO (LED)

# --- 1. SMER VON: Funkcia, ktorá počúva udalosti z Renode (zmeny LED) ---
def pocivaj_renode_udalosti():
    udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    udp_socket.bind((RENODE_IP, PYTHON_RECEIVE_PORT))
    
    print(f"[*] Python počúva na UDP porte {PYTHON_RECEIVE_PORT} a čaká na zmeny LED...")
    
    while True:
        data, addr = udp_socket.recvfrom(1024)
        sprava = data.decode('utf-8').strip()
        
        # Tu spracuješ prijatú správu
        if sprava == "LED:1":
            print("\n[VIZUALIZÁCIA] 🔴 LED svieti (HIGH)")
        elif sprava == "LED:0":
            print("\n[VIZUALIZÁCIA] ⚫ LED nesvieti (LOW)")
        
        # Znova vypíšeme prompt pre zadávanie vstupu, aby to vyzeralo úhľadne
        print("Stlač gombík (1 = Stlač A, 0 = Pusti A, 2 = Stlač B, 3 = Pusti B): ", end="", flush=True)

# --- 2. SMER DNU: Pomocná funkcia na odoslanie príkazu do Renode ---
def posli_prikaz_do_renode(prikaz):
    try:
        tcp_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        tcp_socket.connect((RENODE_IP, RENODE_COMMAND_PORT))
        
        # Renode Monitor očakáva príkaz zakončený novým riadkom \n
        tcp_socket.sendall(f"{prikaz}\n".encode('utf-8'))
        tcp_socket.close()
    except ConnectionRefusedError:
        print("\n[CHYBA] Nepodarilo sa pripojiť k Renode. Beží ti emulácia a príkaz CreateServer?")

# --- HLAVNÝ BEH PROGRAMU ---
if __name__ == "__main__":
    print("=== Vizualizačný most pre Renode spustený ===")
    
    # Spustíme počúvanie LED na pozadí (v samostatnom vlákne), aby neblokovalo klávesnicu
    vladno_prijmu = threading.Thread(target=pocivaj_renode_udalosti, daemon=True)
    vladno_prijmu.start()
    
    # Krátka pauza na inicializáciu textového rozhrania
    time.sleep(0.5)

    # Hlavná slučka pre tvoj vstup (simulácia stláčania gombíkov)
    while True:
        vstup = input("Stlač gombík (1 = Stlač A, 0 = Pusti A, 2 = Stlač B, 3 = Pusti B): ").strip()
        
        if vstup == "1":
            print("[POSIELAM] Stláčam Gombík A (Pin 17 -> LOW)...")
            # Tlačidlá na micro:bit bývajú invertované (stlačené = False/Low), pre istotu posielame priamy stav
            posli_prikaz_do_renode("sysbus.gpio0.pin17 State False")
            
        elif vstup == "0":
            print("[POSIELAM] Púšťam Gombík A (Pin 17 -> HIGH)...")
            posli_prikaz_do_renode("sysbus.gpio0.pin17 State True")
            
        elif vstup == "2":
            print("[POSIELAM] Stláčam Gombík B (Pin 14 -> LOW)...")
            posli_prikaz_do_renode("sysbus.gpio0.pin14 State False")
            
        elif vstup == "3":
            print("[POSIELAM] Púšťam Gombík B (Pin 14 -> HIGH)...")
            posli_prikaz_do_renode("sysbus.gpio0.pin14 State True")
            
        else:
            print("[!] Neznámy príkaz. Použi 1, 0, 2 alebo 3.")
