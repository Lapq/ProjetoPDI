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
## @deftypefn {} {@var{retval} =} plot_many (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: USUARIO <USUARIO@NOT-VCI-80>
## Created: 2022-12-07

function plot_many (images2plot, nr_imgs, CM, plot_defective = false)
  nr_rows = nr_imgs;
  figure;
  for i = 1:nr_rows
    if any(i == [1 5 7 8 9 10]) || plot_defective
      subplot(1, 4, 1);
      imshow(images2plot{1}{i});
      title(["Imagem " num2str(i)]);
      
      subplot(1, 4, 2);
      imshow(images2plot{2}{i});
      title(["Predito " num2str(i)]);
      
      subplot(1, 4, 3);
      imshow(images2plot{3}{i});
      title(["Ground Truth " num2str(i)]);
      
      subplot(1, 4, 4);
      imshow(normalize_img(images2plot{4}{i}, [0 1]));
      title([char(unicode2native("Diferença ")) num2str(i)]);
      
      CM{i}
      
      pause();
    endif
  endfor
  
endfunction
