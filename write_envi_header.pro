;  output the image
;  OPENW, lun, outfile, /APPEND,/get_lun ;outfile is the directory 
;  WRITEU, lun, image  ; image is the variable output
;  CLOSE, lun
;  free_lun, lun

;  only write envi header
pro write_envi_header, infile, outfile, $
    samples = samples, $
    lines = lines, $
    bands = bands, $
    data_type = data_type, $
    interleave = interleave, $
    map_info = map_info
    
  openr, in, infile+'.hdr', /get_lun  ;打开模板文件的头文件
  ; Read one line at a time, saving the result into hdr
  hdr = ''
  line = ''
  WHILE NOT EOF(in) DO BEGIN
    READF, in, line
    hdr = [hdr, line]
  ENDWHILE
  FREE_LUN, in
  hdr=hdr[1:*]
  
  index=where(STRMATCH(hdr, 'band names = *'), count)
  if count gt 0 then hdr=hdr[0:index-1]
  
  if KEYWORD_SET(samples) then begin
  index=where(STRMATCH(hdr, 'samples = *'))
  hdr[index]='samples = '+ strtrim(string(samples),2)  
  endif
  
  if KEYWORD_SET(lines) then begin
  index=where(STRMATCH(hdr, 'lines   = *'))
  hdr[index]='lines   = '+ strtrim(string(lines),2)  
  endif
  
  if KEYWORD_SET(bands) then begin
  index=where(STRMATCH(hdr, 'bands   = *'))
  hdr[index]='bands   = '+ strtrim(string(bands),2)  
  endif
  
  if KEYWORD_SET(data_type) then begin
  index=where(STRMATCH(hdr, 'data type = *'))
  hdr[index]='data type = '+ strtrim(string(data_type),2)  
  endif 
  
  if KEYWORD_SET(interleave) then begin
  index=where(STRMATCH(hdr, 'interleave = *'))
  hdr[index]='interleave = '+ interleave  
  endif
   
  if KEYWORD_SET(map_info) then begin
  index=where(STRMATCH(hdr, 'map info = *'), count)
  if count gt 0 then hdr[index]='map info = '+ map_info  
  endif   
  
  n=n_elements(hdr)
  openw, out, outfile+'.hdr', /get_lun
  for i=0, n-1 do begin
  printf, out, hdr[i]
  endfor
  free_lun, out    
end
