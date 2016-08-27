<?php require 'app_top.tpl' ?>

<section class="content-header">
    <h1>Downloads</h1>
</section>
<section class="content">
    <div class="row">
        <?php 
            if(!$allcategories)
            {
echo '<div class="col-lg-12"><div class="callout callout-info"><h4>No Downloads</h4><p>No downloads have been added yet.</p></div></div>';
                return;
            }
            
            foreach($allcategories as $category)
            {
        ?>
        
        <div class="col-lg-3">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title"><?php echo $category->name?></h3>
                </div>
                <div class="box-body">
                    <?php	
                        # This loops through every download available in the category
                        $alldownloads = DownloadData::GetDownloads($category->id);

                        if(!$alldownloads)
                        {
echo '<p class="text-muted">There are no downloads in this category.</p>';
                            $alldownloads = array();
                        }

                        foreach($alldownloads as $download)
                        {
                    ?>
                    
                    <strong><?php echo $download->name?></strong>
                    <p class="text-muted"><?php echo $download->description?></p>
                    <a href="<?php echo url('/downloads/dl/'.$download->id);?>">Download</a>
                    <hr>
                    <?php
                        }
                    ?>
                </div>
            </div>
        </div>
        <?php
            }
        ?>
    </div>
</section>

<?php require 'app_bottom.tpl' ?>

<!-- <h1>Downloads</h1>

<?php 
if(!$allcategories)
{
	echo 'There are no downloads available!';
	return;
}

foreach($allcategories as $category)
{
?>
<p><h2><strong><?php echo $category->name?></strong></h2></p>
<ul>

<?php	
	# This loops through every download available in the category
	$alldownloads = DownloadData::GetDownloads($category->id);
	
	if(!$alldownloads)
	{
		echo 'There are no downloads under this category';
		$alldownloads = array();
	}
	
	foreach($alldownloads as $download)
	{
?>
	<li>
		<a href="<?php echo url('/downloads/dl/'.$download->id);?>">
			<?php echo $download->name?></a><br />
	      <?php echo $download->description?><br />
          <em>Downloaded <?php echo $download->hits?> times</em></li>
<?php
	}
?><br />
</ul>
	<?php
}
?> -->