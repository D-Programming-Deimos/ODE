/*************************************************************************
 *                          D bindings for ODE                           *
 *                                                                       *
 *       C header port by Daniel "q66" Kolesa <quaker66@gmail.com>       *
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * This library is free software; you can redistribute it and/or         *
 * modify it under the terms of EITHER:                                  *
 *   (1) The GNU Lesser General Public License as published by the Free  *
 *       Software Foundation; either version 2.1 of the License, or (at  *
 *       your option) any later version. The text of the GNU Lesser      *
 *       General Public License is included with this library in the     *
 *       file LICENSE.TXT.                                               *
 *   (2) The BSD-style license that is included with this library in     *
 *       the file LICENSE-BSD.TXT.                                       *
 *                                                                       *
 * This library is distributed in the hope that it will be useful,       *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
 * LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
 *                                                                       *
 *************************************************************************/

module deimos.ode.odemath;

private import deimos.ode.common;

/*
 * macro to access elements i,j in an NxM matrix A, independent of the
 * matrix storage convention.
 */
auto dACCESS33(T)(T a, size_t i, size_t j)
{
    return a[i * 4 + j];
}

/*
 * Macro to test for valid floating point values
 */
bool dVALIDVEC3(T)(T v)
{
    return !(dIsNan(v[0]) || dIsNan(v[1]) || dIsNan(v[2]));
}

bool dVALIDVEC4(T)(T v)
{
    return !(dIsNan(v[0]) || dIsNan(v[1]) || dIsNan(v[2]) || dIsNan(v[3]));
}

bool dVALIDMAT3(T)(T m)
{
    return !(
        dIsNan(m[0]) || dIsNan(m[1]) || dIsNan(m[2])  || dIsNan(m[3]) ||
        dIsNan(m[4]) || dIsNan(m[5]) || dIsNan(m[6])  || dIsNan(m[7]) ||
        dIsNan(m[8]) || dIsNan(m[9]) || dIsNan(m[10]) || dIsNan(m[11])
    );
}

bool dVALIDMAT4(T)(T m)
{
    return !(
        dIsNan(m[0])  || dIsNan(m[1])  || dIsNan(m[2])  || dIsNan(m[3])  ||
        dIsNan(m[4])  || dIsNan(m[5])  || dIsNan(m[6])  || dIsNan(m[7])  ||
        dIsNan(m[8])  || dIsNan(m[9])  || dIsNan(m[10]) || dIsNan(m[11]) ||
        dIsNan(m[12]) || dIsNan(m[13]) || dIsNan(m[14]) || dIsNan(m[15])
    );
}

// Some vector math
void dAddVectors3(dReal* res, in dReal* a, in dReal* b)
{
    dReal res_0, res_1, res_2;
    res_0 = a[0] + b[0];
    res_1 = a[1] + b[1];
    res_2 = a[2] + b[2];

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}


