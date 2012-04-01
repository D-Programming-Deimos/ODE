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

module deimos.ode.mass;

private import deimos.ode.common;

extern (C):
nothrow:

/**
 * Check if a mass structure has valid value.
 * The function check if the mass and innertia matrix are positive definits
 *
 * @param m A mass structure to check
 *
 * @return 1 if both codition are met
 */
int dMassCheck(in dMass *m);

void dMassSetZero(dMass*);

void dMassSetParameters(
    dMass*, dReal themass, dReal cgx, dReal cgy, dReal cgz, dReal I11,
    dReal I22, dReal I33, dReal I12, dReal I13, dReal I23
);

void dMassSetSphere(dMass*, dReal density, dReal radius);
void dMassSetSphereTotal(dMass*, dReal total_mass, dReal radius);

void dMassSetCapsule(
    dMass*, dReal density, int direction, dReal radius, dReal length
);
void dMassSetCapsuleTotal(
    dMass*, dReal total_mass, int direction, dReal radius, dReal length
);

void dMassSetCylinder(
    dMass*, dReal density, int direction, dReal radius, dReal length
);
void dMassSetCylinderTotal(
    dMass*, dReal total_mass, int direction, dReal radius, dReal length
);

void dMassSetBox(dMass*, dReal density, dReal lx, dReal ly, dReal lz);
void dMassSetBoxTotal(dMass*, dReal total_mass, dReal lx, dReal ly, dReal lz);

void dMassSetTrimesh(dMass*, dReal density, dGeomID g);

void dMassSetTrimeshTotal(dMass* m, dReal total_mass, dGeomID g);

void dMassAdjust(dMass*, dReal newmass);

void dMassTranslate(dMass*, dReal x, dReal y, dReal z);

void dMassRotate(dMass*, in dMatrix3 R);

void dMassAdd(dMass* a, in dMass* b);

struct dMass
{
    dReal mass;
    dVector3 c;
    dMatrix3 I;
}
