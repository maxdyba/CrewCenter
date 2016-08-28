<div class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">

        <header class="main-header">
            <!-- Logo -->
            <a href="<?php echo SITE_URL?>" class="logo">
                <!-- mini logo for sidebar mini 50x50 pixels -->
                <span class="logo-mini">C<b>C</b></span>
                <!-- logo for regular state and mobile devices -->
                <span class="logo-lg">Crew<b>Center</b></span>
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                </a>

                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <img src="<?php echo SITE_URL?>/lib/skins/crewcenter/dist/img/pilot.png" class="user-image" alt="User Image">
                                <span class="hidden-xs"><?php echo Auth::$userinfo->firstname.' '.Auth::$userinfo->lastname; ?></span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- User image -->
                                <li class="user-header">
                                    <img src="<?php echo SITE_URL?>/lib/skins/crewcenter/dist/img/pilot.png" class="img-circle" alt="User Image">

                                    <p>
                                        <?php echo Auth::$userinfo->firstname.' '.Auth::$userinfo->lastname; ?>
                                        <small><?php echo $pilotcode; ?></small>
                                    </p>
                                </li>
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-left">
                                        <a href="<?php echo url('/profile/editprofile'); ?>" class="btn btn-primary btn-block btn-flat">My Profile</a>
                                    </div>
                                    <div class="pull-right">
                                        <a href="<?php echo url('/logout'); ?>" class="btn btn-danger btn-block btn-flat">Log Out</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <!-- Left side column. contains the logo and sidebar -->
        <aside class="main-sidebar">
            <!-- sidebar: style can be found in sidebar.less -->
            <section class="sidebar">
                <!-- Sidebar user panel -->
                <div class="user-panel">
                    <div class="pull-left image">
                        <img src="<?php echo SITE_URL?>/lib/skins/crewcenter/dist/img/pilot.png" class="img-circle" alt="User Image">
                    </div>
                    <div class="pull-left info">
                        <p><?php echo Auth::$userinfo->firstname.' '.Auth::$userinfo->lastname; ?></p>
                        <a><i class="fa fa-circle text-success"></i><?php if(PilotGroups::group_has_perm(Auth::$usergroups, ACCESS_ADMIN)) { echo ' Administrator'; } else { echo ' Pilot'; } ?></a>
                    </div>
                </div>
                <!-- sidebar menu: : style can be found in sidebar.less -->
                <ul class="sidebar-menu">
                    <li class="header">NAVIGATION</li>
                    <li>
                        <a href="<?php echo SITE_URL?>">
                            <i class="fa fa-dashboard"></i> <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo url('/pireps/filepirep'); ?>">
                            <i class="fa fa-file-text"></i> <span>File Manual PIREP</span>
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo url('/pireps/mine'); ?>">
                            <i class="fa fa-list"></i> <span>My Reports</span>
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo url('/schedules/bids'); ?>">
                            <i class="fa fa-list"></i> <span>My Bids</span>
                        </a>
                    </li>
                    <li>
                        <a href="<?php echo url('/downloads'); ?>">
                            <i class="fa fa-cloud-download"></i> <span>Downloads</span>
                        </a>
                    </li>
                    
                    <?php if(PilotGroups::group_has_perm(Auth::$usergroups, ACCESS_ADMIN)) { echo '
                    <li>
                        <a href=" '.SITE_URL.'/admin">
                            <i class="fa fa-cog"></i> <span>Administration</span>
                        </a>
                    </li>
                    '; } ?>
                </ul>
            </section>
            <!-- /.sidebar -->
        </aside>
        
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">