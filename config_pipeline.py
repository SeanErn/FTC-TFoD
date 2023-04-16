import os

# Find file
def find_file(filename, search_path='.'):
    for root, dir, files in os.walk(search_path):
        if filename in files:
            return str(os.path.join(root, filename))
    return str(None)

# Count number of labels
def count_items_in_label_file(path_to_label_file):
    if not os.path.exists(path_to_label_file):
        return 0
    
    with open(path_to_label_file, 'r') as f:
        lines = f.readlines()
    
    item_names = []
    for line in lines:
        if 'name' in line:
            item_name = line.split("'")[1]
            item_names.append(item_name)
    
    return len(set(item_names))

# Update file
def update_file(filename, old_str, new_str):
    # Open the file in read mode and read the content
    with open(filename, 'r') as file:
        content = file.read()

    # Replace the old string with the new one
    new_content = content.replace(old_str, new_str)

    # Open the file in write mode and write the new content
    with open(filename, 'w') as file:
        file.write(new_content)


current_dir = os.getcwd()

labels_file = current_dir + '/train_data/label.pbtxt'
label_file_path = current_dir + '/train_data'
num_classes = count_items_in_label_file(labels_file)
fine_tune_checkpoint_path = current_dir + '/models/ssd_mobilenet_v2_quantized'
tfrecordfiles_path = current_dir + '/train_data'

print('Configuring pipeline with:')
print('Number of classes: ', num_classes)
print('Labels file path: ', labels_file)
print('Fine tune checkpoint path: ', fine_tune_checkpoint_path)

# Update pipeline.config file
update_file(fine_tune_checkpoint_path + '/pipeline.config', 'NUM_CLASSES', str(num_classes))
update_file(fine_tune_checkpoint_path + '/pipeline.config', 'PATH_TO_CHECKPOINT', str(fine_tune_checkpoint_path))
update_file(fine_tune_checkpoint_path + '/pipeline.config', 'PATH_TO_TFRECORDS', str(tfrecordfiles_path))
update_file(fine_tune_checkpoint_path + '/pipeline.config', 'PATH_TO_LABELFILES', str(label_file_path))