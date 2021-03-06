# ordre des aiguilles d'une montre
LITERAL = ['h_c', 'h_r', 'c_r', 'l_r', 'l_c', 'l_l', 'c_l', 'h_l']
POS_Y = [-1, -1, 0, 1, 1, 1, 0, -1]
POS_X = [0, 1, 1, 1, 0, -1, -1, -1]

LEN_POS = len(POS_X)

THUMB_STEP = 48
FORMAT_IMAGE = 'TIFF'
QUALITY_IMAGE = 90
EXTENSION_IMAGE = FORMAT_IMAGE.lower()
DEFAULT_IMAGE_BACKGROUND_COLOR = '#393939'
DEFAULT_TEMPLATE_BACKGROUND_COLOR = 'white'
DEFAULT_IMAGE_MODE = 'RGB'
THUMB_FORMAT_IMAGE = 'JPEG'
THUMB_EXTENSION_IMAGE = 'jpg'

#CROP_POS = (         
#    (0, 600, 800, 800), # h_c
#    (0, 600, 200, 800), # h_r
#    (0, 0, 200, 800), # c_r
#    (0, 0, 200, 200), # l_r
#    (0, 0, 800, 200), # l_c
#    (600, 0, 800, 200), # l_l
#    (600, 0, 800, 800), # c_l
#    (600, 600, 800, 800), # h_l
#)

#PASTE_POS = (
#    (200, 0, 1000, 200), # h_c
#    (1000, 0, 1200, 200), # h_r
#    (1000, 200, 1200, 1000), # c_r
#    (1000, 1000, 1200, 1200), # l_r
#    (200, 1000, 1000, 1200), # l_c
#    (0, 1000, 200, 1200), # l_l
#    (0, 200, 200, 1000), # c_l
#    (0, 0, 200, 200), # h_l
#)