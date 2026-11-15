
# obsluha displaya ST7735 cez socket

import socket
import threading
import pygame
import sys

# Nastavenie rozmerov displeja ST7735 (štandardne 128x160 alebo 128x128)
WIDTH, HEIGHT = 128, 160

# Inicializácia Pygame okna
pygame.init()
screen = pygame.display.set_surface(pygame.display.set_mode((WIDTH, HEIGHT)))
pygame.display.set_caption("ST7735 SPI Displej")

# Interný buffer pre pixely (RGB displeja)
pixel_buffer = pygame.PixelArray(screen)

# Globálne premenné pre stav ST7735 radiča
current_command = 0
dc_mode = 0  # 0 = Command, 1 = Data

# Súradnice kreslenia (ST7735 adresné okno)
xs, xe, ys, ye = 0, WIDTH-1, 0, HEIGHT-1
curr_x, curr_y = 0, 0

def spracuj_st7735_data(payload):
    global current_command, xs, xe, ys, ye, curr_x, curr_y
    
    is_data = payload[0] == 0x01
    data_bytes = payload[1:]
    
    if not is_data:
        # Zmena príkazu – ST7735 spracováva zvyčajne 1 bajt príkazu
        if len(data_bytes) > 0:
            current_command = data_bytes[0]
            # Reset pozície pri príkaze na zápis do RAM (0x2C)
            if current_command == 0x2C:
                curr_x, curr_y = xs, ys
    else:
        # Spracovanie dát na základe aktívneho príkazu
        if current_command == 0x2A: # Column Address Set
            if len(data_bytes) >= 4:
                xs = (data_bytes[0] << 8) | data_bytes[1]
                xe = (data_bytes[2] << 8) | data_bytes[3]
        
        elif current_command == 0x2B: # Row Address Set
            if len(data_bytes) >= 4:
                ys = (data_bytes[0] << 8) | data_bytes[1]
                ye = (data_bytes[2] << 8) | data_bytes[3]
                
        elif current_command == 0x2C: # Memory Write (Dáta pixelov)
            # Každý pixel má 2 bajty (RGB565 format)
            for i in range(0, len(data_bytes), 2):
                if i + 1 < len(data_bytes):
                    b1 = data_bytes[i]
                    b2 = data_bytes[i+1]
                    raw_color = (b1 << 8) | b2
                    
                    # Konverzia z RGB565 (16-bit) do RGB888 (24-bit) pre Pygame
                    r = ((raw_color >> 11) & 0x1F) * 255 // 31
                    g = ((raw_color >> 5) & 0x3F) * 255 // 63
                    b = (raw_color & 0x1F) * 255 // 31
                    
                    # Zápis pixelu do okna (v rámci nastavených hraníc)
                    if 0 <= curr_x < WIDTH and 0 <= curr_y < HEIGHT:
                        pixel_buffer[curr_x, curr_y] = (r, g, b)
                    
                    # Posun súradníc (ST7735 auto-increment)
                    curr_x += 1
                    if curr_x > xe:
                        curr_x = xs
                        curr_y += 1
                        if curr_y > ye:
                            curr_y = ys

def udp_listener():
    udp_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    udp_socket.bind(('127.0.0.1', 5006))
    
    # Zväčšíme buffer pre socket, keďže z SPI tečie veľa dát naraz
    udp_socket.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 65536)
    
    while True:
        try:
            data, _ = udp_socket.recvfrom(4096)
            if data:
                spracuj_st7735_data(data)
        except Exception as e:
            print(f"Chyba prijmu: {e}")

# Spustenie sieťového vlákna
threading.Thread(target=udp_listener, daemon=True).start()

# Hlavná Pygame slučka na prekresľovanie okna (60 FPS)
clock = pygame.time.Clock()
while True:
    for event in pygame.get_event_loop():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
            
    # Obnovenie okna na obrazovku
    pygame.display.flip()
    clock.tick(60)
