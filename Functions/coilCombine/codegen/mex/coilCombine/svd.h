/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * svd.h
 *
 * Code generation for function 'svd'
 *
 */

#pragma once

/* Include files */
#include "coilCombine_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void svd(const emlrtStack *sp, const emxArray_creal_T *A, emxArray_creal_T *U,
         emxArray_real_T *s, emxArray_creal_T *V);

/* End of code generation (svd.h) */
