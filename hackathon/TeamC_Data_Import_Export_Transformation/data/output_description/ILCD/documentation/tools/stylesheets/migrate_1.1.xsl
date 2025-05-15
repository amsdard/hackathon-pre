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
  exclude-result-prefixes="edoc old_process old_lciamethod old_flow old_flowproperty old_unitgroup old_contact old_source old_locations old_categories old_common process lciamethod flow flowproperty unitgroup contact source locations categories xml xsi xs">

  <!-- priorities:
      
         remove  100
         move     90
         rename   80
    
      -->

  <xsl:include href="../../stylesheets/common.xsl"/>

  <xsl:include href="1.1_move_element.xsl"/>
  <xsl:include href="1.1_rename_element.xsl"/>
  <xsl:include href="1.1_remove_element.xsl"/>
  <xsl:include href="1.1_rename_enum.xsl"/>
  <xsl:include href="1.1_map_categories.xsl"/>


  <xsl:output indent="yes" method="xml"/>
  <xsl:strip-space elements="*"/>

  <xsl:param name="disableVersionCheck" select="false()"/>
  <xsl:param name="targetLanguage" select="en"/>
  <xsl:param name="preserveIncompatibleData" select="false()"/>

  <xsl:param name="dontMapCategories" select="false()"/>

  <xsl:variable name="oldVersion" select="'1.0.1'"/>
  <xsl:variable name="newVersion" select="'1.1'"/>

  <xsl:variable name="newVersionFormatSourceDatasetUUID" select="'a97a0155-0234-4b87-b4ce-a45da52f2a40'"/>
  <xsl:variable name="newVersionFormatSourceDatasetVersion" select="'01.00.000'"/>
  <xsl:variable name="newVersionFormatSourceDatasetURI" select="'../sources/ILCD_Format_a97a0155-0234-4b87-b4ce-a45da52f2a40_01.00.000.xml'"/>
  <xsl:variable name="newVersionFormatSourceDatasetDescription" select="'ILCD format'"/>

  <xsl:variable name="newVersionComplianceSourceDatasetUUID" select="'88d4f8d9-60f9-43d1-9ea3-329c10d7d727'"/>
  <xsl:variable name="newVersionComplianceSourceDatasetVersion" select="'01.00.000'"/>
  <xsl:variable name="newVersionComplianceSourceDatasetURI" select="'../sources/ILCD_Compliance_88d4f8d9-60f9-43d1-9ea3-329c10d7d727_01.00.000.xml'"/>
  <xsl:variable name="newVersionComplianceSourceDatasetDescription" select="'ILCD compliance'"/>


  <xsl:variable name="rootElement">
    <xsl:call-template name="replaceString">
      <xsl:with-param name="string" select="local-name(/*)"/>
      <xsl:with-param name="replace" select="'ELCD'"/>
      <xsl:with-param name="with" select="'ILCD'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="schemaPathPrefix">
    <xsl:call-template name="getSchemaPath">
      <xsl:with-param name="rootElement" select="$rootElement"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="schemaName">
    <xsl:call-template name="replaceString">
      <xsl:with-param name="string">
        <xsl:call-template name="getSchemaName">
          <xsl:with-param name="rootElement" select="$rootElement"/>
        </xsl:call-template>
      </xsl:with-param>
      <xsl:with-param name="replace" select="'ProcessOrLCIResultDataSet'"/>
      <xsl:with-param name="with" select="'ProcessDataSet'"/>
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:variable name="isElementaryFlow">
    <xsl:call-template name="isElementaryFlow"/>
  </xsl:variable>
  


  <!-- start ELCD -> ILCD transformation section -->
  <xsl:template match="*">
    <xsl:if test=". != '' or ./@* != ''">
      <xsl:variable name="prefix">
        <xsl:if test="namespace-uri()='http://lca.jrc.it/ELCD/Common' or namespace-uri()='http://lca.jrc.it/ILCD/Common'">common:</xsl:if>
      </xsl:variable>
      <xsl:variable name="namespace" select="namespace-uri()"/>
      <xsl:variable name="newNamespace">
        <xsl:call-template name="replaceString">
          <xsl:with-param name="string" select="$namespace"/>
          <xsl:with-param name="replace" select="'ELCD'"/>
          <xsl:with-param name="with" select="'ILCD'"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="newName">
        <xsl:choose>
          <xsl:when test="local-name()='processOrLCIResultDataSet'">processDataSet</xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="local-name()"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:element name="{$prefix}{$newName}" namespace="{$newNamespace}">

        <xsl:if test="count(ancestor::*)=0">
          <xsl:copy-of select="document('namespace.xml')/root/namespace::common"/>

          <!-- add metaDataOnly attribute to process datasets -->
          <xsl:if test="local-name()=$PROCESS">
            <xsl:attribute name="metaDataOnly">false</xsl:attribute>
          </xsl:if>

        </xsl:if>

        <xsl:apply-templates select="@*"/>

        <xsl:apply-templates select="*|text()"/>

      </xsl:element>
    </xsl:if>
  </xsl:template>


  <xsl:template match="@xsi:schemaLocation">
    <!-- root node - add schemalocation -->
    <xsl:variable name="namespace" select="namespace-uri(parent::*)"/>
    <xsl:variable name="newNamespace">
      <xsl:call-template name="replaceString">
        <xsl:with-param name="string" select="$namespace"/>
        <xsl:with-param name="replace" select="'ELCD'"/>
        <xsl:with-param name="with" select="'ILCD'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:attribute name="schemaLocation" namespace="http://www.w3.org/2001/XMLSchema-instance">
      <xsl:value-of select="$newNamespace"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="$schemaPathPrefix"/>
      <xsl:value-of select="$schemaName"/>
    </xsl:attribute>
  </xsl:template>


  <xsl:template match="@categories|@locations">
    <xsl:attribute name="{name()}">
      <xsl:call-template name="replaceString">
        <xsl:with-param name="string" select="."/>
        <xsl:with-param name="replace" select="'ELCD'"/>
        <xsl:with-param name="with" select="'ILCD'"/>
      </xsl:call-template>
    </xsl:attribute>
  </xsl:template>


  <!-- format reference -->

  <!-- remove existing reference to ELCD 1.0.1 -->
  <xsl:template
    match="*[local-name()='referenceToDataSetFormat']
      [contains(translate(@uri,'ABCDEF','abcdef'),'677ec646-b50b-4efe-9580-5c9a1a0102fb') or 
      contains(translate(@uri,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'elcd_format_1_0_1') or 
      translate(@refObjectId,'ABCDEF','abcdef')='677ec646-b50b-4efe-9580-5c9a1a0102fb']"
    priority="200"/>

  <!-- insert reference to ILCD 1.1 -->
  <xsl:template match="*[local-name()='dataEntryBy']">
    <xsl:variable name="newNameSpace">
      <xsl:call-template name="replaceString">
        <xsl:with-param name="string" select="namespace-uri()"/>
        <xsl:with-param name="replace" select="'ELCD'"/>
        <xsl:with-param name="with" select="'ILCD'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:element name="dataEntryBy" namespace="{$newNameSpace}">
      <xsl:apply-templates select="*[local-name()='dateAndTimeCompleted']"/>
      <xsl:element name="common:referenceToDataSetFormat" namespace="http://lca.jrc.it/ILCD/Common">
        <xsl:attribute name="type">source data set</xsl:attribute>
        <xsl:attribute name="uri">
          <xsl:value-of select="$newVersionFormatSourceDatasetURI"/>
        </xsl:attribute>
        <xsl:attribute name="refObjectId">
          <xsl:value-of select="$newVersionFormatSourceDatasetUUID"/>
        </xsl:attribute>
        <xsl:attribute name="version">
          <xsl:value-of select="$newVersionFormatSourceDatasetVersion"/>
        </xsl:attribute>
        <xsl:element name="common:shortDescription" namespace="http://lca.jrc.it/ILCD/Common">
          <xsl:value-of select="$newVersionFormatSourceDatasetDescription"/>
        </xsl:element>
      </xsl:element>
      <xsl:apply-templates select="*[local-name()!='dateAndTimeCompleted']"/>
    </xsl:element>
  </xsl:template>


  <!-- compliance reference -->

  <!-- insert reference to ILCD 1.1 compliance -->
  <xsl:template
    match="*[local-name()='consistencyAndConformity'][child::*[local-name()='referenceToConformitySystem' and (contains(translate(@uri,'ABCDEF','abcdef'),'9c85162d-6c43-4bc7-bbb3-03e0c8b262b9') or 
    contains(translate(@uri,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'elcd_conformity_1_0_1') or translate(@refObjectId,'ABCDEF','abcdef')='9c85162d-6c43-4bc7-bbb3-03e0c8b262b9')]]"
    priority="1000">
    <xsl:variable name="newNameSpace">
      <xsl:call-template name="replaceString">
        <xsl:with-param name="string" select="namespace-uri()"/>
        <xsl:with-param name="replace" select="'ELCD'"/>
        <xsl:with-param name="with" select="'ILCD'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:element name="compliance" namespace="{$newNameSpace}">
      <xsl:element name="common:referenceToComplianceSystem" namespace="http://lca.jrc.it/ILCD/Common">
        <xsl:attribute name="type">source data set</xsl:attribute>
        <xsl:attribute name="uri">
          <xsl:value-of select="$newVersionComplianceSourceDatasetURI"/>
        </xsl:attribute>
        <xsl:attribute name="refObjectId">
          <xsl:value-of select="$newVersionComplianceSourceDatasetUUID"/>
        </xsl:attribute>
        <xsl:attribute name="version">
          <xsl:value-of select="$newVersionComplianceSourceDatasetVersion"/>
        </xsl:attribute>
        <xsl:element name="common:shortDescription" namespace="http://lca.jrc.it/ILCD/Common">
          <xsl:value-of select="$newVersionComplianceSourceDatasetDescription"/>
        </xsl:element>
      </xsl:element>
      <xsl:apply-templates select="*[local-name()!='referenceToConformitySystem']"/>
    </xsl:element>
  </xsl:template>
  <!-- end ELCD -> ILCD transformation section -->



  <!-- start add multilang section -->
  <xsl:template match="*[local-name()='locationOfSupply' and namespace-uri()='http://lca.jrc.it/ELCD/Flow']" priority="80">
    <xsl:element name="locationOfSupply" namespace="http://lca.jrc.it/ILCD/Flow">
      <xsl:attribute name="lang" namespace="http://www.w3.org/XML/1998/namespace">
        <xsl:value-of select="$targetLanguage"/>
      </xsl:attribute>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[local-name()='centralContactPoint' and namespace-uri()='http://lca.jrc.it/ELCD/Contact']" priority="80">
    <xsl:element name="centralContactPoint" namespace="http://lca.jrc.it/ILCD/Contact">
      <xsl:attribute name="lang" namespace="http://www.w3.org/XML/1998/namespace">
        <xsl:value-of select="$targetLanguage"/>
      </xsl:attribute>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[local-name()='contactAddress' and namespace-uri()='http://lca.jrc.it/ELCD/Contact']" priority="80">
    <xsl:element name="contactAddress" namespace="http://lca.jrc.it/ILCD/Contact">
      <xsl:attribute name="lang" namespace="http://www.w3.org/XML/1998/namespace">
        <xsl:value-of select="$targetLanguage"/>
      </xsl:attribute>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="node()"/>
    </xsl:element>
  </xsl:template>
  <!-- end add multilang section -->



  <!-- start classification section -->
  <xsl:template match="*[local-name()='categoryInformation']">
    <xsl:variable name="classificationElementName">
      <xsl:choose>
        <xsl:when test="$isElementaryFlow='true'">elementaryFlowCategorization</xsl:when>
        <xsl:otherwise>classification</xsl:otherwise>
      </xsl:choose>      
    </xsl:variable>
    
    <xsl:call-template name="renameElement">
      <xsl:with-param name="newName" select="'classificationInformation'"/>
      <xsl:with-param name="applyTemplates" select="false()"/>
      <xsl:with-param name="content">
        <xsl:element name="{concat('common:',$classificationElementName)}" namespace="http://lca.jrc.it/ILCD/Common">
          <xsl:if test="/*/@categories!='../ELCDCategories.xml' and $isElementaryFlow!='true'">
            <xsl:attribute name="classes">
              <xsl:call-template name="replaceString">
                <xsl:with-param name="string" select="/*/@categories"/>
                <xsl:with-param name="replace" select="'ELCD'"/>
                <xsl:with-param name="with" select="'ILCD'"/>
              </xsl:call-template>
            </xsl:attribute>
          </xsl:if>
          <xsl:apply-templates select="child::*"/>
        </xsl:element>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="*[local-name()='category']">
    <!-- if dontMapCategories switch is true, just copy categories with new syntax, otherwise map them using the default mapping -->
    <xsl:variable name="classElementName">
      <xsl:choose>
        <xsl:when test="$isElementaryFlow='true'">category</xsl:when>
        <xsl:otherwise>class</xsl:otherwise>
      </xsl:choose>      
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$dontMapCategories='true' or $isElementaryFlow='true'">
        <xsl:element name="{concat('common:',$classElementName)}" namespace="http://lca.jrc.it/ILCD/Common">
          <xsl:copy-of select="@*"/>
          <xsl:copy-of select="text()"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="mapCategories">
          <xsl:with-param name="level" select="@level"/>
          <xsl:with-param name="catName" select="text()"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>
  <!-- end classification section -->



  <!-- start variableParameter section -->
  <xsl:template match="old_process:variableParameter">
    <xsl:element name="variableParameter" namespace="http://lca.jrc.it/ILCD/Process">
      <xsl:attribute name="name">
        <xsl:value-of select="@variableParameter"/>
      </xsl:attribute>
      <xsl:apply-templates select="@formula"/>
      <xsl:apply-templates select="@meanValue"/>
      <xsl:apply-templates select="@minimumValue"/>
      <xsl:apply-templates select="@maximumValue"/>
      <xsl:apply-templates select="@uncertaintyDistributionType"/>
      <xsl:apply-templates select="@relativeStandardDeviation95In"/>
      <xsl:apply-templates select="@comment"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="old_process:variableParameter/@*[local-name()!='name']">
    <xsl:element name="{local-name()}" namespace="http://lca.jrc.it/ILCD/Process">
      <xsl:if test="local-name()='comment'">
        <xsl:attribute name="lang" namespace="http://www.w3.org/XML/1998/namespace">
          <xsl:value-of select="$targetLanguage"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
  <!-- end variableParameter section -->




  <!-- start review details consolidation section -->
  <xsl:key name="lang" match="old_process:reviewDetailsOnTechnicalContent | old_process:reviewDetailsOnImpactCoverage | old_process:reviewDetailsOnLCIAMethod" use="@xml:lang"/>

  <xsl:template match="*[local-name()='review']">
    <xsl:call-template name="copyElement">
      <xsl:with-param name="applyTemplates" select="false()"/>
      <xsl:with-param name="content">

        <xsl:apply-templates select="old_process:scope"/>

        <xsl:for-each
          select="*[local-name()='reviewDetailsOnTechnicalContent' or local-name()='reviewDetailsOnImpactCoverage' or local-name()='reviewDetailsOnLCIAMethod'][generate-id() = generate-id(key('lang',@xml:lang))]">
          <xsl:element name="common:reviewDetails" namespace="http://lca.jrc.it/ILCD/Common">
            <xsl:attribute name="xml:lang" namespace="http://www.w3.org/XML/1998/namespace">
              <xsl:value-of select="@xml:lang"/>
            </xsl:attribute>
            <xsl:variable name="lang" select="@xml:lang"/>
            <xsl:for-each
              select="../*[local-name()='reviewDetailsOnTechnicalContent' or local-name()='reviewDetailsOnImpactCoverage' or local-name()='reviewDetailsOnLCIAMethod'][@xml:lang=$lang]">
              <xsl:choose>
                <xsl:when test="local-name()='reviewDetailsOnTechnicalContent'">
                  <xsl:text>Inventory: </xsl:text>
                </xsl:when>
                <xsl:when test="local-name()='reviewDetailsOnImpactCoverage'">
                  <xsl:text>Documentation: </xsl:text>
                </xsl:when>
                <xsl:when test="local-name()='reviewDetailsOnLCIAMethod'">
                  <xsl:text>LCI Method: </xsl:text>
                </xsl:when>
              </xsl:choose>
              <xsl:value-of select="text()"/>
              <xsl:if test="not(position()=last())">
                <xsl:text>; </xsl:text>
              </xsl:if>
            </xsl:for-each>
          </xsl:element>

        </xsl:for-each>

        <xsl:apply-templates select="old_process:referenceToNameOfReviewerAndInstitution"/>
        <xsl:apply-templates select="old_process:otherReviewDetails"/>
        <xsl:apply-templates select="old_process:referenceToCompleteReviewReport"/>

      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- end review details consolidation section -->



  <!-- start reorder elements section -->
  <!-- contact -->
  <xsl:template match="old_contact:contactDataSet/old_contact:contactInformation/old_contact:dataSetInformation" priority="100">
    <xsl:element name="dataSetInformation" namespace="http://lca.jrc.it/ILCD/Contact">
      <xsl:choose>
        <xsl:when test="old_contact:referenceToContact">
          <xsl:apply-templates select="*[following-sibling::*[local-name()='referenceToContact'] and local-name()!='furtherInformation' and local-name()!='referenceToContact']"/>
          <xsl:apply-templates select="old_contact:furtherInformation"/>
          <xsl:apply-templates select="old_contact:referenceToContact"/>
          <xsl:apply-templates select="*[preceding-sibling::*[local-name()='referenceToContact'] and local-name()!='furtherInformation']"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <!-- source -->
  <xsl:template match="old_source:sourceDataSet/old_source:sourceInformation/old_source:dataSetInformation" priority="100">
    <xsl:element name="dataSetInformation" namespace="http://lca.jrc.it/ILCD/Source">
      <xsl:choose>
        <xsl:when test="old_source:sourceCitation">
          <xsl:apply-templates select="*[following-sibling::*[local-name()='sourceCitation'] and local-name()!='categoryInformation']"/>
          <xsl:apply-templates select="old_source:categoryInformation"/>
          <xsl:apply-templates select="old_source:sourceCitation"/>
          <xsl:apply-templates select="*[preceding-sibling::*[local-name()='sourceCitation'] and local-name()!='categoryInformation']"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  <!-- end reorder elements in contact dataset section -->



  <!-- start handle previous extensions section -->
  <xsl:template match="old_common:formatExtensions">
    <xsl:element name="common:other">
      <xsl:apply-templates mode="copy"/>
    </xsl:element>
  </xsl:template>
  <!-- end handle previous extensions section -->



  <!-- start CAS number reformat section -->
  <xsl:template match="*[local-name()='CASNumber']/text()">
    <xsl:choose>
      <xsl:when test="contains(., '-')">
        <xsl:variable name="block1">
          <xsl:call-template name="addLeadingZeros">
            <xsl:with-param name="string" select="substring-before(.,'-')"/>
            <xsl:with-param name="length" select="6"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="concat($block1, '-', substring-after(., '-'))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="addLeadingZeros">
    <xsl:param name="string"/>
    <xsl:param name="length"/>
    <xsl:choose>
      <xsl:when test="string-length($string)=number($length)">
        <xsl:value-of select="$string"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="addLeadingZeros">
          <xsl:with-param name="string" select="concat('0',$string)"/>
          <xsl:with-param name="length" select="$length"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- end CAS number reformat section -->



  <!-- start categories/locations section -->
  <!-- wrap categories into categorization tags -->
  <!--   <xsl:template match="*[local-name()='categoryInformation']">
      <xsl:copy-of select="@*|text()"/>
      <xsl:element name="common:{local-name()}" namespace="http://lca.jrc.it/ILCD/Common">
         <xsl:element name="common:categorization" namespace="http://lca.jrc.it/ILCD/Common">
            <xsl:apply-templates select="child::*"/>
         </xsl:element>
      </xsl:element>
   </xsl:template>
-->
  <xsl:template match="old_categories:ELCDCategories" priority="100">
    <xsl:element name="CategorySystem" namespace="http://lca.jrc.it/ILCD/Categories">
      <xsl:apply-templates select="@*|child::*"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="old_locations:ELCDLocations" priority="100">
    <xsl:element name="ILCDLocations" namespace="http://lca.jrc.it/ILCD/Locations">
      <xsl:apply-templates select="@*|child::*"/>
    </xsl:element>
  </xsl:template>
  <!-- end categories/locations section -->




  <!-- generic section -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- copy -->
  <xsl:template match="*" mode="copy">
    <xsl:copy>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="processing-instruction()">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>



  <xsl:template match="@version[name(parent::*)=name(/*)]">
    <!--
        <xsl:if test="string(.)!=$oldVersion and $disableVersionCheck='false'">
            <xsl:message terminate="yes">Invalid schema version found in input document: <xsl:value-of select="."/> found, <xsl:value-of select="$oldVersion"/> expected.
            Aborting.</xsl:message>
        </xsl:if>
        -->
    <xsl:attribute name="version">
      <xsl:value-of select="$newVersion"/>
    </xsl:attribute>
  </xsl:template>




</xsl:stylesheet>
