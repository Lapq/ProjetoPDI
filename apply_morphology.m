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
## @deftypefn {} {@var{retval} =} apply_morphology (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: USUARIO <USUARIO@NOT-VCI-80>
## Created: 2022-12-07

function [s1, s2, s3, s4, s5] = apply_morphology (img, shape, se)
  strel_open = strel('square', 5);
  s1 = imopen(img, strel_open);
  s2 = s1;
  s3 = imfill(s2, 'holes');
  
  CC = bwconncomp(s3);
  numPixels = cellfun(@numel,CC.PixelIdxList);
  if numel(numPixels) > 0
    [sortvalues, sortindex] = sort(numPixels, 'descend');
    _1st_big = sortvalues(1);
    _1st_idx = sortindex(1);
    
    _2nd_big = sortvalues(1);
    _2nd_idx = sortindex(1);
  
    if numel(numPixels) > 1
      _2nd_big = sortvalues(2);
      _2nd_idx = sortindex(2);
    endif  
    s4 = zeros(shape);
    s4(CC.PixelIdxList{_1st_idx}) = 1;
    s4(CC.PixelIdxList{_2nd_idx}) = 1;
    
    s5 = apply_conditional_dilation(s4, se, shape);
  else
    s4 = s5 = s3;
  endif
endfunction
