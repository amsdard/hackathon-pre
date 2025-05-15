<?xml version="1.0" encoding="UTF-8"?>
<!-- ILCD Format Version 1.1 Tools Build 1020 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:edoc="http://www.iai.fzk.de/lca/edoc" xmlns:process="http://lca.jrc.it/ILCD/Process" xmlns:lciamethod="http://lca.jrc.it/ILCD/LCIAMethod" xmlns:flow="http://lca.jrc.it/ILCD/Flow" xmlns:flowproperty="http://lca.jrc.it/ILCD/FlowProperty"
   xmlns:unitgroup="http://lca.jrc.it/ILCD/UnitGroup" xmlns:source="http://lca.jrc.it/ILCD/Source" xmlns:contact="http://lca.jrc.it/ILCD/Contact" xmlns:locations="http://lca.jrc.it/ILCD/Locations" xmlns:categories="http://lca.jrc.it/ILCD/Categories" xmlns:old_process="http://lca.jrc.it/ELCD/Process"
   xmlns:old_lciamethod="http://lca.jrc.it/ELCD/LCIAMethod" xmlns:old_flow="http://lca.jrc.it/ELCD/Flow" xmlns:old_flowproperty="http://lca.jrc.it/ELCD/FlowProperty" xmlns:old_unitgroup="http://lca.jrc.it/ELCD/UnitGroup" xmlns:old_source="http://lca.jrc.it/ELCD/Source" xmlns:old_contact="http://lca.jrc.it/ELCD/Contact"
   xmlns:old_locations="http://lca.jrc.it/ELCD/Locations" xmlns:old_categories="http://lca.jrc.it/ELCD/Categories" xmlns:old_common="http://lca.jrc.it/ELCD/Common" xmlns:common="http://lca.jrc.it/ILCD/Common" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xml="http://www.w3.org/XML/1998/namespace"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mig="http://iai.fzk.de/lca/ILCD/migrate"
   exclude-result-prefixes="edoc old_process old_lciamethod old_flow old_flowproperty old_unitgroup old_contact old_source old_locations old_categories old_common process lciamethod flow flowproperty unitgroup contact source locations categories xml xsi xs">

   <xsl:import href="../../stylesheets/common.xsl"/>

   <!-- start move elements to common namespace section -->
   <xsl:template
      match="*[
      local-name()='UUID' or 
      local-name()='shortName' or 
      local-name()='synonyms' or 
      local-name()='dataSetVersion' or 
      local-name()='permanentDataSetURI' or 
      local-name()='referenceToPersonOrEntityEnteringTheData' or 
      local-name()='referenceToOwnershipOfDataSet' or 
      local-name()='referenceToPrecedingDataSetVersion' or 
      local-name()='copyright' or 
      local-name()='referenceToEntitiesAndPersonsWithExclusiveAccessToThisDataSet' or 
      local-name()='referenceToPersonOrEntityGeneratingTheDataSet' or 
      local-name()='referenceToDataSetFormat' or 
      local-name()='accessRestrictions' or 
      local-name()='workflowAndPublicationStatus' or 
      local-name()='scope' or 
      local-name()='method' or 
      local-name()='referenceToNameOfReviewerAndInstitution' or 
      local-name()='referenceToCompleteReviewReport' or 
      local-name()='otherReviewDetails'  or 
      local-name()='commissionerAndGoal' or 
      (local-name(parent::*)='dataGenerator' and 
      local-name()!='referenceToFateAndEffectModel' and 
      local-name()!='referenceToProductSystemModel') or 
      local-name(parent::*)='dataEntryBy' or 
      local-name(parent::*)='publicationAndOwnership' or 
      local-name(parent::*)='consistencyAndConformity' or 
      (local-name()='generalComment' and parent::*=/*/*[1]/*[1]) or 
      name()='old_flowproperty:name' or
      name()='old_unitgroup:name' or
      name()='old_source:name' or
      name()='old_contact:name' or
      (local-name()='name' and not(local-name(/*)='processOrLCIResultDataSet') and not(local-name(/*)='flowDataSet') and parent::*=/*/*[1]/*[1])]"
      priority="50">
      <xsl:element name="common:{local-name()}" namespace="http://lca.jrc.it/ILCD/Common">
         <xsl:apply-templates select="@*|text()"/>
         <xsl:apply-templates select="child::*"/>
      </xsl:element>
   </xsl:template>
   <!-- end move elements to common namespace section -->

   

</xsl:stylesheet>
