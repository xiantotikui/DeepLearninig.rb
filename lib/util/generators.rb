require 'chunky_png'

class Generators
  def generate_images_path(dir_path, save_path)
    tmp = Dir.pwd
    Dir.chdir(dir_path)
    img = Dir.glob('*.png')
    Dir.chdir(tmp)
    serialized_array = Marshal.dump(img)
    File.open(save_path, 'wb') { |f| f.write(serialized_array) }
    img
  end

  def one_hot_vector(data_y)
    min_val = data_y.min
    max_val = data_y.max
    array = []
    i = 0
    while i < data_y.size
      array[i] = []
      j = min_val
      while j <= max_val
        if data_y[i] == j
          array[i][j] = 1.0
        else
          array[i][j] = 0.0
        end
        j += 1
      end
      array[i].compact!
      i += 1
    end
    array
  end

  def tags_to_numbers(data_y)
    uniqe_array = []
    i = 0
    while i < data_y.size
      uniqe_array << data_y[i] unless uniqe_array.include?(data_y[i])
      i += 1
    end
    labeled_array = []
    i = 0
    while i < data_y.size
      j = 0
      while j < uniqe_array.size
        if data_y[i] == uniqe_array[j]
          labeled_array << uniqe_array.index(uniqe_array[j])
        end
        j += 1
      end
      i += 1
    end
    labeled_array
  end
end
