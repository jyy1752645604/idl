;Description: convert from Sinusoidal projection to geographic projection (or any projection)
;remember install MCTK first
;Use: input files HDF; output multi images

PRO convert_hdf_batch
  COMPILE_OPT IDL2
  ENVI, /RESTORE_BASE_SAVE_FILES
  ENVI_BATCH_INIT, LOG_FILE='BATCH.LOG'
  PRINT, 'START : ',SYSTIME()

  ROOT_DIR = 'D:\input\'
  FNS = FILE_SEARCH(ROOT_DIR,'*.HDF',COUNT = COUNT)
  PRINT, 'There ara totally', COUNT,' images.'

; change the grid_name for different product, sd_name is the band component of band  
  OUTPUT_LOCATION = 'D:\'
  GRID_NAME = 'mod04'
  SWATH_NAME='mod04'
  SD_NAME_band1 = ['Deep_Blue_Aerosol_Optical_Depth_550_Land']
;  SD_NAME_band2 = ['sur_refl_b02']
;  SD_NAME_band3 = ['sur_refl_b03']
;  SD_NAME_band4 = ['sur_refl_b04']
;  SD_NAME_band5 = ['sur_refl_b05']
;  SD_NAME_band6 = ['sur_refl_b06']
;  SD_NAME_band7 = ['sur_refl_b07']
;  SD_NAME_band8 = ['BRDF_Albedo_Parameters_vis']
;  SD_NAME_band9 = ['BRDF_Albedo_Parameters_nir']
;  SD_NAME_band10 = ['BRDF_Albedo_Parameters_shortwave']
 
;   0 — Standard (no projection/reprojection is carried out, one set of output files)
; 1 — Projected (rigorous projection/reprojection is carried out, one set of output files)
; 2 — Standard and Projected (two sets of output files) 
  OUTPUT_METHOD = 1 
; out_ps = [0.005075d,0.004176d]
  OUTPUT_PROJECTION = ENVI_PROJ_CREATE(/geographic)

; input every band from HDF
  FOR i = 0, COUNT-1  DO BEGIN
    FILENAME = FNS[i]
    A = STRPOS(FILENAME,'M')
    
    OUTPUT_ROOT_NAME_band1 =  STRMID(FILENAME,A,40)
    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band1, swt_name=swath_name,$
      GD_NAME=GRID_NAME, SD_NAME =  SD_NAME_band1, $
      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
      INTERP_METHOD = 0, $
      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG

;    OUTPUT_ROOT_NAME_band2 =  STRMID(FILENAME,A+1,15)+'_band2'
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band2, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band2, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG
;
;    OUTPUT_ROOT_NAME_band3 =  STRMID(FILENAME,A+1,15)+'_band3' 
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band3, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band3, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG
;
;    OUTPUT_ROOT_NAME_band4 =  STRMID(FILENAME,A+1,15)+'_band4' 
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band4, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band4, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG
;      FILENAME = FNS[i]
;    
;    OUTPUT_ROOT_NAME_band5 =  STRMID(FILENAME,A+1,15)+'_band5'
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band5, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band5, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY,/NO_MSG
;
;    OUTPUT_ROOT_NAME_band6 =  STRMID(FILENAME,A+1,15)+'_band6'
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band6, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band6, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG
;
;    OUTPUT_ROOT_NAME_band7 =  STRMID(FILENAME,A+1,15)+'_band7'
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band7, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band7, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG

;    OUTPUT_ROOT_NAME_band8 = STRMID(FILENAME,A+1,15)+'_vir'
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band8, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band8, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG
;     
;    OUTPUT_ROOT_NAME_band9 = STRMID(FILENAME,A+1,15)+'_nir' 
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band9, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band9, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG
;
;    OUTPUT_ROOT_NAME_band10 =  STRMID(FILENAME,A+1,15)+'_shortwave'
;    CONVERT_MODIS_DATA, IN_FILE = FILENAME, $
;      OUT_PATH = OUTPUT_LOCATION, OUT_ROOT=OUTPUT_ROOT_NAME_band10, $
;      GD_NAME=GRID_NAME,SD_NAME =  SD_NAME_band10, $
;      OUT_METHOD = OUTPUT_METHOD, OUT_PROJ = OUTPUT_PROJECTION, $
;      INTERP_METHOD = 0, $
;      BACKGROUND='0', FILL_REPLACE_VALUE='0',$
;      R_FID_ARRAY=R_FID_ARRAY, R_FNAME_ARRAY=R_FNAME_ARRAY, /NO_MSG
;      

  ENDFOR

  PRINT, 'END : ', SYSTIME()
  ENVI_BATCH_EXIT

END