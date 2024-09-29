[ORG 0x7C00]       ; Bootloader bude načten na tuto adresu
bits 16

jmp start          ; Skoč na začátek bootloaderu

start:
    ; Vytvoření textového řetězce
    mov si, msg   ; Načtení adresy zprávy do SI
    mov ah, 0x0E  ; Funkce pro tisk znaku (BIOS)

print_loop:
    lodsb          ; Načti byte ze SI do AL
    cmp al, 0      ; Zkontroluj, zda je konec řetězce
    je hang        ; Pokud ano, skákej do hang
    int 0x10      ; Zavolej BIOS interrupt pro tisk znaku
    jmp print_loop ; Pokračuj v cyklu

hang:
    jmp hang       ; Nekonečná smyčka

msg db 'Hello, World from Filip's OS!', 0 ; Zpráva, která se má zobrazit

times 510-($-$$) db 0 ; Vyplnění zbytku disku nulami
dw 0xAA55              ; Boot signatura
