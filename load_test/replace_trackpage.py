import os
import re

count = 0

def process_file(filepath):
    global count
    with open(filepath, 'r') as f:
        lines = f.readlines()

    modified = False
    new_lines = []
    
    # Matches any line containing context.go(...); 
    # group 1 captures everything before 'context.go' to preserve indentation/spaces.
    pattern = re.compile(r'^(.*?)context\.go\((.*?)\);')
    
    i = 0
    while i < len(lines):
        line = lines[i]
        new_lines.append(line)
        
        match = pattern.search(line)
        if match:
            spaces = match.group(1)
            param = match.group(2)
            
            # Check next lines to see if trackPage is already there
            j = i + 1
            next_line_is_track = False
            while j < len(lines):
                if lines[j].strip() == '':
                    j += 1
                    continue
                if re.search(r'^\s*trackPage\(', lines[j]):
                    next_line_is_track = True
                break
            
            if not next_line_is_track:
                new_str = f"{spaces}trackPage({param});\n"
                new_lines.append(new_str)
                modified = True
                count += 1
                
        i += 1
        
    if modified:
        with open(filepath, 'w') as f:
            f.writelines(new_lines)
        print(f"Modified {filepath}")

for root, dirs, files in os.walk('/Users/gauravsingh/Documents/Codes/tgm/lib'):
    for file in files:
        if file.endswith('.dart'):
            process_file(os.path.join(root, file))

print(f"Total replacements: {count}")
