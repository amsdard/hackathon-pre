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

  <!-- start remove elements section -->
  <xsl:template match="@categories" priority="100"/>

  <xsl:template match="old_process:referenceToModelSource" priority="100"/>
  <xsl:template match="old_process:referenceToProductSystemModel" priority="100"/>
  <xsl:template match="old_process:referenceToRawDataDocumentation" priority="100"/>
  <xsl:template match="old_process:statisticalClassificationCode" priority="100"/>
  <xsl:template match="old_process:LCIMethodPrinciple[preceding-sibling::old_process:LCIMethodPrinciple]" priority="100"/>
  <xsl:template match="old_process:scope[@name='One-point indicator']" priority="100">
    <xsl:call-template name="warn_removal"/>
  </xsl:template>


  <xsl:template match="old_flow:statisticalClassification" priority="100"/>
  <xsl:template match="old_flow:completeness" priority="100"/>
  <xsl:template match="old_flow:nomenclatureAndHierarchyConformity" priority="100"/>
  <xsl:template match="old_flow:methodologicalConformity" priority="100"/>
  <xsl:template match="old_flow:reviewConformity" priority="100"/>
  <xsl:template match="old_flow:documentationConformity" priority="100"/>
  <xsl:template match="old_flow:copyright" priority="100"/>
  <xsl:template match="old_flow:accessRestrictions" priority="100"/>
  <xsl:template match="old_flow:referenceToOriginOfDataSet" priority="100"/>
  <xsl:template match="old_flow:referenceToEntitiesAndPersonsWithExclusiveAccessToThisDataSet" priority="100"/>
  <xsl:template match="old_flow:flowPropertiesAndLCIAFactors" priority="100">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="old_flow:LCIAFactors" priority="100"/>
  <xsl:template match="old_flow:dataDerivationTypeStatus[text()='Missing unimportant']" priority="100">
    <xsl:call-template name="warn_removal"/>
  </xsl:template>
  <xsl:template match="old_flow:dataDerivationTypeStatus[text()='Missing important']" priority="100">
    <xsl:call-template name="warn_removal"/>
  </xsl:template>


  <xsl:template match="old_flowproperty:nomenclatureAndHierarchyConformity" priority="100"/>
  <xsl:template match="old_flowproperty:methodologicalConformity" priority="100"/>
  <xsl:template match="old_flowproperty:reviewConformity" priority="100"/>
  <xsl:template match="old_flowproperty:documentationConformity" priority="100"/>
  <xsl:template match="old_flowproperty:copyright" priority="100"/>
  <xsl:template match="old_flowproperty:accessRestrictions" priority="100"/>
  <xsl:template match="old_flowproperty:validation" priority="100"/>
  <xsl:template match="old_flowproperty:useAdviceForDataSet" priority="100"/>
  <xsl:template match="old_flowproperty:referenceToEntitiesAndPersonsWithExclusiveAccessToThisDataSet" priority="100"/>

  <!-- remove old_flowproperty:modellingAndValidation if it has no children -->
  <xsl:template match="old_flowproperty:modellingAndValidation" priority="100">
    <xsl:if test="not(count(descendant::*)=0)">
      <xsl:element name="modellingAndValidation" namespace="http://lca.jrc.it/ILCD/FlowProperty">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:if>
  </xsl:template>


  <xsl:template match="old_unitgroup:technology" priority="100"/>
  <xsl:template match="old_unitgroup:nomenclatureAndHierarchyConformity" priority="100"/>
  <xsl:template match="old_unitgroup:referenceToOriginOfDataSet" priority="100"/>


  <xsl:template match="old_source:digitalFile" priority="100"/>
  <xsl:template match="old_source:furtherInformation" priority="100">
    <xsl:call-template name="warn_removal"/>
  </xsl:template>


  <xsl:template match="old_contact:telephone[position()>1] | old_contact:telefax[position()>1]" priority="100">
    <xsl:call-template name="warn_removal"/>
  </xsl:template>

  <xsl:template match="old_lciamethod:synonyms" priority="100">
    <xsl:call-template name="warn_removal"/>
  </xsl:template>
  <!-- end remove elements section -->


</xsl:stylesheet>
