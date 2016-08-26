<?php require 'app_top.tpl' ?>

<section class="content-header">
    <h1>File Manual PIREP</h1>
</section>
<section class="content">
    <div class="row">
        <div class="col-lg-4">
            <div class="box box-primary">
                <div class="box-body">
                    
                    <?php
                        if(isset($message))
                            echo '<div class="callout callout-danger">
                            <h4>Error</h4>
                            <p>'.$message.'</p></div>';
                    ?>
                    
                    <form action="<?php echo url('/pireps/mine');?>" method="post">
                        <div class="form-group">
                            <label>Pilot</label>
                            <input type="text" class="form-control" disabled placeholder="<?php echo Auth::$userinfo->firstname . ' ' . Auth::$userinfo->lastname;?>">
                        </div>
                        <div class="form-group">
                            <label>Airline</label>
                            <select name="code" id="code" class="form-control">
                                <option value="">Select airline</option>
                                <?php
                                    foreach($allairlines as $airline)
                                    {
                                        $sel = ($_POST['code'] == $airline->code || $bid->code == $airline->code)?'selected':'';

                                        echo '<option value="'.$airline->code.'" '.$sel.'>'.$airline->code.' - '.$airline->name.'</option>';
                                    }
                                ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Flight Number</label>
                            <input type="text" name="flightnum" class="form-control" value="<?php if(isset($bid->flightnum)) { echo $bid->flightnum; }?><?php if(isset($_POST['flightnum'])) { echo $_POST['flightnum'];} ?>">
                        </div>
                        <div class="form-group">
                            <label>Departure Airport</label>
                            <select id="depicao" name="depicao" class="form-control">
                                <option value="">Select departure airport</option>
                                <?php
                                    foreach($allairports as $airport)
                                    {
                                        $sel = ($_POST['depicao'] == $airport->icao || $bid->depicao == $airport->icao)?'selected':'';

                                        echo '<option value="'.$airport->icao.'" '.$sel.'>'.$airport->icao . ' - '.$airport->name .'</option>';
                                    }
                                ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Arrival Airport</label>
                            <select name="arricao" id="arricao" class="form-control">
                                <option value="">Select arrival airport</option>
                                <?php
                                    foreach($allairports as $airport)
                                    {
                                        $sel = ($_POST['arricao'] == $airport->icao || $bid->arricao == $airport->icao)?'selected':'';

                                        echo '<option value="'.$airport->icao.'" '.$sel.'>'.$airport->icao . ' - '.$airport->name .'</option>';
                                    }
                                ?>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Aircraft</label>
                            <select name="aircraft" id="aircraft" class="form-control">
                                <option value="">Select aircraft</option>
                                <?php
                                    foreach($allaircraft as $aircraft)
                                    {

                                        /*	Skip any aircraft which have aircraft that the pilot
                                            is not rated to fly (according to RANK) 
                                        */
                                        if(Config::Get('RESTRICT_AIRCRAFT_RANKS') === true)
                                        {
                                            /*	This means the aircraft rank level is higher than
                                                what the pilot's ranklevel, so just do "continue"
                                                and move onto the next route in the list 
                                             */
                                            if($aircraft->ranklevel > Auth::$userinfo->ranklevel)
                                            {
                                                continue;
                                            }
                                        }

                                        $sel = ($_POST['aircraft'] == $aircraft->name || $bid->registration == $aircraft->registration)?'selected':'';

                                        echo '<option value="'.$aircraft->id.'" '.$sel.'>'.$aircraft->name.' - '.$aircraft->registration.'</option>';
                                    }
                                ?>
                            </select>
                        </div>
                        
                        <?php
                        // List all of the custom PIREP fields
                        if(!$pirepfields) $pirepfields = array();
                        foreach($pirepfields as $field)
                        {
                        ?>
                        <div class="form-group"></div>
                        <label><?php echo $field->title ?></label>
                        <?php

                        // Determine field by the type

                        if($field->type == '' || $field->type == 'text')
                        {
                        ?>
                            <input type="text" name="<?php echo $field->name ?>" value="<?php echo $_POST[$field->name] ?>" class="form-control" />
                        <?php
                        } 
                        elseif($field->type == 'textarea')
                        {
                            echo '<textarea name="'.$field->name.'" class="form-control">'.$field->values.'</textarea>';
                        }
                        elseif($field->type == 'dropdown')
                        {
                            $values = explode(',', $field->options);

                            echo '<select name="'.$field->name.'" class="form-control">';
                            foreach($values as $value)
                            {
                                $value = trim($value);
                                echo '<option value="'.$value.'">'.$value.'</option>';
                            }
                            echo '</select>';		
                        }
                        ?>
                        </div>
                        <?php } ?>
                        
                        <div class="form-group">
                            <label>Fuel Used</label>
                            <input type="text" name="fuelused" class="form-control" placeholder="Enter fuel used in <?php echo Config::Get('LIQUID_UNIT_NAMES', Config::Get('LiquidUnit'))?>" value="<?php echo $_POST['fuelused']; ?>" />
                            <p>This is the fuel used on this flight in <?php echo Config::Get('LIQUID_UNIT_NAMES', Config::Get('LiquidUnit'))?></p>
                        </div>
                        <div class="form-group">
                            <label>Flight Time</label>
                            <input type="text" name="flighttime" class="form-control" placeholder="Enter in format HH.MM (example 3.45 = 3 hours and 45 minutes)" value="<?php echo $_POST['flighttime'] ?>" />
                        </div>
                        <div class="form-group">
                            <label>Route</label>
                            <textarea name="route" class="form-control" style="width: 100%" placeholder="Enter the route flown, or default will be from the schedule"><?php echo (!isset($_POST['route'])) ? $bid->route : $_POST['route']; ?></textarea>
                        </div>
                        <div class="form-group">
                            <label>Comments</label>
                            <textarea name="comment" class="form-control" style="width: 100%"><?php echo $_POST['comment'] ?></textarea>
                        </div>
                        <input type="hidden" name="bid" value="<?php echo $bidid ?>" />
                        <input type="submit" name="submit_pirep" value="Submit" class="btn btn-primary btn-flat pull-right" />
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<?php require 'app_bottom.tpl' ?>

