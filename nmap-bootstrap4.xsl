<?xml version="1.0" encoding="utf-8"?>
<!--
Nmap Bootstrap XSL
Creative Commons BY-SA
Andreas Hontzia (@honze_net)
Migrated to Bootstrap 4 by Andreas Wiese
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta name="referrer" content="no-referrer"/> 
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.19/css/dataTables.bootstrap4.min.css" integrity="sha256-F+DaKAClQut87heMIC6oThARMuWne8+WzxIDT7jXuPA=" crossorigin="anonymous" />
        <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha384-fJU6sGmyn07b+uD1nMk7/iSb4yvaowcueiQhfVgQuD98rfva8mcr1eSvjchfpMrH" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  		<script src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.19/js/jquery.dataTables.min.js" integrity="sha256-t5ZQTZsbQi8NxszC10CseKjJ5QeMw5NINtOXQrESGSU=" crossorigin="anonymous"></script>
  		<script src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.19/js/dataTables.bootstrap4.min.js" integrity="sha256-hJ44ymhBmRPJKIaKRf3DSX5uiFEZ9xB/qx8cNbJvIMU=" crossorigin="anonymous"></script>
        <style>
          body {
  		  	font-size: 0.875rem;
			position: relative;
  		  }
          body > .container {
    		padding: 6rem 0.5rem 0;
		  }
          table {
  			 font-size: 0.875rem !important;
  			 line-height: 1 !important;
  		  }
  		  .card {
  		  	margin: 1rem 0rem;
  		  }
          .target:before {
            content: "";
            display: block;
			padding-top: 2rem;
          }
          .footer {
          	padding: 2rem;  		
          	margin-top: 4rem;
    		bottom: 0;
    		width: 100%;
    		background-color: #f5f5f5;
		  }
          @media only screen and (min-width:1900px) {
            .container {
              width: 1800px;
              }
          }
        </style>
        <title>Scan Report Nmap <xsl:value-of select="/nmaprun/@version"/> - Scanned at <xsl:value-of select="/nmaprun/@startstr"/></title>
      </head>
      <body data-spy="scroll" data-target="#navbar-report">  
      <nav id="navbar-report" class="navbar navbar-expand-md navbar-light fixed-top bg-light">
  		<a class="navbar-brand" href="#">Scan Report</a>
  		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
   		<span class="navbar-toggler-icon"></span>
  		</button>
  		<div class="collapse navbar-collapse" id="navbarNavAltMarkup">
    		<div class="navbar-nav">
      			<ul class="nav">
  				<li class="nav-item">
    					<a class="nav-link" href="#scannedhosts">Scanned Hosts</a>
  				</li>
  				<li class="nav-item">
    					<a class="nav-link" href="#onlinehosts">Online Hosts</a>
  				</li>
  				<li class="nav-item">
    					<a class="nav-link" href="#openservices">Open Services</a>
  				</li>
  
			</ul>
    		</div>
  		</div>
		</nav>
        <div class="container">
          <div class="jumbotron">
            <h1>Scan Report<br/><small>Nmap <xsl:value-of select="/nmaprun/@version"/></small></h1>
            <pre><code><xsl:value-of select="/nmaprun/@args"/></code></pre>
            <p class="lead">
              <xsl:value-of select="/nmaprun/@startstr"/> – <xsl:value-of select="/nmaprun/runstats/finished/@timestr"/><br/>
              <xsl:value-of select="/nmaprun/runstats/hosts/@total"/> hosts scanned.
              <xsl:value-of select="/nmaprun/runstats/hosts/@up"/> hosts up.
              <xsl:value-of select="/nmaprun/runstats/hosts/@down"/> hosts down.
            </p>
            <div class="progress">
              <div class="progress-bar bg-success" style="width: 0%">
                <xsl:attribute name="style">width:<xsl:value-of select="/nmaprun/runstats/hosts/@up div /nmaprun/runstats/hosts/@total * 100"/>%;</xsl:attribute>
                <xsl:value-of select="/nmaprun/runstats/hosts/@up"/>
                <span class="sr-only"></span>
              </div>
              <div class="progress-bar bg-danger" style="width: 0%">
                <xsl:attribute name="style">width:<xsl:value-of select="/nmaprun/runstats/hosts/@down div /nmaprun/runstats/hosts/@total * 100"/>%;</xsl:attribute>
                <xsl:value-of select="/nmaprun/runstats/hosts/@down"/>
                <span class="sr-only"></span>
              </div>
            </div>
          </div>
          <h4 id="scannedhosts" class="target">Scanned Hosts<xsl:if test="/nmaprun/runstats/hosts/@down > 1024"><small> (offline hosts are hidden)</small></xsl:if></h4>
          <div class="table-responsive">
            <table id="table-overview" class="table dataTable" role="grid">
              <thead>
                <tr>
                  <th>State</th>
                  <th>Address</th>
                  <th>Hostname</th>
                  <th>TCP (open)</th>
                  <th>UDP (open)</th>
                </tr>
              </thead>
              <tbody>
                <xsl:choose>
                  <xsl:when test="/nmaprun/runstats/hosts/@down > 1024">
                    <xsl:for-each select="/nmaprun/host[status/@state='up']">
                      <tr>
                        <td><span class="badge badge-danger"><xsl:if test="status/@state='up'"><xsl:attribute name="class">badge badge-success</xsl:attribute></xsl:if><xsl:value-of select="status/@state"/></span></td>
                        <td><xsl:value-of select="address/@addr"/></td>
                        <td><xsl:value-of select="hostnames/hostname/@name"/></td>
                        <td><xsl:value-of select="count(ports/port[state/@state='open' and @protocol='tcp'])"/></td>
                        <td><xsl:value-of select="count(ports/port[state/@state='open' and @protocol='udp'])"/></td>
                      </tr>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:for-each select="/nmaprun/host">
                      <tr>
                        <td><span class="badge badge-danger"><xsl:if test="status/@state='up'"><xsl:attribute name="class">badge badge-success</xsl:attribute></xsl:if><xsl:value-of select="status/@state"/></span></td>
                        <td><xsl:value-of select="address/@addr"/></td>
                        <td><xsl:value-of select="hostnames/hostname/@name"/></td>
                        <td><xsl:value-of select="count(ports/port[state/@state='open' and @protocol='tcp'])"/></td>
                        <td><xsl:value-of select="count(ports/port[state/@state='open' and @protocol='udp'])"/></td>
                      </tr>
                    </xsl:for-each>
                  </xsl:otherwise>
                </xsl:choose>
              </tbody>
            </table>
          </div>
          <script>
            $(document).ready(function() {
              $('#table-overview').DataTable();
            });
          </script>
          <h4 id="onlinehosts" class="target">Online Hosts</h4>
          <xsl:for-each select="/nmaprun/host[status/@state='up']">
            <div class="card">
            <h5 class="card-header"><xsl:value-of select="address/@addr"/><xsl:if test="count(hostnames/hostname) > 0"> - <xsl:value-of select="hostnames/hostname/@name"/></xsl:if></h5>
              <div class="card-body">
              <xsl:if test="count(address) > 0">
    			<h6>Address</h6>
      			<ul>
        			<xsl:for-each select="address">
          				<li><xsl:value-of select="@addr"/>
            			<xsl:if test="@vendor">
              			<xsl:text> - </xsl:text>
                		<xsl:value-of select="@vendor"/>
              			<xsl:text> </xsl:text>
            			</xsl:if>
            			<span class="badge badge-secondary text-uppercase"><xsl:value-of select="@addrtype"/></span>
          				</li>
        			</xsl:for-each>
      			</ul>
  				</xsl:if>
                <xsl:if test="count(hostnames/hostname) > 0">
                  <h6>Hostnames</h6>
                  <ul>
                    <xsl:for-each select="hostnames/hostname">
                      <li><xsl:value-of select="@name"/> (<xsl:value-of select="@type"/>)</li>
                    </xsl:for-each>
                  </ul>
                </xsl:if>
                <h6>Ports</h6>
                <div class="table-responsive">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>Port</th>
                        <th>Protocol</th>
                        <th>State</th>
                        <th>Service</th>
                        <th>Reason</th>
                        <th>Product</th>
                        <th>Version</th>
                        <th>Extra Info</th>
                      </tr>
                    </thead>
                    <tbody>
                      <xsl:for-each select="ports/port">
                        <xsl:choose>
                          <xsl:when test="state/@state = 'open'">
                            <tr class="table-success">
                              <td title="Port"><xsl:value-of select="@portid"/></td>
                              <td title="Protocol"><xsl:value-of select="@protocol"/></td>
                              <td title="State"><xsl:value-of select="state/@state"/></td>
                              <td title="Service"><xsl:value-of select="service/@name"/></td>
                              <td title="Reason"><xsl:value-of select="state/@reason"/></td>
                              <td title="Product"><xsl:value-of select="service/@product"/></td>
                              <td title="Version"><xsl:value-of select="service/@version"/></td>
                              <td title="Extra Info"><xsl:value-of select="service/@extrainfo"/></td>
                            </tr>
                          </xsl:when>
                          <xsl:when test="state/@state = 'filtered'">
                            <tr class="table-warning">
                              <td title="Port"><xsl:value-of select="@portid"/></td>
                              <td title="Protocol"><xsl:value-of select="@protocol"/></td>
                              <td title="State"><xsl:value-of select="state/@state"/></td>
                              <td title="Service"><xsl:value-of select="service/@name"/></td>
                              <td title="Reason"><xsl:value-of select="state/@reason"/></td>
                              <td title="Product"><xsl:value-of select="service/@product"/></td>
                              <td title="Version"><xsl:value-of select="service/@version"/></td>
                              <td title="Extra Info"><xsl:value-of select="service/@extrainfo"/></td>
                            </tr>
                          </xsl:when>
                          <xsl:when test="state/@state = 'closed'">
                            <tr class="table-active">
                              <td title="Port"><xsl:value-of select="@portid"/></td>
                              <td title="Protocol"><xsl:value-of select="@protocol"/></td>
                              <td title="State"><xsl:value-of select="state/@state"/></td>
                              <td title="Service"><xsl:value-of select="service/@name"/></td>
                              <td title="Reason"><xsl:value-of select="state/@reason"/></td>
                              <td title="Product"><xsl:value-of select="service/@product"/></td>
                              <td title="Version"><xsl:value-of select="service/@version"/></td>
                              <td title="Extra Info"><xsl:value-of select="service/@extrainfo"/></td>
                            </tr>
                          </xsl:when>
                          <xsl:otherwise>
                            <tr class="table-info">
                              <td title="Port"><xsl:value-of select="@portid"/></td>
                              <td title="Protocol"><xsl:value-of select="@protocol"/></td>
                              <td title="State"><xsl:value-of select="state/@state"/></td>
                              <td title="Service"><xsl:value-of select="service/@name"/></td>
                              <td title="Reason"><xsl:value-of select="state/@reason"/></td>
                              <td title="Product"><xsl:value-of select="service/@product"/></td>
                              <td title="Version"><xsl:value-of select="service/@version"/></td>
                              <td title="Extra Info"><xsl:value-of select="service/@extrainfo"/></td>
                            </tr>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:for-each>
                    </tbody>
                  </table>
                </div>
		<h6>Remote Operating System Detection</h6>
  		<xsl:if test="count(os/osmatch) = 0"><p>Unable to identify operating system.</p></xsl:if>
  		<ul>
    		 <xsl:for-each select="os/portused">
      		 <li>Used port: <xsl:value-of select="@portid" />/<xsl:value-of select="@proto" /><xsl:text> </xsl:text><span class="badge badge-secondary"><xsl:value-of select="@state" /></span></li>
    		 </xsl:for-each>
    		  <xsl:for-each select="os/osmatch">
      		  <li>OS match: <xsl:value-of select="@name" /><xsl:text> </xsl:text><span class="badge badge-info"><xsl:value-of select="@accuracy" />%</span></li>
    		  </xsl:for-each>
  		</ul>
                <xsl:if test="count(hostscript/script) > 0">
                <h6>Host Script</h6>
                </xsl:if>
                <xsl:for-each select="hostscript/script">
                  <h6><xsl:value-of select="@id"/></h6>
                  <pre><code><xsl:value-of select="@output"/></code></pre>
                </xsl:for-each>
              </div>
            </div>
          </xsl:for-each>
          <h4 id="openservices" class="target">Open Services</h4>
          <div class="table-responsive">
            <table id="table-services" class="table dataTable" role="grid">
              <thead>
                <tr>
                  <th>Address</th>
                  <th>Port</th>
                  <th>Protocol</th>
                  <th>Service</th>
                  <th>Product</th>
                  <th>Version</th>
                  <th>CPE</th>
                  <th>Extra info</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="/nmaprun/host">
                  <xsl:for-each select="ports/port[state/@state='open']">
                    <tr>
                      <td><xsl:value-of select="../../address/@addr"/><xsl:if test="count(../../hostnames/hostname) > 0"> - <xsl:value-of select="../../hostnames/hostname/@name"/></xsl:if></td>
                      <td><xsl:value-of select="@portid"/></td>
                      <td><xsl:value-of select="@protocol"/></td>
                      <td><xsl:value-of select="service/@name"/></td>
                      <td><xsl:value-of select="service/@product"/></td>
                      <td><xsl:value-of select="service/@version"/></td>
                      <td><xsl:value-of select="service/cpe"/></td>
                      <td><xsl:value-of select="service/@extrainfo"/></td>
                    </tr>
                  </xsl:for-each>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
          <script>
            $(document).ready(function() {
              $('#table-services').DataTable();
            });
          </script>
        </div>
        <footer class="footer">
      		<div class="container">
        		<span class="text-muted">
        			Licensed under <a href="https://creativecommons.org/licenses/by-sa/4.0/">Creative Commons BY-SA</a>.<br/>
              		Based on <a href="https://github.com/honze-net/nmap-bootstrap-xsl">Nmap Bootstrap XSL</a> by Andreas Hontzia (<a href="https://www.twitter.com/honze_net">@honze_net</a>).<br/>
              		Migrated to Bootstrap 4 by <a href="https://github.com/anwiese">Andreas Wiese</a>.<br/>
              	</span>
      		</div>
    	</footer>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
