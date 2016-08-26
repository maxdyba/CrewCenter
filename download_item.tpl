<?php require 'app_top.tpl' ?>

<section class="content-header">
    <h1>Downloads</h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-lg-12">
            <div class="callout callout-info">
                <h4>Starting Download</h4>
                <p>Your download will start in a few seconds. Click <a href="<?php echo $download->link;?>">here</a> to manually start.</p>
            </div>
        </div>
    </div>
</section>

<?php require 'app_bottom.tpl' ?>

<script type="text/javascript">
    var delay=1000; //1 second

    setTimeout(function() {
        window.location = "<?php echo $download->link;?>";
    }, delay);
</script>

<!-- <div align="center">
<p>Your download will start in a few seconds, or <a href="<?php echo $download->link;?>">click here to manually start.</a></p>
</div>

<script type="text/javascript"> 
    window.location = "<?php echo $download->link;?>";
</script> -->