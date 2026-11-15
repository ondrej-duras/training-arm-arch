### poznamky

2. Krok: Ako funguje LED matica na nRF52 (Teória pre tvoj assembler)

Na reálnom micro:bit v2 (aj na na¿om nRF52 emulátore) sú LED diódy zapojené v matici 5 riadkov a 5 st¿pcov.
Aby LEDka svietila, musí¿:
1. Nastavi¿ pin prislúchajúceho riadku na HIGH (1).
2. Nastavi¿ pin prislúchajúceho st¿pca na LOW (0).
V Renode nRF52840 profile sú piny pre micro:bit v2 maticu mapované vä¿¿inou nasledovne (vychádza zo schémy zapojenia):
¿ Riadky (Rows): P0.21, P0.22, P0.15, P0.24, P0.19
¿ St¿pce (Cols): P0.28, P0.11, P0.31, P1.05, P0.30
Poznámka: Ak v Renode webGUI neuvidí¿ hne¿ blika¿ maticu, skúsime najprv overi¿, ¿i Renode vníma stla¿enia tla¿idiel.
Tla¿idlá na micro:bit v2:
¿ Tla¿idlo A: GPIO Pin P0.14 (aktívna logická 0 - stla¿ené = LOW)
¿ Tla¿idlo B: GPIO Pin P0.23 (aktívna logická 0 - stla¿ené = LOW)

3. Krok: Jednoduchý kód pre overenie (main.s)

Napí¿me minimalistický kód, ktorý iba zinicializuje piny pre Tla¿idlo A (vstup) a jednu LED diódu (napr. Riadok 1 na P0.21 a St¿pec 1 na P0.28), a bude kopírova¿ stav tla¿idla na LED.
Základné adresy nRF52840 pre GPIO (GPIO0):
¿ GPIO0_BASE = 0x50000000
¿ OUT register = 0x50000504 (zápis na piny)
¿ IN register = 0x50000510 (¿ítanie z pinov)
¿ PIN_CNF[14] (Tla¿idlo A) = 0x50000738
¿ PIN_CNF[21] (Riadok 1) = 0x50000754
¿ PIN_CNF[28] (St¿pec 1) = 0x50000770
