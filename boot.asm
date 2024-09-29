[ORG 0x7C00]       ; Bootloader bude načten na adresu 0x7C00
bits 16            ; Pracujeme v 16bitovém režimu

start:
    mov si, msg     ; Načtení adresy zprávy do registru SI
    mov ah, 0x0E    ; BIOS funkce pro tisk znaku (int 0x10, funkce 0x0E)

print_loop:
    lodsb           ; Načti byte ze SI do AL (Load String Byte)
    cmp al, 0       ; Zkontroluj, zda je konec řetězce (0 značí konec)
    je hang         ; Pokud ano, skoč do nekonečné smyčky (hang)
    int 0x10        ; Volej BIOS přerušení pro tisk znaku
    jmp print_loop  ; Pokračuj ve smyčce, dokud nedojdeme na konec řetězce

hang:
    jmp hang        ; Nekonečná smyčka pro zastavení systému

msg db 'Hello, World from Filip''s OS!', 0  ; Textová zpráva k zobrazení

times 510-($-$$) db 0  ; Vyplň zbytek sektoru nulami (boot sektor má 512 bytů)
dw 0xAA55              ; Boot signatura (2 poslední bajty, aby BIOS rozpoznal boot sektor)
