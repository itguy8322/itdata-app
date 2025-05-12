from PIL import Image

# Open the existing GIF
gif_path = "success.gif"
output_path = "output.gif"

from PIL import Image, ImageOps

# Open the image
image = Image.open("output.gif")

# Target size (width, height) for the bounding box
target_size = (400, 400)  # Example: Resize bounding box to 400x400

# Add padding to match the target size
padded_image = ImageOps.pad(image, target_size, color=(255, 255, 255))  # White background

# Convert to RGB mode (if needed) before saving as JPEG
if padded_image.mode != "RGB":
    padded_image = padded_image.convert("RGB")

# Save the result
padded_image.save("output_padded.gif", save_all=True)


print("Done!")
