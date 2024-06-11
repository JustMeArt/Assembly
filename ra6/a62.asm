.data
str1: .asciiz "Lager"
str2: .asciiz "Regal"
str3: .space 10

.text
.globl main
j main
# Funktion: strturnaround
# Eingabe: $a0 = Adresse des C-Strings
strturnaround:
    # Finde das Ende des Strings
    move $t0, $a0          # $t0 wird die Adresse des Endes des Strings speichern
    loop_find_end:
        lb $t1, 0($t0)     # Lade das aktuelle Zeichen in $t1
        beq $t1, $zero, found_end  # Wenn es das Null-Zeichen ist, beende die Schleife
        addi $t0, $t0, 1   # Inkrementiere die Adresse
        j loop_find_end

    found_end:
        sub $t0, $t0, 1    # Gehe eine Position zurück, um das letzte Zeichen zu erhalten

    # Revertiere den String
    move $t2, $a0          # $t2 wird den Anfang des Strings speichern
    reverse_loop:
        bge $t2, $t0, done  # Wenn $t2 >= $t0, sind wir fertig
        lb $t3, 0($t2)     # Lade das Zeichen am Anfang
        lb $t4, 0($t0)     # Lade das Zeichen am Ende
        sb $t3, 0($t0)     # Speichere das Zeichen am Anfang ans Ende
        sb $t4, 0($t2)     # Speichere das Zeichen am Ende an den Anfang
        addi $t2, $t2, 1   # Bewege Anfang nach rechts
        subi $t0, $t0, 1   # Bewege Ende nach links
        j reverse_loop     # Wiederhole die Schleife

    done:
        jr $ra             # Rückkehr zur aufrufenden Funktion

main:
    # strturnaround(str1)
    la $a0, str1           # Lade Adresse von str1 in $a0
    jal strturnaround      # Rufe strturnaround auf

    # strturnaround(str2)
    la $a0, str2           # Lade Adresse von str2 in $a0
    jal strturnaround      # Rufe strturnaround auf

    # Beende das Programm
    li $v0, 10             # Syscall für Programmende
    syscall
