<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	
	<xsl:template match="photoorder">
		<html>
			<head>
				<LINK REL="stylesheet" TYPE="text/css" HREF="css/photoorder.css" />
			</head>
			<body>
			<div>
				<h1>Orders</h1>
				<xsl:apply-templates select="order">
					<xsl:sort select="customeremail" />
					<xsl:sort select="photourl" />
				</xsl:apply-templates>
				</div>
				<div>
				<h1>Users</h1>
				<xsl:apply-templates select="pouser">
					<xsl:sort select="group" />
					<xsl:sort select="email" />
				</xsl:apply-templates>
				</div>
				<div>
				<h1>Photos</h1>
				<xsl:apply-templates select="pophoto">
					<xsl:sort select="album" />
					<xsl:sort select="photourl" />
				</xsl:apply-templates>
				</div>
				<div>
				<h1>Albums</h1>
				<xsl:apply-templates select="poalbum">
					<xsl:sort select="groupid" />
				</xsl:apply-templates>
				</div>
				<div>
				<h1>Groups</h1>
				<xsl:apply-templates select="pogroup">
				</xsl:apply-templates>
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="order">
		<div class="card">
			<div class="cardhead">
				<xsl:value-of select="customeremail" />
			</div>
			<div class="cardbody">
				<xsl:apply-templates select="*" />
			</div>
		</div>
	</xsl:template>
	
	
	
	<xsl:template match="order/*">
		<xsl:choose>

			<xsl:when test="name()='email'">
			</xsl:when>
			<xsl:when test="name()='photourl'">
			<xsl:element name="img">
			<xsl:attribute name="src">
			<xsl:value-of select="." />
			</xsl:attribute>
			</xsl:element>
			</xsl:when>
			
			
			<xsl:otherwise>
				<br />
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<xsl:template match="pouser">
		<div class="card">
			<div class="cardhead">
				<xsl:value-of select="email" />
			</div>
			<div class="cardbody">
				<xsl:apply-templates select="*" />
			</div>
		</div>
	</xsl:template>
	<xsl:template match="pouser/*">
		<xsl:choose>

			<xsl:when test="name()='email'">
			</xsl:when>
			<xsl:otherwise>
				<br />
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<xsl:template match="pophoto">
		<div class="card">
			<div class="cardhead">
				<xsl:value-of select="album" />
			</div>
			<div class="cardbody">
				<xsl:apply-templates select="*" />
			</div>
		</div>
	</xsl:template>
	<xsl:template match="pophoto/*">
				<xsl:choose>
				
			<xsl:when test="name()='photourl'">
			<xsl:element name="img">
			<xsl:attribute name="src">
			<xsl:value-of select="." />
			</xsl:attribute>
			</xsl:element>
			</xsl:when>
			
			
			<xsl:otherwise>
				<br />
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	
	
	
	

<xsl:template match="poalbum">
		<div class="card">
			<div class="cardhead">
				<xsl:value-of select="name" />
			</div>
			<div class="cardbody">
				<xsl:apply-templates select="*" />
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="poalbum/*">
				<xsl:choose>
			<xsl:when test="name()='name'"></xsl:when>
			<xsl:otherwise>
				<br />
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<xsl:template match="pogroup">
		<div class="card">
			<div class="cardhead">
				<xsl:value-of select="name" />
			</div>
			<div class="cardbody">
				<xsl:apply-templates select="*" />
			</div>
		</div>
	</xsl:template>	
	<xsl:template match="pogroup/*">
				<xsl:choose>
			<xsl:when test="name()='name'"></xsl:when>
			<xsl:otherwise>
				<br />
				<xsl:value-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



</xsl:stylesheet>