<!--

<h3>File a Flight Report</h3>
<?php
if(isset($message))
	echo '<div id="error">'.$message.'</div>';
?>
<form action="<?php echo url('/pireps/mine');?>" method="post">
<dl>
	<dt>Pilot:</dt>
	<dd><strong><?php echo Auth::$userinfo->firstname . ' ' . Auth::$userinfo->lastname;?></strong></dd>
	
	<dt>Select Airline:</dt>
	<dd>
		<select name="code" id="code">
			<option value="">Select your airline</option>
		<?php
		foreach($allairlines as $airline)
		{
			$sel = ($_POST['code'] == $airline->code || $bid->code == $airline->code)?'selected':'';
				
			echo '<option value="'.$airline->code.'" '.$sel.'>'.$airline->code.' - '.$airline->name.'</option>';
		}
		?>
		</select>
	</dd>
	
	<dt>Enter Flight Number:</dt>
	<dd><input type="text" name="flightnum" value="<?php if(isset($bid->flightnum)) { echo $bid->flightnum; }?><?php if(isset($_POST['flightnum'])) { echo $_POST['flightnum'];} ?>" /></dd>
	
	<dt>Select Departure Airport:</dt>
	<dd>
		<div id="depairport">
		<select id="depicao" name="depicao">
			<option value="">Select a departure airport</option>
			<?php
			foreach($allairports as $airport)
			{
				$sel = ($_POST['depicao'] == $airport->icao || $bid->depicao == $airport->icao)?'selected':'';
				
				echo '<option value="'.$airport->icao.'" '.$sel.'>'.$airport->icao . ' - '.$airport->name .'</option>';
			}
			?>
		</select>
		</div>
	</dd>
	
	<dt>Select Arrival Airport:</dt>
	<dd>
		<div id="arrairport">
		<select id="arricao" name="arricao">
			<option value="">Select an arrival airport</option>
			<?php
			foreach($allairports as $airport)
			{
				$sel = ($_POST['arricao'] == $airport->icao || $bid->arricao == $airport->icao)?'selected':'';
				
				echo '<option value="'.$airport->icao.'" '.$sel.'>'.$airport->icao . ' - '.$airport->name .'</option>';
			}
			?>
		</select>
		</div>
	</dd>
	
	<dt>Select Aircraft:</dt>
	<dd>
		<select name="aircraft" id="aircraft">
			<option value="">Select the aircraft of this flight</option>
		<?php
		
		foreach($allaircraft as $aircraft)
		{
			
			/*	Skip any aircraft which have aircraft that the pilot
				is not rated to fly (according to RANK) 
			*/
			if(Config::Get('RESTRICT_AIRCRAFT_RANKS') === true)
			{
				/*	This means the aircraft rank level is higher than
					what the pilot's ranklevel, so just do "continue"
					and move onto the next route in the list 
				 */
				if($aircraft->ranklevel > Auth::$userinfo->ranklevel)
				{
					continue;
				}
			}
			
			$sel = ($_POST['aircraft'] == $aircraft->name || $bid->registration == $aircraft->registration)?'selected':'';
			
			echo '<option value="'.$aircraft->id.'" '.$sel.'>'.$aircraft->name.' - '.$aircraft->registration.'</option>';
		}
		?>
		</select>
	</dd>

	<?php
	// List all of the custom PIREP fields
	if(!$pirepfields) $pirepfields = array();
	foreach($pirepfields as $field)
	{
	?>
		<dt><?php echo $field->title ?></dt>
		<dd>
		<?php
		
		// Determine field by the type
		
		if($field->type == '' || $field->type == 'text')
		{
		?>
			<input type="text" name="<?php echo $field->name ?>" value="<?php echo $_POST[$field->name] ?>" />
		<?php
		} 
		elseif($field->type == 'textarea')
		{
			echo '<textarea name="'.$field->name.'">'.$field->values.'</textarea>';
		}
		elseif($field->type == 'dropdown')
		{
			$values = explode(',', $field->options);
			
			echo '<select name="'.$field->name.'">';
			foreach($values as $value)
			{
				$value = trim($value);
				echo '<option value="'.$value.'">'.$value.'</option>';
			}
			echo '</select>';		
		}
		?>
		
		</dd>
	<?php
	}
	?>
	
	<dt>Fuel Used</dt>
	<dd><input type="text" name="fuelused" value="<?php echo $_POST['fuelused']; ?>" />
		<p>This is the fuel used on this flight in <?php echo Config::Get('LIQUID_UNIT_NAMES', Config::Get('LiquidUnit'))?></p></dd>
	
	<dt>Flight Time</dt>
	<dd><input type="text" name="flighttime" value="<?php echo $_POST['flighttime'] ?>" />
		<p>Enter as hours - "5.30" is five hours and thirty minutes</p></dd>
		
	<dt>Route</dt>
	<dd><textarea name="route" style="width: 100%"><?php echo (!isset($_POST['route'])) ? $bid->route : $_POST['route']; ?></textarea>
		<p>Enter the route flown, or default will be from the schedule</p></dd>
	
	<dt>Comment</dt>
	<dd><textarea name="comment" style="width: 100%"><?php echo $_POST['comment'] ?></textarea></dd>
	
	<dt></dt>
	<dd><?php $bidid = ( isset($bid) )? $bid->bidid:$_POST['bid']; ?>
		<input type="hidden" name="bid" value="<?php echo $bidid ?>" />
		<input type="submit" name="submit_pirep" value="File Flight Report" /></dd>
</dl>

</form>


-->