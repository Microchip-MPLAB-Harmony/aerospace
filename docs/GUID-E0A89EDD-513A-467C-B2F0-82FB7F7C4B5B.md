# SPW_LINK_INT_MASK

```c
typedef enum
{
    SPW_LINK_INT_MASK_DISERR = SPW_LINK1_PI_RM_DISERR_Msk,
    SPW_LINK_INT_MASK_PARERR = SPW_LINK1_PI_RM_PARERR_Msk,
    SPW_LINK_INT_MASK_ESCERR = SPW_LINK1_PI_RM_ESCERR_Msk,
    SPW_LINK_INT_MASK_CRERR = SPW_LINK1_PI_RM_CRERR_Msk,
    SPW_LINK_INT_MASK_LINKABORT = SPW_LINK1_PI_RM_LINKABORT_Msk,
    SPW_LINK_INT_MASK_EEPTRANS = SPW_LINK1_PI_RM_EEPTRANS_Msk,
    SPW_LINK_INT_MASK_EEPREC = SPW_LINK1_PI_RM_EEPREC_Msk,
    SPW_LINK_INT_MASK_DISCARD = SPW_LINK1_PI_RM_DISCARD_Msk,
    SPW_LINK_INT_MASK_ESCEVENT2 = SPW_LINK1_PI_RM_ESCEVENT2_Msk,
    SPW_LINK_INT_MASK_ESCEVENT1 = SPW_LINK1_PI_RM_ESCEVENT1_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_INT_MASK_INVALID = 0xFFFFFFFF
} SPW_LINK_INT_MASK;
```

**Summary**

Identifies the SPW LINK IRQ event that have pending interrupt

**Description**

This data type identifies the SPW LINK IRQ event that have pending interrupt
