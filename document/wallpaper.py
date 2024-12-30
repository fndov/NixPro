import os
import subprocess

def download_wallpapers(base_dir, target_dir):
    # Create the target folder if it doesn't exist
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    for root, dirs, files in os.walk(base_dir):
        if 'backgroundurl.txt' in files:
            url_file = os.path.join(root, 'backgroundurl.txt')
            with open(url_file, 'r') as f:
                url = f.read().strip()
                if url:
                    try:
                        # Define the path to save the wallpaper
                        image_name = os.path.basename(url)
                        image_path = os.path.join(target_dir, image_name)

                        # Use curl to download the image
                        curl_command = [
                            'curl', '-L', url, '-o', image_path
                        ]
                        subprocess.run(curl_command, check=True)

                        print(f"Downloaded: {image_name}")

                    except subprocess.CalledProcessError as e:
                        print(f"Failed to download {url}: {e}")

if __name__ == "__main__":
    base_directory = '/home/miyu/Downloads/nixos-config-main/themes'
    target_directory = os.path.expanduser('~/Desktop/wallpaper')  # Target directory for wallpapers
    download_wallpapers(base_directory, target_directory)
