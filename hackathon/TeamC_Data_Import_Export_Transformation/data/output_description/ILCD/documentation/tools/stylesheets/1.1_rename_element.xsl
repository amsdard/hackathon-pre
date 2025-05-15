<?xml version="1.0" encoding="UTF-8"?>
<!-- ILCD Format Version 1.1 Tools Build 1020 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:edoc="http://www.iai.fzk.de/lca/edoc" xmlns:process="http://lca.jrc.it/ILCD/Process" xmlns:lciamethod="http://lca.jrc.it/ILCD/LCIAMethod" xmlns:flow="http://lca.jrc.it/ILCD/Flow" xmlns:flowproperty="http://lca.jrc.it/ILCD/FlowProperty"
   xmlns:unitgroup="http://lca.jrc.it/ILCD/UnitGroup" xmlns:source="http://lca.jrc.it/ILCD/Source" xmlns:contact="http://lca.jrc.it/ILCD/Contact" xmlns:locations="http://lca.jrc.it/ILCD/Locations" xmlns:categories="http://lca.jrc.it/ILCD/Categories" xmlns:old_process="http://lca.jrc.it/ELCD/Process"
   xmlns:old_lciamethod="http://lca.jrc.it/ELCD/LCIAMethod" xmlns:old_flow="http://lca.jrc.it/ELCD/Flow" xmlns:old_flowproperty="http://lca.jrc.it/ELCD/FlowProperty" xmlns:old_unitgroup="http://lca.jrc.it/ELCD/UnitGroup" xmlns:old_source="http://lca.jrc.it/ELCD/Source" xmlns:old_contact="http://lca.jrc.it/ELCD/Contact"
   xmlns:old_locations="http://lca.jrc.it/ELCD/Locations" xmlns:old_categories="http://lca.jrc.it/ELCD/Categories" xmlns:old_common="http://lca.jrc.it/ELCD/Common" xmlns:common="http://lca.jrc.it/ILCD/Common" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xml="http://www.w3.org/XML/1998/namespace"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mig="http://iai.fzk.de/lca/ILCD/migrate"
   exclude-result-prefixes="edoc old_process old_lciamethod old_flow old_flowproperty old_unitgroup old_contact old_source old_locations old_categories old_common process lciamethod flow flowproperty unitgroup contact source locations categories common xml xsi xs">

   <xsl:import href="../../stylesheets/common.xsl"/>

   <!-- start rename elements section -->
   <xsl:template name="renameElement">
      <xsl:param name="newName"/>
      <xsl:param name="newNameSpaceURI">
         <xsl:choose>
            <xsl:when test="starts-with($newName, 'common:')">
               <xsl:value-of select="'http://lca.jrc.it/ILCD/Common'"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="replaceString">
                  <xsl:with-param name="string" select="namespace-uri()"/>
                  <xsl:with-param name="replace" select="'ELCD'"/>
                  <xsl:with-param name="with" select="'ILCD'"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:param>
      <xsl:param name="applyTemplates" select="true()"/>
      <xsl:param name="content"/>

      <xsl:element name="{$newName}" namespace="{$newNameSpaceURI}">
         <xsl:apply-templates select="@*"/>
         <xsl:if test="string-length($content)>0">
            <xsl:copy-of select="$content"/>
         </xsl:if>
         <xsl:if test="$applyTemplates='true'">
            <xsl:apply-templates/>
         </xsl:if>
      </xsl:element>
   </xsl:template>


   <xsl:template name="copyElement">
      <xsl:param name="applyTemplates" select="true()"/>
      <xsl:param name="content"/>
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="local-name()"/>
         <xsl:with-param name="applyTemplates" select="$applyTemplates"/>
         <xsl:with-param name="content" select="$content"/>
      </xsl:call-template>
   </xsl:template>


   <!-- global renames -->
   <xsl:template match="*[local-name()='consistencyAndConformity']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'compliance'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='consistencyAndConformityDeclarations']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'complianceDeclarations'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='referenceToConformitySystem']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:referenceToComplianceSystem'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='approvalOfOverallConformity']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:approvalOfOverallCompliance'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='nomenclatureAndHierarchyConformity']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:nomenclatureCompliance'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='methodologicalConformity']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:methodologicalCompliance'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='reviewConformity']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:reviewCompliance'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='documentationConformity']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:documentationCompliance'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='dateAndTimeCompleted']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:timeStamp'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='timeRepresentativityDescription']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:timeRepresentativenessDescription'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='dataSetUseApproval']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:referenceToDataSetUseApproval'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='referenceToOriginOfDataSet']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:referenceToConvertedOriginalDataSetFrom'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='referenceToEntitiesAndPersonsWithExclusiveAccessToThisDataSet']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:referenceToEntitiesWithExclusiveAccess'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='intendedApplication']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'intendedApplications'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='referenceToPublication']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'common:referenceToUnchangedRepublication'"/>
      </xsl:call-template>
   </xsl:template>

   <!-- process -->
   <xsl:template match="*[local-name()='processOrLCIResultInformation' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'processInformation'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='technologyDescriptionAndIncludedProcessesAndLCIResults' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'technologyDescriptionAndIncludedProcesses'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='referenceToIncludedProcessesAndLCIResults' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'referenceToIncludedProcesses'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='mixTypeAndLocation' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'mixAndLocationTypes'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='typeOfEmissionSource' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'identifierOfSubDataSet'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='functionalUnitProductionPeriodOrOtherParameter' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'functionalUnitOrOther'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='deviationFromLCIMethodPrinciple' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'deviationsFromLCIMethodPrinciple'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='allocationOrSystemExpansionPrinciples' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'LCIMethodApproaches'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='deviationsFromAllocationOrSystemExpansionPrinciplesExplanations' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'deviationsFromLCIMethodApproaches'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='deviationFromModellingConstants' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'deviationsFromModellingConstants'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='referenceToLCIMethodAndAllocationPrinciplesAndModellingConstantsDetails' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'referenceToLCAMethodDetails'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='referenceToDataCompletenessSelectionCombinationTreatmentAndExtrapolationsPrinciplesDetails' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'referenceToDataHandlingPrinciples'"/>
      </xsl:call-template>
   </xsl:template>
   
   <xsl:template match="*[local-name()='referenceToLCAMethodAndAllocationPrinciplesAndModellingConstantsDetails' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'referenceToLCAMethodDetails'"/>
      </xsl:call-template>
   </xsl:template>
   
   <xsl:template match="*[local-name()='referenceToExternalDocumentationFilesSource' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'referenceToExternalDocumentation'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='dataCompletenessPrinciples' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'dataCutOffAndCompletenessPrinciples'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='deviationFromDataCompletenessPrinciples' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'deviationsFromCutOffAndCompletenessPrinciples'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='deviationFromDataSelectionAndCombinationPrinciples' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'deviationsFromSelectionAndCombinationPrinciples'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='deviationFromDataTreatmentAndExtrapolationsPrinciples' and namespace-uri()='http://lca.jrc.it/ELCD/Process']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'deviationsFromTreatmentAndExtrapolationPrinciples'"/>
      </xsl:call-template>
   </xsl:template>

   <!-- flow -->
   <xsl:template match="*[local-name()='mixTypeAndLocation' and namespace-uri()='http://lca.jrc.it/ELCD/Flow']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'mixAndLocationTypes'"/>
      </xsl:call-template>
   </xsl:template>

   <!-- contact -->
   <xsl:template match="*[local-name()='logo' and (namespace-uri()='http://lca.jrc.it/ELCD/Contact' or namespace-uri()='http://lca.jrc.it/ELCD/Source')]" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'referenceToLogo'"/>
      </xsl:call-template>
   </xsl:template>

   <xsl:template match="*[local-name()='furtherInformation' and namespace-uri()='http://lca.jrc.it/ELCD/Contact']" priority="80">
      <xsl:call-template name="renameElement">
         <xsl:with-param name="newName" select="'contactDescriptionOrComment'"/>
      </xsl:call-template>
   </xsl:template>
  
  <!-- lciamethod --> 
  <xsl:template match="*[local-name()='LCIAMethodFlowDiagrammOrPicture' and namespace-uri()='http://lca.jrc.it/ELCD/LCIAMethod']" priority="80">
    <xsl:element name="referenceToLCIAMethodFlowDiagrammOrPicture" namespace="http://lca.jrc.it/ILCD/LCIAMethod"/>
    <xsl:call-template name="warn">
      <xsl:with-param name="message">Dropping contents '<xsl:value-of select="text()"/>' from LCIAMethodFlowDiagrammOrPicture, type has changed to common:GlobalReferenceType</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  
  <!-- end rename elements section -->


</xsl:stylesheet>
