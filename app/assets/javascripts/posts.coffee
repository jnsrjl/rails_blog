# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Help for caffenated jQuery from:
# https://css-tricks.com/jquery-coffeescript/

$ ->
  # Restrict uploadable image size
  # Help from:
  # http://stackoverflow.com/questions/307679/using-jquery-restricting-file-size-before-uploading
  $('#post_image').change ->
    # Size in MB
    size_mb = @files[0].size / 1024**2
    # If too big
    if (size_mb > 3)
      alert("Please use a smaller image (max 3MB)")

      # Clear file path
      @value = ""
