<?xml version="1.0" encoding="UTF-8"?>
<!-- ILCD Format Version 1.1 Tools Build 1020 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:edoc="http://www.iai.fzk.de/lca/edoc" xmlns:process="http://lca.jrc.it/ILCD/Process"
  xmlns:lciamethod="http://lca.jrc.it/ILCD/LCIAMethod" xmlns:flow="http://lca.jrc.it/ILCD/Flow" xmlns:flowproperty="http://lca.jrc.it/ILCD/FlowProperty"
  xmlns:unitgroup="http://lca.jrc.it/ILCD/UnitGroup" xmlns:source="http://lca.jrc.it/ILCD/Source" xmlns:contact="http://lca.jrc.it/ILCD/Contact"
  xmlns:locations="http://lca.jrc.it/ILCD/Locations" xmlns:categories="http://lca.jrc.it/ILCD/Categories" xmlns:old_process="http://lca.jrc.it/ELCD/Process"
  xmlns:old_lciamethod="http://lca.jrc.it/ELCD/LCIAMethod" xmlns:old_flow="http://lca.jrc.it/ELCD/Flow" xmlns:old_flowproperty="http://lca.jrc.it/ELCD/FlowProperty"
  xmlns:old_unitgroup="http://lca.jrc.it/ELCD/UnitGroup" xmlns:old_source="http://lca.jrc.it/ELCD/Source" xmlns:old_contact="http://lca.jrc.it/ELCD/Contact"
  xmlns:old_locations="http://lca.jrc.it/ELCD/Locations" xmlns:old_categories="http://lca.jrc.it/ELCD/Categories" xmlns:old_common="http://lca.jrc.it/ELCD/Common"
  xmlns:common="http://lca.jrc.it/ILCD/Common" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xml="http://www.w3.org/XML/1998/namespace"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mig="http://iai.fzk.de/lca/ILCD/migrate"
  exclude-result-prefixes="edoc old_process old_lciamethod old_flow old_flowproperty old_unitgroup old_contact old_source old_locations old_categories old_common process lciamethod flow flowproperty unitgroup contact source locations categories common xml xsi xs">

  <xsl:import href="../../stylesheets/common.xsl"/>

  <!-- GlobalReferenceTypeValues -->
  <xsl:template match="@type[starts-with(local-name(parent::*), 'referenceTo') and .='process or LCI result data set']">
    <xsl:attribute name="type">process data set</xsl:attribute>
  </xsl:template>


  <!-- ComplianceValues (previously ConformityValues) -->
  <!-- anything else but 'Fully conform', 'Not conform' and 'Not defined' will be changed to 'Not compliant' -->
  <xsl:template match="*[local-name()='consistencyAndConformity']" priority="90">
    <xsl:variable name="namespace" select="namespace-uri()"/>
    <xsl:variable name="newNamespace">
      <xsl:call-template name="replaceString">
        <xsl:with-param name="string" select="$namespace"/>
        <xsl:with-param name="replace" select="'ELCD'"/>
        <xsl:with-param name="with" select="'ILCD'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:element name="compliance" namespace="{$newNamespace}">
      <xsl:variable name="message">
        <xsl:for-each select="child::*">
          <xsl:if test="text()!='Fully conform' and text()!='Not conform' and text()!='Not defined'">
            <mig:note>Changed value of <xsl:value-of select="local-name()"/> to 'Not compliant', was '<xsl:value-of select="text()"/>'</mig:note>
            <xsl:call-template name="warn">
              <xsl:with-param name="message">Changed value of <xsl:value-of select="local-name()"/> to 'Not compliant', was '<xsl:value-of select="text()"/>'</xsl:with-param>
            </xsl:call-template>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>
      <xsl:apply-templates/>
      <xsl:if test="$message!='' and $preserveIncompatibleData='true'">
        <common:other xmlns:mig="http://iai.fzk.de/lca/ILCD/migrate">
          <xsl:copy-of select="$message"/>
        </common:other>
      </xsl:if>
    </xsl:element>
  </xsl:template>

  <xsl:template
    match="*[parent::*[local-name()='consistencyAndConformity'] and local-name()!='referenceToConformitySystem']/text()[.!='Fully conform' and .!='Not conform' and .!='Not applicable']"
    priority="80">
    <xsl:text>Not compliant</xsl:text>
  </xsl:template>

  <xsl:template match="*[parent::*[local-name()='consistencyAndConformity'] and local-name()!='referenceToConformitySystem']/text()" priority="50">
    <xsl:choose>
      <xsl:when test="contains(., 'conform')">
        <xsl:value-of select="concat(substring-before(., 'conform'), 'compliant', substring-after(., 'conform'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- ComplianceValues (previously ConformityValues) -->


  <!-- DataDerivationTypeStatusValues -->
  <xsl:template match="text()[local-name(parent::*)='dataDerivationTypeStatus' and .='Unknown or mixed derivation']">
    <xsl:text>Unknown derivation</xsl:text>
  </xsl:template>


  <!-- CompletenessTypeValues -->
  <xsl:template match="@type[parent::*[starts-with(local-name(), 'completeness')] and .='Non-renewable material resource consumption']">
    <xsl:attribute name="{name()}">Non-renewable material resource depletion</xsl:attribute>
  </xsl:template>

  <xsl:template match="@type[parent::*[starts-with(local-name(), 'completeness')] and .='Non-renewable primary energy consumption']">
    <xsl:attribute name="{name()}">Non-renewable primary energy depletion</xsl:attribute>
  </xsl:template>

  <xsl:template match="@type[parent::*[starts-with(local-name(), 'completeness')] and .='Seawater ecotoxicity']">
    <xsl:attribute name="{name()}">Seawater eco-toxicity</xsl:attribute>
  </xsl:template>

  <xsl:template match="@type[parent::*[starts-with(local-name(), 'completeness')] and .='Terrestric ecotoxicity']">
    <xsl:attribute name="{name()}">Terrestric eco-toxicity</xsl:attribute>
  </xsl:template>


  <!-- LCIMethodApproachesValues (formerly AllocationOrSystemExpansionPrinciplesValues)-->
  <xsl:template match="text()[local-name(parent::*)='allocationOrSystemExpansionPrinciples' and .='Allocation - 100% to main product']">
    <xsl:text>Allocation - 100% to main function</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='allocationOrSystemExpansionPrinciples' and .='Allocation - explicit assignment']">
    <xsl:text>Allocation - other explicit assignment</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='allocationOrSystemExpansionPrinciples' and .='Substitution - market value corrected']">
    <xsl:text>Substitution - average, market price correction</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='allocationOrSystemExpansionPrinciples' and .='Substitution - technical properties corrected']">
    <xsl:text>Substitution - average, technical properties correction</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='allocationOrSystemExpansionPrinciples' and .='Substitution - recycled content corrected']">
    <xsl:text>Allocation - recycled content</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='allocationOrSystemExpansionPrinciples' and .='Substitution - market average']">
    <xsl:text>Substitution - average, no correction</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='allocationOrSystemExpansionPrinciples' and .='Substitution - recycling average']">
    <xsl:text>Substitution - recycling potential</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='allocationOrSystemExpansionPrinciples' and .='Substitution - market change']">
    <xsl:text>Consequential effects - other</xsl:text>
  </xsl:template>


  <!-- LCIMethodPrincipleValues -->
  <xsl:template match="text()[local-name(parent::*)='LCIMethodPrinciple' and .='Average']">
    <xsl:text>Attributional</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='LCIMethodPrinciple' and .='Change-oriented']">
    <xsl:text>Consequential</xsl:text>
  </xsl:template>


  <!-- PublicationTypeValues -->
  <xsl:template match="text()[local-name(parent::*)='publicationType' and .='Measurement on site']">
    <xsl:text>Direct measurement</xsl:text>
  </xsl:template>


  <!-- TypeOfProcessValues -->
  <xsl:template match="text()[local-name(parent::*)='typeOfDataSet' and .='Unit process, not pre-allocated']">
    <xsl:text>Unit process, single operation</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='typeOfDataSet' and .='Pre-allocated unit process']">
    <xsl:text>Unit process, black box</xsl:text>
  </xsl:template>

  <xsl:template match="text()[local-name(parent::*)='typeOfDataSet' and .='System partly terminated']">
    <xsl:text>Partly terminated system</xsl:text>
  </xsl:template>


  <!-- TypeOfReviewValues -->
  <xsl:template match="@type[local-name(parent::*)='review' and .='Internal review']">
    <xsl:attribute name="{local-name()}">Dependent internal review</xsl:attribute>
  </xsl:template>

  <xsl:template match="@type[local-name(parent::*)='review' and .='Independent third party review']">
    <xsl:attribute name="{local-name()}">Accredited third party review</xsl:attribute>
  </xsl:template>


  <!-- MethodOfReviewValues -->
  <xsl:template match="@name[local-name(parent::*)='method' and .='Re-collection / -validation of raw data']">
    <xsl:attribute name="{local-name()}">Validation of data sources</xsl:attribute>
  </xsl:template>

  <xsl:template match="@name[local-name(parent::*)='method' and .='Re-calculation / -modelling']">
    <xsl:attribute name="{local-name()}">Sample tests on calculations</xsl:attribute>
  </xsl:template>

  <xsl:template match="@name[local-name(parent::*)='method' and .='Cross-check with other dataset']">
    <xsl:attribute name="{local-name()}">Cross-check with other data set</xsl:attribute>
  </xsl:template>


  <!-- ScopeOfReviewValues -->
  <xsl:template match="@name[local-name(parent::*)='scope' and .='Unit process(es)']">
    <xsl:attribute name="{local-name()}">Unit process(es), black box</xsl:attribute>
  </xsl:template>

  <xsl:template match="@name[local-name(parent::*)='scope' and .='LCI results']">
    <xsl:attribute name="{local-name()}">LCI results or Partly terminated system</xsl:attribute>
  </xsl:template>

  <xsl:template match="@name[local-name(parent::*)='scope' and .='LCI method']">
    <xsl:attribute name="{local-name()}">Life cycle inventory methods</xsl:attribute>
  </xsl:template>

  <xsl:template match="@name[local-name(parent::*)='scope' and .='LCIA method']">
    <xsl:attribute name="{local-name()}">LCIA results calculation</xsl:attribute>
  </xsl:template>


</xsl:stylesheet>
