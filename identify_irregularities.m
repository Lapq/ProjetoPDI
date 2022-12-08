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
## @deftypefn {} {@var{retval} =} identify_irregularities (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: USUARIO <USUARIO@NOT-VCI-80>
## Created: 2022-11-27

function [s1, s2, s7, s9] = identify_irregularities (margin_marker, original_img, shape, var, se_disk_7, roi_marker)
  # Identifies region out of patients' body
  s1 = imreconstruct(margin_marker.*original_img, original_img);
  s2 = sigmoid_and_normalize2(s1, cutoff=0.7, gain=5);
  s3 = s2 < 0.5;
  s4 = imfill(s3, 'holes');
  s5 = imerode(s4, se_disk_7);

  # Finds neck
  s5_first_row = s5(1, :);
  neck_from_left = 1;
  while(neck_from_left < length(s5_first_row) && s5_first_row(neck_from_left) == 0)
      neck_from_left+=1;
  endwhile
  neck_from_right = shape(1);
  while(neck_from_right > 0 && s5_first_row(neck_from_right) == 0)
      neck_from_right-=1;
  endwhile
  center_of_neck = floor((neck_from_right - neck_from_left)/2) + neck_from_left;
  
  #Anulates trachea and vertebral column (if the position is close to the center of radiograph)
  s6 = ones(shape);
  if (center_of_neck/shape(1) > 0.4 && center_of_neck/shape(1) < 0.6)
      s6(:, (center_of_neck - var*4):(center_of_neck + var*4)) = 0;
  endif
  
  # Histogram projection to eliminate noise in neck region
  err = 0.3;
  
  s7 = imreconstruct(roi_marker.*(1.-s1), 1.-s1);
  ## Left side
  sum_y0_l = sum(s7(1:floor((size(s7)(2))/4), 1: floor((size(s7))(1)/2) - var)');
  y1 = 1;
  initial_value = sum_y0_l(1);
  while(((y1 < floor((size(s7))(2)/4)) && (sum_y0_l(y1) > ((1-err)*initial_value)) && (sum_y0_l(y1) < ((1+err)*initial_value))))
      y1 += 1;
  endwhile
  
  ## Right side
  sum_y0_r = sum(s7(1:floor((size(s7))(2)/4), floor((size(s7))(1)/2) - var: (size(s7))(2))');
  y2 = 1;
  initial_value = sum_y0_r(1);
  while((y2 < floor((size(s7))(2)/4)) && (sum_y0_r(y2) > ((1-err)*initial_value)) && (sum_y0_r(y2) < ((1+err)*initial_value)))
      y2 += 1;
  endwhile
  
  s8 = ones(shape);
  y = floor((y1 + y2)/2);
  s8(1:y) = 0;
  
  s9 = s5.*s6.*s8;
endfunction
