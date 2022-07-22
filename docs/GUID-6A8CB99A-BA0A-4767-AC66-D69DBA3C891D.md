# IP1553_INT_MASK

```c
typedef enum
{
    IP1553_INT_MASK_EMT = IP1553_ISR_EMT_Msk,
    IP1553_INT_MASK_MTE = IP1553_ISR_MTE_Msk,
    IP1553_INT_MASK_ERX = IP1553_ISR_ERX_Msk,
    IP1553_INT_MASK_ETX = IP1553_ISR_ETX_Msk,
    IP1553_INT_MASK_ETRANS_MASK = IP1553_ISR_ETRANS_Msk,
    IP1553_INT_MASK_TE = IP1553_ISR_TE_Msk,
    IP1553_INT_MASK_TCE = IP1553_ISR_TCE_Msk,
    IP1553_INT_MASK_TPE = IP1553_ISR_TPE_Msk,
    IP1553_INT_MASK_TDE = IP1553_ISR_TDE_Msk,
    IP1553_INT_MASK_TTE = IP1553_ISR_TTE_Msk,
    IP1553_INT_MASK_TWE = IP1553_ISR_TWE_Msk,
    IP1553_INT_MASK_BE = IP1553_ISR_BE_Msk,
    IP1553_INT_MASK_ITR = IP1553_ISR_ITR_Msk,
    IP1553_INT_MASK_TVR = IP1553_ISR_TVR_Msk,
    IP1553_INT_MASK_DBR = IP1553_ISR_DBR_Msk,
    IP1553_INT_MASK_STR = IP1553_ISR_STR_Msk,
    IP1553_INT_MASK_TSR = IP1553_ISR_TSR_Msk,
    IP1553_INT_MASK_OSR = IP1553_ISR_OSR_Msk,
    IP1553_INT_MASK_SDR = IP1553_ISR_SDR_Msk,
    IP1553_INT_MASK_SWD = IP1553_ISR_SWD_Msk,
    IP1553_INT_MASK_RRT = IP1553_ISR_RRT_Msk,
    IP1553_INT_MASK_ITF = IP1553_ISR_ITF_Msk,
    IP1553_INT_MASK_OTF = IP1553_ISR_OTF_Msk,
    IP1553_INT_MASK_IPB = IP1553_ISR_IPB_Msk,
    IP1553_INT_MASK_ERROR_MASK = ( IP1553_INT_MASK_MTE |
                                   IP1553_INT_MASK_TE |
                                   IP1553_INT_MASK_TCE |
                                   IP1553_INT_MASK_TPE |
                                   IP1553_INT_MASK_TDE |
                                   IP1553_INT_MASK_TTE |
                                   IP1553_INT_MASK_TWE |
                                   IP1553_INT_MASK_BE |
                                   IP1553_INT_MASK_ITR ),
    /* Force the compiler to reserve 32-bit memory for enum */
    IP1553_INT_MASK_INVALID = 0xFFFFFFFF
} IP1553_INT_MASK;
```

**Summary**

Identifies the IP1553 current interrupt status

**Description**

This data type identifies the IP1553 interrupt status
