import sys
import cv2

def resize(img, f):
    """Resize 'image' by 'f' in height dimension."""
    newDim = (int(img.shape[0]), int(f*img.shape[0]))
    return cv2.resize(img, newDim, interpolation = cv2.INTER_AREA)

if __name__=='__main__':
  img = sys.argv[1]
  factor = float(sys.argv[2])
  characters = ["Jon Snow", "Sansa Stark", "Arya Stark", "Bran Stark",
      "Cersei Lannister", "Jaime Lannister", "Tyrion Lannister",
      "Daenerys Targaryen", "Yara Greyjoy", "Theon Greyjoy", "Melisandre",
      "Jorah Mormont", "The Hound", "The Mountain", "Samwell Tarly",
      "Gilly", "Sam (Child)", "Lord Varys", "Brienne of Tarth", "Davos Seaworth",
      "Bronn", "Podrick Payne", "Tormund Giantsbane",  "Grey Worm",
      "Gendry",  "Beric Dondarrion",  "Euron Greyjoy", "Missandei"]
  name = img.split(".")[0]
  name = name.split("/")[-1]
  print(name)
  if name in characters:
    print(img)
    cv2.imwrite(img, resize(cv2.imread(img), factor))
