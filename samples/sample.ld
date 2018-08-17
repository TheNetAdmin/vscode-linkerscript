
OUTPUT_FORMAT("elf32-tradlittlemips",
              "elf32-tradbigmips",
              "elf32-tradlittlemips")
OUTPUT_ARCH(mips)

PHDRS
{
	phdrname PT_NULL;
	phdrname PT_NULL AT(addr);
	phdrname PT_NULL AT(addr) FLAGS(flags);
	phdrname PT_NULL FILEHDR AT(addr) FLAGS(flags);
	phdrname PT_NULL FILEHDR PHDRS AT(addr) FLAGS(flags);
}

MEMORY
{
    RAM   (RWX)  : o = 0x80100000, l = 0x00700000
    ROM   (!RX)  : org = 0xbfc00000, len = 0x00400000
    STACK (RWl)  : ORIGIN = 0x80800000, LENGTH = 0x00800000
}

ENTRY(boot_entry)

INPUT(file, file)

SECTIONS
{
    _rom_start = ORIGIN(ROM);
    _ram_start = ORIGIN(RAM);

    /*
     * Bootloader init code
     * Load & Run at ROM
     */
    .text_init :
    {
        _ftext_init = ABSOLUTE(.);
        
        start.o(.text)
        preboot.o(.text)
        [A-Z]*(.data)
        . = ALIGN(8);

        BYTE(1)
        LONG(addr)

        _etext_init = ABSOLUTE(.);
    } >ROM =0
    _text_init_size = SIZEOF(.text_init);
    
    /*
     * Main part of bootloader code
     * Load & Run at ROM
     */
    .text 0x1234 :
    {
        _ftext = ABSOLUTE(.);
        *(.text)
        *(.text.*)
        . = ALIGN(8);
        _etext = ABSOLUTE(.);
    } >ROM =0
    _text_size = SIZEOF(.text);

    /*
     * Read-only data
     * Load & Run at ROM
     */
    .rodata 0x1234 (attribute) :
    {
        _frodata = ABSOLUTE(.);
        *(.rodata)
        *(.rodata.*)
        . = ALIGN(8);
        _erodata = ABSOLUTE(.);
    } >ROM =0
    _rodata_size = SIZEOF(.rodata);


    /*
     * Initialized data
     * Load at ROM
     * Run  at RAM
     */
    .data 0x1234 (attribute) : AT(addr)
    {
        _fdata = ABSOLUTE(.);
        *(.data)
        . = ALIGN(8);
        _gp = ABSOLUTE(. + 0x7ff0);
        *(.lit8)
        *(.lit4)
        *(.sdata .sdata2)
        . = ALIGN(8);
        _edata = ABSOLUTE(.);
    } >RAM AT>ROM :phdr2 :phdr3 =0
    _ram_fdata = ADDR(.data);
    _rom_fdata = LOADADDR(.data);
    _data_size = SIZEOF(.data);

    /*
     * Uninitialized data
     * Load at ROM
     * Run  at RAM
     */
    .bss 0x1234 (attribute) :
        AT(addr)
    {
        _fbss = .;
        *(.sbss)
        *(.scommon)
        *(.bss)
        *(COMMON)
        . = ALIGN(8);
        _ebss = .;
    } >RAM AT>ROM =0
    _ram_fbss = ADDR(.bss);
    _rom_fbss = LOADADDR(.bss);
    _bss_size = SIZEOF(.bss);

    _stack_top = ORIGIN(STACK) + LENGTH(STACK);
    _stack_limit = LENGTH(STACK);

    PROVIDE(_reg_sp = _stack_top);
    PROVIDE(_reg_gp = _gp);

    /DISCARD/ :
    {
        *(.MIPS.abiflags)
    }
}