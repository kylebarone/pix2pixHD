import subprocess
epoch = [10, 20, 40, 80, 120, 140, 178, 179, 180, 183, 190, 192, 195]
for i in epoch:
	bashCommand = "gsutil cp ~/pix2pixHD/checkpoints/light/output/epoch-{}_light_7.0-s_24.0-fps.mp4 gs://jelly-bucket/pix2pixHD/checkpoints/light/output/rainbow_vert_lights".format(i)
	#print(bashCommand)
	process = subprocess.Popen(bashCommand.split(), stdout=subprocess.PIPE)
	output, error = process.communicate()