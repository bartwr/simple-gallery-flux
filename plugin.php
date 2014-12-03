<?php namespace plugins; ?>

<script type="text/javascript" src="<?php echo $plugin; ?>bower_components/flux/dist/Flux.js"></script>
<script type="text/javascript" src="<?php echo $plugin; ?>bower_components/flux-plus/dist/flux-plus.min.js"></script>
<script type="text/javascript" src="<?php echo $plugin; ?>bower_components/react/react-with-addons.js"></script>
<script type="text/javascript" src="<?php echo $plugin; ?>bower_components/elucidata-react-coffee/component.min.js"></script>
<script type="text/javascript" src="<?php echo $plugin; ?>dist/simple-gallery-flux.js"></script>
<script type="text/javascript">
  React.render(
    React.createElement(SimpleGalleryFlux.TestController),
    document.getElementById('simple-gallery-controller')
  );
  SimpleGalleryFlux.SimpleGalleryTasks.initializeGallery(2);
</script>
