ENTRY(_start)

MEMORY
{
    RAM : ORIGIN = 0x10000, LENGTH = 0x10000
}

SECTIONS
{
    .text : {
        *(.text)
    } > RAM
    
    .data : {
        *(.data)
    } > RAM
    
    . = ALIGN(4);
    _end = .;
}
