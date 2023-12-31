local configFlags = {
	["AllowMedicsToAttend"] = 0,
	["0x24B45566"] = 1,
	["DontAllowToBeDraggedOutOfVehicle"] = 2,
	["GetOutUndriveableVehicle"] = 3,
	["HasBounty"] = 4,
	["WillFlyThroughWindscreen"] = 5,
	["DontInfluenceWantedLevel"] = 6,
	["DisableLockonToRandomPeds"] = 7,
	["AllowLockonToFriendlyPlayers"] = 8,
	["KilledByStealth"] = 9,
	["KilledByTakedown"] = 10,
	["Knockedout"] = 11,
	["IsAimingGun"] = 12,
	["ForcedAim"] = 13,
	["OpenDoorArmIK"] = 14,
	["DontActivateRagdollFromVehicleImpact"] = 15,
	["DontActivateRagdollFromBulletImpact"] = 16,
	["DontActivateRagdollFromExplosions"] = 17,
	["DontActivateRagdollFromFire"] = 18,
	["DontActivateRagdollFromElectrocution"] = 19,
	["KeepWeaponHolsteredUnlessFired"] = 20,
	["ForceControlledKnockout"] = 21,
	["FallsOutOfVehicleWhenKilled"] = 22,
	["GetOutBurningVehicle"] = 23,
	["RunFromFiresAndExplosions"] = 24,
	["TreatAsPlayerDuringTargeting"] = 25,
	["DisableMelee"] = 26,
	["DisableUnarmedDrivebys"] = 27,
	["JustGetsPulledOutWhenElectrocuted"] = 28,
	["DisableMeleeHitReactions"] = 29,
	["WillNotHotwireLawEnforcementVehicle"] = 30,
	["WillCommandeerRatherThanJack"] = 31,
	["ForcePedToFaceLeftInCover"] = 32,
	["ForcePedToFaceRightInCover"] = 33,
	["BlockPedFromTurningInCover"] = 34,
	["KeepRelationshipGroupAfterCleanUp"] = 35,
	["ForcePedToBeDragged"] = 36,
	["PreventPedFromReactingToBeingJacked"] = 37,
	["RemoveDeadExtraFarAway"] = 38,
	["ArrestResult"] = 39,
	["CanAttackFriendly"] = 40,
	["WillJackAnyPlayer"] = 41,
	["WillJackWantedPlayersRatherThanStealCar"] = 42,
	["DisableLadderClimbing"] = 43,
	["CowerInsteadOfFlee"] = 44,
	["CanActivateRagdollWhenVehicleUpsideDown"] = 45,
	["AlwaysRespondToCriesForHelp"] = 46,
	["DisableBloodPoolCreation"] = 47,
	["ShouldFixIfNoCollision"] = 48,
	["CanPerformArrest"] = 49,
	["CanPerformUncuff"] = 50,
	["CanBeArrested"] = 51,
	["PlayerPreferFrontSeatMP"] = 52,
	["DontEnterVehiclesInPlayersGroup"] = 53,
	["PreventAllMeleeTaunts"] = 54,
	["ForceDirectEntry"] = 55,
	["AlwaysSeeApproachingVehicles"] = 56,
	["CanDiveAwayFromApproachingVehicles"] = 57,
	["AllowPlayerToInterruptVehicleEntryExit"] = 58,
	["OnlyAttackLawIfPlayerIsWanted"] = 59,
	["PedsJackingMeDontGetIn"] = 60,
	["PedIgnoresAnimInterruptEvents"] = 61,
	["IsInCustody"] = 62,
	["ForceStandardBumpReactionThresholds"] = 63,
	["LawWillOnlyAttackIfPlayerIsWanted"] = 64,
	["PreventAutoShuffleToDriversSeat"] = 65,
	["UseKinematicModeWhenStationary"] = 66,
	["PlayerIsWeird"] = 67,
	["DoNothingWhenOnFootByDefault"] = 68,
	["DontReactivateRagdollOnPedCollisionWhenDead"] = 69,
	["DontActivateRagdollOnVehicleCollisionWhenDead"] = 70,
	["HasBeenInArmedCombat"] = 71,
	["Avoidance_Ignore_All"] = 72,
	["Avoidance_Ignored_by_All"] = 73,
	["Avoidance_Ignore_Group1"] = 74,
	["Avoidance_Member_of_Group1"] = 75,
	["ForcedToUseSpecificGroupSeatIndex"] = 76,
	["DisableExplosionReactions"] = 77,
	["WaitingForPlayerControlInterrupt"] = 78,
	["ForcedToStayInCover"] = 79,
	["GeneratesSoundEvents"] = 80,
	["0x5BE341F1"] = 81, -- PCF_[K-L]*
	["AllowToBeTargetedInAVehicle"] = 82,
	["WaitForDirectEntryPointToBeFreeWhenExiting"] = 83,
	["OnlyRequireOnePressToExitVehicle"] = 84,
	["ForceExitToSkyDive"] = 85,
	["DisableExitToSkyDive"] = 86,
	["DisablePedAvoidance"] = 87,
	["0x4BF2D721"] = 88,
	["DisablePanicInVehicle"] = 89,
	["AllowedToDetachTrailer"] = 90,
	["ForceSkinCharacterCloth"] = 91,
	["LeaveEngineOnWhenExitingVehicles"] = 92,
	["PhoneDisableTextingAnimations"] = 93,
	["PhoneDisableTalkingAnimations"] = 94,
	["PhoneDisableCameraAnimations"] = 95,
	["DisableBlindFiringInShotReactions"] = 96,
	["AllowNearbyCoverUsage"] = 97,
	["CanAttackNonWantedPlayerAsLaw"] = 98,
	["WillTakeDamageWhenVehicleCrashes"] = 99,
	["AICanDrivePlayerAsRearPassenger"] = 100,
	["PlayerCanJackFriendlyPlayers"] = 101,
	["AIDriverAllowFriendlyPassengerSeatEntry"] = 102,
	["AllowMissionPedToUseInjuredMovement"] = 103,
	["PreventUsingLowerPrioritySeats"] = 104,
	["TeleportToLeaderVehicle"] = 105,
	["Avoidance_Ignore_WeirdPedBuffer"] = 106,
	["DontBlipCop"] = 107,
	["KillWhenTrapped"] = 108,
	["AvoidTearGas"] = 109,
	["OnlyUseForcedSeatWhenEnteringHeliInGroup"] = 110,
	["DisableWeirdPedEvents"] = 111,
	["ShouldChargeNow"] = 112,
	["DisableShockingEvents"] = 113,
	["0x38D6E079"] = 114,
	["DisableShockingDrivingOnPavementEvents"] = 115,
	["ShouldThrowSmokeGrenadeNow"] = 116,
	["ForceInitialPeekInCover"] = 117,
	["DisableJumpingFromVehiclesAfterLeader"] = 118,
	["ShoutToGroupOnPlayerMelee"] = 119,
	["IgnoredByAutoOpenDoors"] = 120,
	["ForceIgnoreMeleeActiveCombatant"] = 121,
	["CheckLoSForSoundEvents"] = 122,
	["CanSayFollowedByPlayerAudio"] = 123,
	["ActivateRagdollFromMinorPlayerContact"] = 124,
	["ForcePoseCharacterCloth"] = 125,
	["HasClothCollisionBounds"] = 126,
	["DontBehaveLikeLaw"] = 127,
	["DisablePoliceInvestigatingBody"] = 128,
	["LowerPriorityOfWarpSeats"] = 129,
	["DisableTalkTo"] = 130,
	["DontBlip"] = 131,
	["IgnoreLegIkRestrictions"] = 132,
	["ForceNoTimesliceIntelligenceUpdate"] = 133,
	["0x36E3CAE1"] = 134,
	["NotAllowedToJackAnyPlayers"] = 135,
	["CannotBeMounted"] = 136,
	["CannotBeTakenDown"] = 137,
	["OneShotWillKillPed"] = 138,
	["0xF6076F5C"] = 139,
	["IsDraftAnimal"] = 140,
	["DisablePlayerAutoHolster"] = 141,
	["0x8B989605"] = 142,
	["0x9239BD41"] = 143,
	["0x9C9FD381"] = 144,
	["0x2AA25B29"] = 145,
	["CantWitnessCrimes"] = 146,
	["0xDB25067C"] = 147, -- PCF_Disable*
	["0x0DD984BE"] = 148,
	["0x1A4C248B"] = 149, -- PCF_Allow*
	["ForceBleeding"] = 150,
	["0xB11C76E8"] = 151,
	["0x79114A20"] = 152,
	["0x23E3351E"] = 153,
	["UseFollowLeaderThreatResponse"] = 154,
	["EnableCompanionAIAnalysis"] = 155,
	["EnableCompanionAISupport"] = 156,
	["DisableCompanionDragging"] = 157,
	["RequestStealthMovement"] = 158,
	["0xF95CE6DA"] = 159,
	["DisableDragDamage"] = 160,
	["IsWhistling"] = 161,
	["AlwaysLeaveTrainUponArrival"] = 162,
	["UseSloMoBloodVfx"] = 163,
	["0x10E66933"] = 164,
	["0x63DA4710"] = 165,
	["DontTeleportWithGroup"] = 166,
	["ShouldBeOnMount"] = 167,
	["EnableShockingEvents"] = 168,
	["DisableGrappleByPlayer"] = 169,
	["DisableGrappleByAi"] = 170,
	["0x6868B572"] = 171,
	["ForceDeepSurfaceCheck"] = 172,
	["0xE0892826"] = 173,
	["DisableEvasiveStep"] = 174,
	["SwappingReins"] = 175,
	["EnableAllyRevive"] = 176,
	["EnableEvasiveScanner"] = 177,
	["AllowNonTempExceptionEvents"] = 178,
	["0x605C7288"] = 179,
	["PreventDraggedOutOfCarThreatResponse"] = 180,
	["DisableDeepSurfaceAnims"] = 181,
	["DontBlipNotSynced"] = 182,
	["IsDuckingInVehicle"] = 183,
	["PreventAutoShuffleToTurretSeat"] = 184,
	["DisableEventInteriorStatusCheck"] = 185,
	["CorpseIsPersistent"] = 186,
	["ForceMeleeDamage"] = 187,
	["0x66114902"] = 188,
	["0xB94900F7"] = 189, -- PCF_[D-E]*
	["0x405A7A35"] = 190,
	["0x497EDECE"] = 191,
	["DisableShootingAt"] = 192,
	["0x87C5E494"] = 193,
	["ShouldPedFollowersIgnoreWaypointMBR"] = 194,
	["0x308D5751"] = 195,
	["0xE821E96B"] = 196,
	["0xBE339BF1"] = 197,
	["0x8590C200"] = 198,
	["0x9C65B372"] = 199,
	["BroadcastRepondedToThreatWhenGoingToPointShooting"] = 200,
	["0x11CB5DCC"] = 201,
	["0x88F47BBF"] = 202,
	["0x11D9FB08"] = 203,
	["0x435F091E"] = 204,
	["0x34D49B13"] = 205,
	["0xB78E3FC8"] = 206,
	["FlamingHoovesActive"] = 207,
	["0x010FB89C"] = 208,
	["0xC44343FA"] = 209,
	["0xCEBE76AE"] = 210,
	["GiveAmbientDefaultTaskIfMissionPed"] = 211,
	["0x9C8397DB"] = 212,
	["DisableCounterAttacks"] = 213,
	["0x3B611ABF"] = 214, -- PCF_C*
	["0xBFC10292"] = 215,
	["DontConfrontCriminal"] = 216,
	["SupressShockingEvents"] = 217,
	["DisablePickups"] = 218,
	["0x30675AE3"] = 219,
	["0x81BE4E79"] = 220,
	["0x5F20A08D"] = 221,
	["EnableIntimidationDragging"] = 222,
	["IsCriticalCorpse"] = 223,
	["DisableMeleeTargetSwitch"] = 224,
	["0x0C5FB46A"] = 225, -- PCF_[P-R]*
	["DisableAIWeaponBlocking"] = 226,
	["0x43176C67"] = 227,
	["0x5752DFD6"] = 228,
	["0xC8249A24"] = 229,
	["0x59D3A97A"] = 230,
	["0xD021799A"] = 231,
	["0x10AA850B"] = 232,
	["PedIsEnemyToPlayer"] = 233,
	["0x2EEFF534"] = 234,
	["0x0B5B5EAA"] = 235,
	["0x7E2699D1"] = 236,
	["0x5D83ABD3"] = 237,
	["0x22B89F66"] = 238,
	["0x4CA4689B"] = 239,
	["0xC0C73A04"] = 240,
	["0x6DEDF3DE"] = 241,
	["0x59BEF34E"] = 242,
	["0x0831CCD1"] = 243,
	["0x4462D38D"] = 244,
	["0xAFB1DF6A"] = 245,
	["ForcePedLoadCover"] = 246,
	["0x53D12991"] = 247,
	["0xF3DF1A4C"] = 248,
	["BlockWeaponSwitching"] = 249,
	["0xEEAA9CFD"] = 250, -- PCF_[S-T]*
	["0x946BACEC"] = 251,
	["0xF9289821"] = 252,
	["0x132E88AD"] = 253, -- PCF_C*
	["0x17B799AE"] = 254,
	["0xBD08A8FC"] = 255,
	["0x3FB5D3BB"] = 256,
	["0x38AEDDE0"] = 257,
	["0x96AA3A9B"] = 258,
	["CanAmbientHeadtrack"] = 259,
	["IsScuba"] = 260,
	["0x2463C309"] = 261,
	["0x124BE9DD"] = 262,
	["NoCriticalHits"] = 263,
	["UpperBodyDamageAnimsOnly"] = 264,
	["DrownsInWater"] = 265,
	["0xBAD60714"] = 266, -- PCF_[C-D]*
	["0x74A7BF09"] = 267,
	["DisableWeaponBlocking"] = 268,
	["0x8C7C276B"] = 269,
	["0xD788383D"] = 270,
	["0x01F89DEF"] = 271,
	["0xBDF5A77B"] = 272,
	["NeverEverTargetThisPed"] = 273,
	["0xAA92B3CC"] = 274, -- PCF_Allow*
	["0x3C7128FE"] = 275,
	["0x7A7A8B74"] = 276,
	["0x5FE313B3"] = 277, -- PCF_Disable*
	["0xB0D28E2E"] = 278, -- PCF_[C-D]*
	["NeverLeavesGroup"] = 279,
	["DontEnterLeadersVehicle"] = 280,
	["0x345B7609"] = 281,
	["0xEBBAA1B1"] = 282,
	["DisableInjuredRiderResponse"] = 283,
	["0x9C118A4B"] = 284, -- PCF_Block*
	["0xD03AD880"] = 285,
	["DisableEvasiveDives"] = 286,
	["AllowMissionDriverlessDraftAnimalResponse"] = 287,
	["0x4B822D03"] = 288,
	["TreatDislikeAsHateWhenInCombat"] = 289,
	["TreatNonFriendlyAsHateWhenInCombat"] = 290,
	["0xA09F4CDA"] = 291,
	["0xA5E8F092"] = 292,
	["0x40EB5604"] = 293,
	["DisableDriverlessDraftAnimalResponse"] = 294,
	["DisableInTrafficAvoidance"] = 295,
	["DisableAllAvoidance"] = 296,
	["ForceInteractionLockonOnTargetPed"] = 297,
	["0x58C8629F"] = 298,
	["0x7BE8B923"] = 299,
	["DisablePlayerHorseLeading"] = 300,
	["DisableInteractionLockonOnTargetPed"] = 301,
	["DisableMeleeKnockout"] = 302,
	["0x5CBBBA25"] = 303,
	["0x8D86008F"] = 304,
	["DisableHeadGore"] = 305,
	["DisableLimbGore"] = 306,
	["DisableMountSpawning"] = 307,
	["AllowILOWithWeapon"] = 308,
	["0x4885CFA9"] = 309, -- PCF_[P-R]*
	["CanBeLassoedByFriendlyPlayers"] = 310,
	["0x1C112278"] = 311,
	["DisableHorseGunshotFleeResponse"] = 312,
	["DontFindTransportToFollowLeader"] = 313,
	["ForceHogtieOfUnconciousPedToCarryAround"] = 314,
	["0xD38AEF95"] = 315, -- PCF_[G-I]*
	["DontStopForTrains"] = 316,
	["0x8E385F10"] = 317,
	["PreventScavengers"] = 318,
	["EnableAsVehicleTransitionDestination"] = 319,
	["0x743C18A9"] = 320,
	["0x4325A091"] = 321,
	["0x95B6BA5B"] = 322,
	["UseRacingLines"] = 323,
	["0x8D1AEDEF"] = 324,
	["0xC0CCD94A"] = 325,
	["0x4938756F"] = 326,
	["0x6E6BF9A7"] = 327,
	["0x5E9A5F16"] = 328,
	["0xD8D066F2"] = 329,
	["0x7C7AF264"] = 330, -- PCF_Disable*
	["0x9663C8F2"] = 331, -- PCF_[G-I]*
	["IsInStationaryScenario"] = 332,
	["0x27394ECA"] = 333,
	["0x23029D96"] = 334,
	["0x381A643F"] = 335,
	["ForceInjuredMovement"] = 336,
	["DontExitVehicleIfNoDraftAnimals"] = 337,
	["0xEEA5619C"] = 338,
	["0x9E57DC18"] = 339,
	["DisableAllMeleeTakedowns"] = 340,
	["ForceDismountLeft"] = 341,
	["ForceDismountRight"] = 342,
	["0x8FD863AF"] = 343,
	["0x345B8591"] = 344,
	["0xE64EEB72"] = 345,
	["0x0CA2A010"] = 346,
	["IsSanctionedShooter"] = 347,
	["0x3ED9A585"] = 348,
	["0x072C1C6D"] = 349,
	["0x88BDD64C"] = 350,
	["DisableIntimidationBackingAway"] = 351,
	["0x93AB4714"] = 352,
	["0xA662EDB3"] = 353,
	["0x28CBCEC7"] = 354,
	["0xEEBAF435"] = 355,
	["BlockRobberyInteractionEscape"] = 356,
	["0xA983D113"] = 357,
	["0x61EA3683"] = 358,
	["AllowInCombatInteractionLockonOnTargetPed"] = 359,
	["0xF8AF9E5C"] = 360,
	["IgnoreWeaponDegradation"] = 361,
	["0xC92D591B"] = 362,
	["0x51801A92"] = 363,
	["0x8B88F526"] = 364,
	["0x0E185496"] = 365,
	["DisableVehicleTransitions"] = 366,
	["0x0E3CB695"] = 367,
	["0x696695E0"] = 368,
	["0x58D4CF33"] = 369,
	["DisableDeadEyeTagging"] = 370,
	["0xAB673A85"] = 371,
	["0xDCB2DCC0"] = 372,
	["AllowSlipstream"] = 373,
	["0x2E58B068"] = 374,
	["0x121018F9"] = 375,
	["0xDFA8EBA4"] = 376,
	["0x7E01056D"] = 377,
	["0x42736B4A"] = 378,
	["0x5213A517"] = 379,
	["0xE68FAAFB"] = 380,
	["0x248CF998"] = 381,
	["0xCA56246D"] = 382,
	["0xB65C7C8B"] = 383,
	["0x00888CD6"] = 384,
	["0x6B749DC5"] = 385,
	["0x03AA190E"] = 386,
	["0x913B0D20"] = 387,
	["DisableFatallyWoundedBehaviour"] = 388,
	["0xB80AFE95"] = 389,
	["0xF8276C9A"] = 390,
	["0x0E7F44B9"] = 391,
	["0x2255F330"] = 392,
	["0x96B7B497"] = 393,
	["DisableInteractionWithAnimals"] = 394,
	["0x665CE445"] = 395,
	["0x29BBB477"] = 396,
	["DisableStuckResponse"] = 397,
	["0x1E1E8BA7"] = 398, -- PCF_[B-C]*
	["0x3A95125A"] = 399,
	["0x3EECBCF6"] = 400,
	["0x198B5351"] = 401,
	["0xCA2DF96D"] = 402,
	["0x21ADF5CB"] = 403,
	["0x0E674773"] = 404,
	["0xCEAE53FA"] = 405,
	["ForceOfferItemOnReceivingRobberyInteraction"] = 406,
	["0x0F79BB17"] = 407,
	["IsPerformingEmote"] = 408,
	["IsPerformingWeaponEmote"] = 409,
	["0x4AFE2C68"] = 410,
	["0xBB887117"] = 411,
	["BlockHorsePromptsForTargetPed"] = 412,
	["0xD291BB15"] = 413,
	["0x7B05BE6D"] = 414,
	["0x3FA067F1"] = 415,
	["StealthCoverEnter"] = 416,
	["DisableEagleEyeHighlight"] = 417,
	["0xC8ACAA6C"] = 418,
	["BlockMountHorsePrompt"] = 419,
	["IsKickingDoor"] = 420,
	["AllowDoorBargingUnderCombat"] = 421,
	["0x3AB3C6E2"] = 422,
	["0x86C10CF4"] = 423,
	["0x4F63DCAE"] = 424,
	["0x08F50AC5"] = 425,
	["0x7BA0E975"] = 426,
	["DisableDrunkDecay"] = 427,
	["0xC0ACCB2D"] = 428,
	["KnockOutDuringHogtie"] = 429,
	["0x0B237FF1"] = 430,
	["0xA5CB7C09"] = 431,
	["DisableGaitReduction"] = 432,
	["0x785D4043"] = 433,
	["0x41EB527E"] = 434,
	["AlwaysRejectPlayerRobberyAttempt"] = 435,
	["0x553A6EF0"] = 436,
	["DisableWeatherConditionPerceptionChecks"] = 437,
	["_SetHorseFleeCommandDisabled"] = 438, -- PCF_0x14013CF9
	["_SetHorseStayCommandDisabled"] = 439, -- PCF_0x8519377E
	["_SetHorseFollowCommandDisabled"] = 440, -- PCF_0xDBD31C9C
	["0xB61CE793"] = 441,
	["_DisableHorseFleeILO"] = 442, -- PCF_0x78525B66
	["0x9F42C50C"] = 443,
	["0x16A14D9A"] = 444,
	["DisableDoorBarge"] = 445,
	["DisableDoorInteractionTask"] = 446,
	["0xA1040728"] = 447,
	["TreatAsMissionPopTypeForSpeech"] = 448,
	["0x5CD355BD"] = 449,
	["0xA82B421F"] = 450,
	["HorseDontEvaluateRiderForDamageChecks"] = 451,
	["0x9909D028"] = 452,
	["0x43429291"] = 453,
	["0x089C3B7F"] = 454,
	["0xBB0F2E64"] = 455,
	["ForcePedKnockOut"] = 456,
	["0xD5AB81E2"] = 457,
	["0xFD170B10"] = 458,
	["0xCD4DCBEC"] = 459,
	["ForceWitnessIntimidationOnNextInteraction"] = 460,
	["0xD09EEF14"] = 461,
	["0xC3BB03BA"] = 462,
	["0xC2322EDE"] = 463,
	["0x219138E7"] = 464,
	["0x873F6A00"] = 465,
	["0xA9C6E67F"] = 466,
	["DisableHonorModifiers"] = 467,
	["0xC6540731"] = 468,
	["0x5A314A89"] = 469,
	["0x691431BD"] = 470,
	["DisableHorseKick"] = 471,
	["DisableSittingScenarios"] = 472,
	["DisableAutoSittingScenarios"] = 473,
	["DisableRestingScenarios"] = 474,
	["DisableAutoRestingScenarios"] = 475,
	["RejectTrafficCalloutDisputes"] = 476,
	["CanInteractWithPlayerEvenIfInputsDisabled"] = 477,
	["0x957D269D"] = 478,
	["0x9BF41BF2"] = 479,
	["0xC78D54C4"] = 480,
	["0x6DEA76B1"] = 481,
	["0xC7A80079"] = 482,
	["0xED575704"] = 483,
	["0x154BFF03"] = 484,
	["0xB40114AF"] = 485,
	["0x6A84551F"] = 486,
	["0x2621982A"] = 487,
	["DiesInstantlyToMeleeFromAnimals"] = 488,
	["0xF9EE4C8A"] = 489,
	["0xF2A1A360"] = 490,
	["0xDB937F2C"] = 491,
	["0x391CCB82"] = 492,
	["0xA58B6703"] = 493,
	["0x5BD8B9DC"] = 494,
	["0xF8CF513A"] = 495,
	["0x110F10D1"] = 496,
	["0x0FB07F5A"] = 497,
	["0xC79F7785"] = 498,
	["BlockWhistleEvents"] = 499,
	["0xC9CCA1E4"] = 500,
	["0x5F75066E"] = 501,
	["0x5B64E56A"] = 502,
	["DisableSpecialGreetChains"] = 503,
	["0x253C4B25"] = 504,
	["AllowRobberyWhenInjured"] = 505,
	["RunToTransport"] = 506,
	["0xE98C1598"] = 507,
	["0x66B3CA93"] = 508,
	["0xE1B40374"] = 509,
	["DisableConfrontCriminalTowardsThisPed"] = 510,
	["0xFF691D47"] = 511,
	["0xA91A8F5D"] = 512,
	["0x07221A26"] = 513,
	["DisableFriendlyAmbientAnimalFollowing"] = 514,
	["DisableReloadMultiplier"] = 515,
	["0x6C3E1067"] = 516,
	["AllowPersistenceOverride"] = 517,
	["DisableWalkAway"] = 518,
	["0xE6AC71E1"] = 519,
	["0x43C121FD"] = 520,
	["0x8186B12C"] = 521,
	["DontFleeFromDroppedAnimals"] = 522,
	["0x9D56AF0A"] = 523,
	["0x2F8FCCA7"] = 524,
	["0xD06E62C8"] = 525,
	["DisableTacticalAnalysis"] = 526,
	["0xED829B99"] = 527,
	["0xF1DEE14D"] = 528,
	["0xDD0B572E"] = 529,
	["0x41F0C11C"] = 530,
	["0x6FE93B06"] = 531,
	["0x760D1D40"] = 532,
	["0x508CC0C1"] = 533,
	["0x09CAAAC1"] = 534,
	["0xEFF1BFD7"] = 535,
	["0x97D22E0F"] = 536,
	["CannotSwapReins"] = 537,
	["0x94928F59"] = 538,
	["0x13377872"] = 539,
	["FollowLeaderRunToEnterTransport"] = 540,
	["PlayerCorpse"] = 541,
	["0x4ECF4D1E"] = 542,
	["0x32F7554D"] = 543,
	["0xB13329B4"] = 544,
	["DontCreateCombatBlip"] = 545,
	["0x7F409486"] = 546,
	["0x665E5AB5"] = 547,
	["0xE357C75E"] = 548,
	["0xD5BFF570"] = 549,
	["DisableAndBreakAimLockOntoThisPed"] = 550,
	["0x75943079"] = 551,
	["0x74F95F2E"] = 552,
	["0x7BA7E665"] = 553,
	["0x544E47DB"] = 554,
	["0xC9A8DCFC"] = 555,
	["0x41C9EEAA"] = 556,
	["0xFC543F7D"] = 557,
	["0x27298865"] = 558,
	["0xF46AD61C"] = 559,
	["EnableMountCoverForPedInMP"] = 560,
	["EnableHorseCollectPlantInteractionInMP"] = 561,
	["0x74064B79"] = 562,
	["0x3090EC16"] = 563,
	["0x12300BC5"] = 564,
	["IsValidForVehicleSeatStow"] = 565,
	["EnableSpecialActionBranches"] = 566,
	["DisableHorseShunting"] = 567,
	["0xCF2BF977"] = 568,
	["CanBeAttackedByFriendlyPed"] = 569,
	["0xAE180F85"] = 570,
	["0xEB0A3629"] = 571,
	["0x67843207"] = 572,
	["0xFFEDA2A0"] = 573,
	["0xB6B446DB"] = 574,
	["DisableGuardAI"] = 575,
	["0xF965A657"] = 576,
	["0x65CB2911"] = 577,
	["0x47030DBE"] = 578,
	["0x04F84B32"] = 579,
	["IsTranquilized"] = 580,
	["0x811D6F58"] = 581,
	["AllowStudyInMP"] = 582,
	["0x107B0522"] = 583,
	["DisableInjuredMovement"] = 584,
	["RagdollFloatsIndefinitely"] = 585,
	["0x938B8DD8"] = 586,
	["0xB6CE7423"] = 587,
	["0xD6A8CBCA"] = 588,
	["0x4DE6C4FB"] = 589,
	["0x64624B35"] = 590,
	["0x4E549A84"] = 591,
	["0x38F1812A"] = 592,
	["0x7115FE4E"] = 593,
	["0x683E58D5"] = 594,
	["AllowAutoSwitchToProjectiles"] = 595,
	["0x43CFCCB3"] = 596,
	["0x2FDAD8E5"] = 597,
	["0x5A17DA53"] = 598,
	["DisableScenarioWarpWeaponDestruction"] = 599,
	["EnableProjectileAccuracy"] = 600,
	["0x2C666858"] = 601,
	["0x640FF990"] = 602
}

exports("dbyte/configFlags", configFlags)