void dSubtractVectors3(dReal* res, in dReal* a, in dReal* b)
{
    dReal res_0, res_1, res_2;
    res_0 = a[0] - b[0];
    res_1 = a[1] - b[1];
    res_2 = a[2] - b[2];

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dAddScaledVectors3(dReal* res, in dReal* a, in dReal* b, dReal a_scale, dReal b_scale)
{
    dReal res_0, res_1, res_2;
    res_0 = a_scale * a[0] + b_scale * b[0];
    res_1 = a_scale * a[1] + b_scale * b[1];
    res_2 = a_scale * a[2] + b_scale * b[2];

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dScaleVector3(dReal* res, dReal nScale)
{
    res[0] *= nScale;
    res[1] *= nScale;
    res[2] *= nScale;
}

void dNegateVector3(dReal* res)
{
    res[0] = -res[0];
    res[1] = -res[1];
    res[2] = -res[2];
}

void dCopyVector3(dReal* res, in dReal* a)
{
    dReal res_0, res_1, res_2;
    res_0 = a[0];
    res_1 = a[1];
    res_2 = a[2];

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dCopyScaledVector3(dReal* res, in dReal* a, dReal nScale)
{
    dReal res_0, res_1, res_2;
    res_0 = a[0] * nScale;
    res_1 = a[1] * nScale;
    res_2 = a[2] * nScale;

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dCopyNegatedVector3(dReal* res, in dReal* a)
{
    dReal res_0, res_1, res_2;
    res_0 = -a[0];
    res_1 = -a[1];
    res_2 = -a[2];

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dCopyVector4(dReal* res, in dReal* a)
{
    dReal res_0, res_1, res_2, res_3;
    res_0 = a[0];
    res_1 = a[1];
    res_2 = a[2];
    res_3 = a[3];

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2; res[3] = res_3;
}

void dCopyMatrix4x4(dReal* res, in dReal* a)
{
    dCopyVector4(res + 0, a + 0);
    dCopyVector4(res + 4, a + 4);
    dCopyVector4(res + 8, a + 8);
}

void dCopyMatrix4x3(dReal* res, in dReal* a)
{
    dCopyVector3(res + 0, a + 0);
    dCopyVector3(res + 4, a + 4);
    dCopyVector3(res + 8, a + 8);
}

void dGetMatrixColumn3(dReal* res, in dReal* a, uint n)
{
    dReal res_0, res_1, res_2;
    res_0 = a[n + 0];
    res_1 = a[n + 4];
    res_2 = a[n + 8];

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

dReal dCalcVectorLength3(in dReal* a)
{
    return dSqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2]);
}

dReal dCalcVectorLengthSquare3(in dReal* a)
{
    return (a[0] * a[0] + a[1] * a[1] + a[2] * a[2]);
}

dReal dCalcPointDepth3(in dReal* test_p, in dReal* plane_p, in dReal* plane_n)
{
    return (plane_p[0] - test_p[0]) * plane_n[0] + (plane_p[1] - test_p[1]) * plane_n[1] + (plane_p[2] - test_p[2]) * plane_n[2];
}

/*
* 3-way dot product. _dCalcVectorDot3 means that elements of `a' and `b' are spaced
* step_a and step_b indexes apart respectively. dCalcVectorDot3() means dDot311.
*/
dReal _dCalcVectorDot3(in dReal* a, in dReal* b, uint step_a, uint step_b)
{
    return a[0] * b[0] + a[step_a] * b[step_b] + a[2 * step_a] * b[2 * step_b];
}

dReal dCalcVectorDot3    (in dReal* a, in dReal* b) { return _dCalcVectorDot3(a,b,1,1); }
dReal dCalcVectorDot3_13 (in dReal* a, in dReal* b) { return _dCalcVectorDot3(a,b,1,3); }
dReal dCalcVectorDot3_31 (in dReal* a, in dReal* b) { return _dCalcVectorDot3(a,b,3,1); }
dReal dCalcVectorDot3_33 (in dReal* a, in dReal* b) { return _dCalcVectorDot3(a,b,3,3); }
dReal dCalcVectorDot3_14 (in dReal* a, in dReal* b) { return _dCalcVectorDot3(a,b,1,4); }
dReal dCalcVectorDot3_41 (in dReal* a, in dReal* b) { return _dCalcVectorDot3(a,b,4,1); }
dReal dCalcVectorDot3_44 (in dReal* a, in dReal* b) { return _dCalcVectorDot3(a,b,4,4); }

/*
 * cross product, set res = a x b. _dCalcVectorCross3 means that elements of `res', `a'
 * and `b' are spaced step_res, step_a and step_b indexes apart respectively.
 * dCalcVectorCross3() means dCross3111. 
 */
void _dCalcVectorCross3(dReal* res, in dReal* a, in dReal* b, uint step_res, uint step_a, uint step_b)
{
    dReal res_0, res_1, res_2;
    res_0 = a[  step_a]*b[2*step_b] - a[2*step_a]*b[  step_b];
    res_1 = a[2*step_a]*b[       0] - a[       0]*b[2*step_b];
    res_2 = a[       0]*b[  step_b] - a[  step_a]*b[       0];

    res[         0] = res_0;
    res[  step_res] = res_1;
    res[2*step_res] = res_2;
}

void dCalcVectorCross3    (dReal* res, in dReal* a, in dReal* b) { _dCalcVectorCross3(res, a, b, 1, 1, 1); }
void dCalcVectorCross3_114(dReal* res, in dReal* a, in dReal* b) { _dCalcVectorCross3(res, a, b, 1, 1, 4); }
void dCalcVectorCross3_141(dReal* res, in dReal* a, in dReal* b) { _dCalcVectorCross3(res, a, b, 1, 4, 1); }
void dCalcVectorCross3_144(dReal* res, in dReal* a, in dReal* b) { _dCalcVectorCross3(res, a, b, 1, 4, 4); }
void dCalcVectorCross3_411(dReal* res, in dReal* a, in dReal* b) { _dCalcVectorCross3(res, a, b, 4, 1, 1); }
void dCalcVectorCross3_414(dReal* res, in dReal* a, in dReal* b) { _dCalcVectorCross3(res, a, b, 4, 1, 4); }
void dCalcVectorCross3_441(dReal* res, in dReal* a, in dReal* b) { _dCalcVectorCross3(res, a, b, 4, 4, 1); }
void dCalcVectorCross3_444(dReal* res, in dReal* a, in dReal* b) { _dCalcVectorCross3(res, a, b, 4, 4, 4); }

void dAddVectorCross3(dReal* res, in dReal* a, in dReal* b)
{
    dReal tmp[3];
    dCalcVectorCross3(tmp.ptr, a, b);
    dAddVectors3(res, res, tmp.ptr);
}

void dSubtractVectorCross3(dReal* res, in dReal* a, in dReal* b)
{
    dReal tmp[3];
    dCalcVectorCross3(tmp.ptr, a, b);
    dSubtractVectors3(res, res, tmp.ptr);
}

/*
 * set a 3x3 submatrix of A to a matrix such that submatrix(A)*b = a x b.
 * A is stored by rows, and has `skip' elements per row. the matrix is
 * assumed to be already zero, so this does not write zero elements!
 * if (plus,minus) is (+,-) then a positive version will be written.
 * if (plus,minus) is (-,+) then a negative version will be written.
 */
void dSetCrossMatrixPlus(dReal* res, in dReal* a, uint skip)
{
    const dReal a_0 = a[0], a_1 = a[1], a_2 = a[2];
    res[1] = -a_2;
    res[2] = +a_1;
    res[skip+0] = +a_2;
    res[skip+2] = -a_0;
    res[2*skip+0] = -a_1;
    res[2*skip+1] = +a_0;
}

void dSetCrossMatrixMinus(dReal* res, in dReal* a, uint skip)
{
    const dReal a_0 = a[0], a_1 = a[1], a_2 = a[2];
    res[1] = +a_2;
    res[2] = -a_1;
    res[skip+0] = -a_2;
    res[skip+2] = +a_0;
    res[2*skip+0] = +a_1;
    res[2*skip+1] = -a_0;
}

/*
 * compute the distance between two 3D-vectors
 */
dReal dCalcPointsDistance3(in dReal* a, in dReal* b)
{
    dReal res;
    dReal tmp[3];
    dSubtractVectors3(tmp.ptr, a, b);
    res = dCalcVectorLength3(tmp.ptr);
    return res;
}

/*
 * special case matrix multiplication, with operator selection
 */
void dMultiplyHelper0_331(dReal* res, in dReal* a, in dReal* b)
{
    dReal res_0, res_1, res_2;
    res_0 = dCalcVectorDot3(a, b);
    res_1 = dCalcVectorDot3(a + 4, b);
    res_2 = dCalcVectorDot3(a + 8, b);

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dMultiplyHelper1_331(dReal* res, in dReal* a, in dReal* b)
{
    dReal res_0, res_1, res_2;
    res_0 = dCalcVectorDot3_41(a, b);
    res_1 = dCalcVectorDot3_41(a + 1, b);
    res_2 = dCalcVectorDot3_41(a + 2, b);

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

void dMultiplyHelper0_133(dReal* res, in dReal* a, in dReal* b)
{
    dMultiplyHelper1_331(res, b, a);
}

void dMultiplyHelper1_133(dReal* res, in dReal* a, in dReal* b)
{
    dReal res_0, res_1, res_2;
    res_0 = dCalcVectorDot3_44(a, b);
    res_1 = dCalcVectorDot3_44(a + 1, b);
    res_2 = dCalcVectorDot3_44(a + 2, b);

    // Only assign after all the calculations are over to avoid incurring memory aliasing
    res[0] = res_0; res[1] = res_1; res[2] = res_2;
}

/* 
Note: NEVER call any of these functions/macros with the same variable for A and C, 
it is not equivalent to A*=B.
*/
void dMultiply0_331(dReal* res, in dReal* a, in dReal* b)
{
    dMultiplyHelper0_331(res, a, b);
}

void dMultiply1_331(dReal* res, in dReal* a, in dReal* b)
{
    dMultiplyHelper1_331(res, a, b);
}

void dMultiply0_133(dReal* res, in dReal* a, in dReal* b)
{
    dMultiplyHelper0_133(res, a, b);
}

void dMultiply0_333(dReal* res, in dReal* a, in dReal* b)
{
    dMultiplyHelper0_133(res + 0, a + 0, b);
    dMultiplyHelper0_133(res + 4, a + 4, b);
    dMultiplyHelper0_133(res + 8, a + 8, b);
}

void dMultiply1_333(dReal* res, in dReal* a, in dReal* b)
{
    dMultiplyHelper1_133(res + 0, b, a + 0);
    dMultiplyHelper1_133(res + 4, b, a + 1);
    dMultiplyHelper1_133(res + 8, b, a + 2);
}

void dMultiply2_333(dReal* res, in dReal* a, in dReal* b)
{
    dMultiplyHelper0_331(res + 0, b, a + 0);
    dMultiplyHelper0_331(res + 4, b, a + 4);
    dMultiplyHelper0_331(res + 8, b, a + 8);
}

void dMultiplyAdd0_331(dReal* res, in dReal* a, in dReal* b)
{
    dReal tmp[3];
    dMultiplyHelper0_331(tmp.ptr, a, b);
    dAddVectors3(res, res, tmp.ptr);
}

void dMultiplyAdd1_331(dReal* res, in dReal* a, in dReal* b)
{
    dReal tmp[3];
    dMultiplyHelper1_331(tmp.ptr, a, b);
    dAddVectors3(res, res, tmp.ptr);
}

void dMultiplyAdd0_133(dReal* res, in dReal* a, in dReal* b)
{
    dReal tmp[3];
    dMultiplyHelper0_133(tmp.ptr, a, b);
    dAddVectors3(res, res, tmp.ptr);
}

void dMultiplyAdd0_333(dReal* res, in dReal* a, in dReal* b)
{
    dReal tmp[3];
    dMultiplyHelper0_133(tmp.ptr, a + 0, b);
    dAddVectors3(res+ 0, res + 0, tmp.ptr);
    dMultiplyHelper0_133(tmp.ptr, a + 4, b);
    dAddVectors3(res + 4, res + 4, tmp.ptr);
    dMultiplyHelper0_133(tmp.ptr, a + 8, b);
    dAddVectors3(res + 8, res + 8, tmp.ptr);
}

void dMultiplyAdd1_333(dReal* res, in dReal* a, in dReal* b)
{
    dReal tmp[3];
    dMultiplyHelper1_133(tmp.ptr, b, a + 0);
    dAddVectors3(res + 0, res + 0, tmp.ptr);
    dMultiplyHelper1_133(tmp.ptr, b, a + 1);
    dAddVectors3(res + 4, res + 4, tmp.ptr);
    dMultiplyHelper1_133(tmp.ptr, b, a + 2);
    dAddVectors3(res + 8, res + 8, tmp.ptr);
}

void dMultiplyAdd2_333(dReal* res, in dReal* a, in dReal* b)
{
    dReal tmp[3];
    dMultiplyHelper0_331(tmp.ptr, b, a + 0);
    dAddVectors3(res + 0, res + 0, tmp.ptr);
    dMultiplyHelper0_331(tmp.ptr, b, a + 4);
    dAddVectors3(res + 4, res + 4, tmp.ptr);
    dMultiplyHelper0_331(tmp.ptr, b, a + 8);
    dAddVectors3(res + 8, res + 8, tmp.ptr);
}

extern (C):
nothrow:

/*
 * normalize 3x1 and 4x1 vectors (i.e. scale them to unit length)
 */

// For DLL export
int  dSafeNormalize3(dVector3 a);
int  dSafeNormalize4(dVector4 a);
void dNormalize3(dVector3 a); // Potentially asserts on zero vec
void dNormalize4(dVector4 a); // Potentially asserts on zero vec

/*
 * given a unit length "normal" vector n, generate vectors p and q vectors
 * that are an orthonormal basis for the plane space perpendicular to n.
 * i.e. this makes p,q such that n,p,q are all perpendicular to each other.
 * q will equal n x p. if n is not unit length then p will be unit length but
 * q wont be.
 */

void dPlaneSpace(in dVector3 n, dVector3 p, dVector3 q);
/* Makes sure the matrix is a proper rotation */
void dOrthogonalizeR(dMatrix3 m);
