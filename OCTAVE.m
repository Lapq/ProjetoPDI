# Definição de paths de leitura e tipos de imagem
pkg load image;

option = 2;

if(option == 1)
  original_path = ".\\JSRT\\";
  masks_path = ".\\JSRT_GTS\\";
  original_type = "IMG";
  mask_type = "bmp";
else
  original_path = ".\\CHN\\";
  masks_path = ".\\CHN_GTS\\";
  original_type = "png";
  mask_type = "png";  
endif

# Parâmetros para tipo de imagem
if (original_type == "IMG");
  original_shape = [2048, 2048];
endif

shape = [128, 128];

[originals, masks, nrimgs] = read_img(original_path, masks_path, shape, original_type, mask_type);

#Definições Morfologia
se_disk_7 = strel("disk", change_res(7, shape(1)),0);
se_rect_7_3 = strel("rectangle", [change_res(7, shape(1)), change_res(3, shape(1))]);
se_rect_14_3 = strel("rectangle", [change_res(14, shape(1)), change_res(3, shape(1))]);

# Definition of markers for reconstruction
roi_marker = zeros(shape);
pos_x = floor(shape(1)/2) - change_res(21, shape(1));
pos_yu = floor(shape(2)/2) + change_res(21, shape(1));
pos_yd = floor(shape(2)/2) - change_res(21, shape(1));
var = change_res(1, shape(1));
roi_marker(pos_x-var:pos_x+var, pos_yu-var*change_res(5, shape(1)):pos_yu+var*change_res(5, shape(1))) = 1;
roi_marker(pos_x-var:pos_x+var, pos_yd-var*5:pos_yd+var*5) = 1;
roi_marker(pos_x-var*change_res(10, shape(1)):pos_x+var*change_res(10, shape(1)), pos_yu-var:pos_yu+var) = 1;
roi_marker(pos_x-var*change_res(10, shape(1)):pos_x+var*change_res(10, shape(1)), pos_yd-var:pos_yd+var) = 1;

margin_marker = zeros(shape);
margin_marker(1, :) = 1;
margin_marker(shape(1), :) = 1;
margin_marker(:, 1) = 1;
margin_marker(:, shape(2)) = 1;


# Segunda página main do jupyter
for i = 1:nrimgs
  img = originals{i};
  
  # Identifies irregularities
  [a,b,c,d] = identify_irregularities(margin_marker, img, shape, var, se_disk_7, roi_marker);
  irreg_steps = num2cell([a,b,c,d]);
  irreg_res = d;
  irreg_mask = irreg_res;
  
  # Adjusts grey tone
  img_adjust = 1.-(img.*irreg_mask);
  img_adjust = sigmoid_and_normalize2(img_adjust, cutoff=0.6, gain=10);
  img_adjust = imclose(img_adjust, se_rect_7_3);
  img_adjust = 1.-img_adjust;
  img_adjust = change_edges(img_adjust, change_res(10, shape(1)), 0);
  
  # PESADAMENTE MODIFICADO A PARTIR DAQUI
  # Binarizes
  immean = imfilter(img_adjust,fspecial('average',5));
  backup = img_adjust;
  img_bin = img_adjust > normalize_img((img_adjust - immean), [0 1]) - 0.2;
  
  # Applies morphology
  [a, b, c, d, e] = apply_morphology(img_bin, shape, se_rect_14_3);
  morph_steps = num2cell([a,b,c,d,e]);
  morph_res =  e;
  res = morph_res;
  
  diff = masks{i}+(2.*res);
  
  # formatando diff para ser uma imagem devidamente indexada, para aplicação de um colormap
  colormap = [0	0	0; 0 1 1; 1 0 0; 1 1 1;];
  diff = gray2ind(normalize_img(diff, [0 1]), 4);
  rgb_diff = ind2rgb(diff, colormap);
  
  # Stores results
  # tirei alguns que não eram usados
  results{i} = res;
  diffs{i} = rgb_diff;
  
  # Confusion Matrix
  CM{i} = calculate_CM(diff);
endfor

images2plot{1} = originals;
images2plot{2} = results;
images2plot{3} = masks;
images2plot{4} = diffs;

plot_many(images2plot, nrimgs, CM);