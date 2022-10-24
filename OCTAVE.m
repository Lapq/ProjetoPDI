# Definição de paths de leitura e tipos de imagem
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

[originals, masks] = read_img(original_path, masks_path, shape, original_type, mask_type);

#roi_marker = 