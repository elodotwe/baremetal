.code16
.global init

init:
mov $0, %ah # set video mode
mov $0x12, %al # graphics, 800x600 (color text doesn't work in text mode)
int $0x10

mov $0x0e, %ah # type text to screen ("teletype")
mov $0, %bh    # page number
mov $msg, %si # si = address of msg

printChar:
lodsb # load data at si into al, increment si
      # al is the character to be printed
cmp $0, %al # msg is null terminated, bail if we find the null
je end

mov %al, %bl  # do interesting things with the color based on the character value
int $0x10
jmp printChar

end:
# hang in infinite loop here
jmp end

msg: .asciz "Hello world!"

.fill 510-(.-init), 1, 0
.word 0xaa55
