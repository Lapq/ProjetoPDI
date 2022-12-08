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
## @deftypefn {} {@var{retval} =} apply_conditional_dilation (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: USUARIO <USUARIO@NOT-VCI-80>
## Created: 2022-12-07

function new_img = apply_conditional_dilation (img, se, shape, y_lim = 0.75, x_lim = 0.2)
  new_img = img;
  max_y = round(shape(1)*y_lim);
  max_x_left = round(shape(1)*x_lim);
  min_x_right = round(shape(1)*(1-x_lim));
  
  new_img(1:max_y, 1:max_x_left) = imdilate(new_img(1:max_y, 1:max_x_left), se);
  new_img(1:max_y, min_x_right:shape(1)) = imdilate(new_img(1:max_y, min_x_right:shape(1)), se);
endfunction
