# SPW_INT_MASK

```c
typedef enum
{
    SPW_INT_MASK_NONE = 0,
    SPW_INT_MASK_PKTRX1 = ( 1 << 0),
    SPW_INT_MASK_PKTTX1 = ( 1 << 1),
    SPW_INT_MASK_TCH = ( 1 << 2),
    SPW_INT_MASK_LINK2 = ( 1 << 3),
    SPW_INT_MASK_DIA2 = ( 1 << 4),
    SPW_INT_MASK_DI2 = ( 1 << 5),
    SPW_INT_MASK_LINK1 = ( 1 << 6),
    SPW_INT_MASK_DIA1 = ( 1 << 7),
    SPW_INT_MASK_DI1 = ( 1 << 8),
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_INT_MASK_INVALID = 0xFFFFFFFF
} SPW_INT_MASK;
```

**Summary**

Identifies the SPW IRQ lines that have pending interrupt

**Description**

This data type identifies the SPW IRQ lines that have pending interrupt
