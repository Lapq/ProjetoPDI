## Copyright (C) 2022 USUARIO
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} read_img (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: USUARIO <USUARIO@DESKTOP-0C9S2SE>
## Created: 2022-10-18

function [originals, masks, nrimgs] = read_img (original_path, masks_path, shape, original_type, mask_type)
  original_files = glob( strcat(original_path, "*.", original_type) );
  original_f_count = numel(original_files);
  mask_files = glob( strcat(masks_path, "*.", mask_type) );
  mask_f_count = numel(mask_files);
  
  
  # Definition of position to evaluate if image greyscale is inverted
  pos_x = floor(shape(1)/2) + change_res(42, shape(1));
  pos_y = floor(shape(2)/2);
  var = change_res(3, shape(1));
  
  
  if (mask_f_count != original_f_count)
    error("Cardinalidade diferente entre máscaras e arquivos originais");
  endif;
  for i = 1:original_f_count
    aux = imread(original_files{i}, original_type);
    aux = imresize(aux, shape);
    aux = im2double(aux);
    
    if (mean(aux(pos_x-var:pos_x+var, pos_y-var:pos_y+var)(:)) <= 0.5)
      aux = 1.-aux;
    endif
    
    originals{i} = 1-aux;
  endfor;
   for i = 1:mask_f_count
    aux = imread(mask_files{i}, mask_type);
    aux = imresize(aux, shape);
    masks{i} = aux;
  endfor;
  nrimgs = length(originals);
endfunction