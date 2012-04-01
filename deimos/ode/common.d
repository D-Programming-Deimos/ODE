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

module deimos.ode.common;

public import deimos.ode.odeconfig;
public import deimos.ode.error;

private import std.math;

extern (C):
nothrow:

version(dSINGLE)
    alias float dReal;
else
    alias double dReal;

alias PI M_PI;
alias SQRT1_2 M_SQRT1_2;

version (dTRIMESH_16BIT_INDICIES)
{
    version (dTRIMESH_GIMPACT)
        alias uint32 dTriIndex;
    else
        alias uint16 dTriIndex;
}
else
    alias uint32 dTriIndex;

/* round an integer up to a multiple of 4, except that 0 and 1 are unmodified
 * (used to compute matrix leading dimensions)
 */
int dPAD(int a)
{
    return (a > 1) ? (((a - 1)|3)+1) : a;
}

/* these types are mainly just used in headers */
alias dReal[4]   dVector3;
alias dReal[4]   dVector4;
alias dReal[4*3] dMatrix3;
alias dReal[4*4] dMatrix4;
alias dReal[8*6] dMatrix6;
alias dReal[4]   dQuaternion;

dReal dRecip(dReal x)
{
    return 1.0/x;
}

dReal dRecipSqrt(dReal x)
{
    return 1.0/sqrt(x);
}

dReal dFMod(dReal a, dReal b)
{
    real c;
    return modf(a, c);
}

alias sqrt dSqrt;
alias sin dSin;
alias cos dCos;
alias fabs dFabs;
alias atan2 dAtan2;
alias isnan dIsNan;
alias copysign dCopySign;
alias floor dFloor;
alias ceil dCeil;
alias nextafter dNextAfter;

/* internal object types (all prefixed with `dx') */

struct dxWorld;        /* dynamics world */
struct dxSpace;        /* collision space */
struct dxBody;        /* rigid body (dynamics object) */
struct dxGeom;        /* geometry (collision object) */
struct dxJoint;
struct dxJointNode;
struct dxJointGroup;
struct dxWorldProcessThreadingManager;

alias dxWorld* dWorldID;
alias dxSpace* dSpaceID;
alias dxBody* dBodyID;
alias dxGeom* dGeomID;
alias dxJoint* dJointID;
alias dxJointGroup* dJointGroupID;
alias dxWorldProcessThreadingManager* dWorldStepThreadingManagerId;

/* error numbers */

enum
{
    d_ERR_UNKNOWN = 0, /* unknown error */
    d_ERR_IASSERT,     /* internal assertion failed */
    d_ERR_UASSERT,     /* user assertion failed */
    d_ERR_LCP          /* user assertion failed */
}


/* joint type numbers */

alias int dJointType;
enum
{
    dJointTypeNone = 0, /* or "unknown" */
    dJointTypeBall,
    dJointTypeHinge,
    dJointTypeSlider,
    dJointTypeContact,
    dJointTypeUniversal,
    dJointTypeHinge2,
    dJointTypeFixed,
    dJointTypeNull,
    dJointTypeAMotor,
    dJointTypeLMotor,
    dJointTypePlane2D,
    dJointTypePR,
    dJointTypePU,
    dJointTypePiston,
}

/* an alternative way of setting joint parameters, using joint parameter
 * structures and member constants. we don't actually do this yet.
 */

/*
typedef struct dLimot {
  int mode;
  dReal lostop, histop;
  dReal vel, fmax;
  dReal fudge_factor;
  dReal bounce, soft;
  dReal suspension_erp, suspension_cfm;
} dLimot;

enum {
  dLimotLoStop        = 0x0001,
  dLimotHiStop        = 0x0002,
  dLimotVel        = 0x0004,
  dLimotFMax        = 0x0008,
  dLimotFudgeFactor    = 0x0010,
  dLimotBounce        = 0x0020,
  dLimotSoft        = 0x0040
};
*/

/* standard joint parameter names */

enum
{
    /* parameters for limits and motors */
    dParamLoStop = 0,
    dParamHiStop,
    dParamVel,
    dParamFMax,
    dParamFudgeFactor,
    dParamBounce,
    dParamCFM,
    dParamStopERP,
    dParamStopCFM,
    /* parameters for suspension */
    dParamSuspensionERP,
    dParamSuspensionCFM,
    dParamERP,
    dParamsInGroup,
    /* parameters for limits and motors */
    dParamLoStop1 = 0x000,
    dParamHiStop1,
    dParamVel1,
    dParamFMax1,
    dParamFudgeFactor1,
    dParamBounce1,
    dParamCFM1,
    dParamStopERP1,
    dParamStopCFM1,
    /* parameters for suspension */
    dParamSuspensionERP1,
    dParamSuspensionCFM1,
    dParamERP1,
    /* parameters for limits and motors */
    dParamLoStop2 = 0x100,
    dParamHiStop2,
    dParamVel2,
    dParamFMax2,
    dParamFudgeFactor2,
    dParamBounce2,
    dParamCFM2,
    dParamStopERP2,
    dParamStopCFM2,
    /* parameters for suspension */
    dParamSuspensionERP2,
    dParamSuspensionCFM2,
    dParamERP2,
    /* parameters for limits and motors */
    dParamLoStop3 = 0x200,
    dParamHiStop3,
    dParamVel3,
    dParamFMax3,
    dParamFudgeFactor3,
    dParamBounce3,
    dParamCFM3,
    dParamStopERP3,
    dParamStopCFM3,
    /* parameters for suspension */
    dParamSuspensionERP3,
    dParamSuspensionCFM3,
    dParamERP3,
    dParamGroup = 0x100
}

/* angular motor mode numbers */

enum
{
    dAMotorUser  = 0,
    dAMotorEuler = 1,
}

/* joint force feedback information */

struct dJointFeedback
{
    dVector3 f1; /* force applied to body 1 */
    dVector3 t1; /* torque applied to body 1 */
    dVector3 f2; /* force applied to body 2 */
    dVector3 t2; /* torque applied to body 2 */
}

/* private functions that must be implemented by the collision library:
 * (1) indicate that a geom has moved, (2) get the next geom in a body list.
 * these functions are called whenever the position of geoms connected to a
 * body have changed, e.g. with dBodySetPosition(), dBodySetRotation(), or
 * when the ODE step function updates the body state.
 */

void    dGeomMoved       (dGeomID);
dGeomID dGeomGetBodyNext (dGeomID);

/**
 * dGetConfiguration returns the specific ODE build configuration as
 * a string of tokens. The string can be parsed in a similar way to
 * the OpenGL extension mechanism, the naming convention should be
 * familiar too. The following extensions are reported:
 *
 * ODE
 * ODE_single_precision
 * ODE_double_precision
 * ODE_EXT_no_debug
 * ODE_EXT_trimesh
 * ODE_EXT_opcode
 * ODE_EXT_gimpact
 * ODE_EXT_malloc_not_alloca
 * ODE_EXT_gyroscopic
 * ODE_OPC_16bit_indices
 * ODE_OPC_new_collider
*/
const(char)* dGetConfiguration();

/**
 * Helper to check for a token in the ODE configuration string.
 * Caution, this function is case sensitive.
 *
 * @param token A configuration token, see dGetConfiguration for details
 *
 * @return 1 if exact token is present, 0 if not present
 */
int dCheckConfiguration(const(char)* token);
