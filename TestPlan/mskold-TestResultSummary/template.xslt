<?xml version="1.0" encoding="utf-8" ?> <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" >
     <xsl:output method="html" indent="yes" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />    <xsl:template match="/">
          <xsl:for-each select="planAndSuites" >
             <div id="exported-data">
                 <style type="text/css">           .heading {           font-size: 24px;           font-family: 'Segoe UI Light';           font-weight: normal;           margin-top: 15px;           margin-bottom: 15px;           background-color: #f5f5f5;           padding: 1px;           }                      .test-case-heading.heading {           font-size: 20px;           }            .colored-table th{           background-color: #f5f5f5;           }            .table-row-even {           background-color: #f5f5f5;           }            .configuration-variable-style{           padding-right: 2px;           }            a{           color: #007acc;           cursor: pointer;           text-decoration: underline;           }            table{           word-break: break-all; \t        line-height:1;           }           .tab{           font-size: 16px;           font-family:'Segoe UI';           margin-top: 10px;           margin-bottom: 5px;           }            hr{           margin-top: 0px;           }            .sub-tab{           margin-top: 10px;           font-size: 11px;           font-family: 'Segoe UI';           font-weight: bold;           }            body, .body-text {           font-size: 13px;           font-family: 'Segoe UI';           font-weight: normal;           }            .table-style{           width: 100%;           }            .params-table td, .params-table th{           padding-right: 20px;           }                      .shared-param-mapping th{           font-weight: bold;           background-color: white;           }            .property-name, th{           color: grey;           font-weight: normal;           }            .property-name{           color: grey;           font-weight: normal;           min-width: 150px;           }            th{           text-align: left;           }            tr{           vertical-align: top;           font-size: 13px;           font-family: 'Segoe UI';           font-weight: normal;           }            span.property-name{           padding: 3px;           display: inline-block;           }            table td,           td div{           border-spacing: 0px;           display: table-cell;           vertical-align:top;           }            td div p{           vertical-align:top;           margin:0px;           }                      .test-step-attachment{           display:block;           }                      .avoid-page-break{           page-break-inside: avoid;           }          </style>          <xsl:for-each select="testPlan">
                     <div class="heading" _locID="TestPlan">
                         Test plan <xsl:call-template name="url-generator"/>: <xsl:value-of select="@title"/> 
          </div>           <xsl:for-each select="properties">
                         <xsl:if test="*">
                             <div class="tab" _locID="Properties">
                                 Properties                 <hr/> 
              </div>               <xsl:apply-templates select="."/> 
            </xsl:if> 
          </xsl:for-each>           <xsl:for-each select="description">
                         <div class="tab" _locID="Description">
                             Description               <hr/> 
            </div>             <xsl:call-template name="childElementCopy" /> 
          </xsl:for-each>           <xsl:for-each select="suiteHierarchy">
                         <div class="tab" _locID="SuiteHierarchy">
                             Suite hierarchy               <hr/> 
            </div>             <div class="body-text">
                             <xsl:call-template name="suiteHierarchy">
                                 <xsl:with-param name="count">
                                     <xsl:value-of select="0"/> 
                </xsl:with-param> 
              </xsl:call-template> 
            </div> 
          </xsl:for-each>            <xsl:for-each select="configurations">
                         <div class="tab" _locID="Configurations">
                             Configurations               <hr/> 
            </div>             <div class ="sub-tab" _locID="ConfigurationsInThisTestPlan">               CONFIGURATIONS IN TEST PLAN             </div>             <table class="table-style">
                             <tr>
                                 <th width="5%" _locID="Id">Id</th>                 <th width="45%" _locID="Name">Name</th>                 <th width="50%" _locID="ConfigurationVariables">Configuration variables</th> 
              </tr>               <xsl:for-each select="planConfiguration">
                                 <xsl:apply-templates select = "configuration"/> 
              </xsl:for-each> 
            </table>              <xsl:for-each select="additionalConfiguration">
                             <div class ="sub-tab" _locID="AdditionalConfigurations">                 ADDITIONAL CONFIGURATIONS REFERENCED BY CHILD SUITES               </div>               <table class="table-style">
                                 <tr>
                                     <th width="5%" _locID="Id">Id</th>                   <th width="45%" _locID="Name">Name</th>                   <th width="50%" _locID="ConfigurationVariables">Configuration variables</th> 
                </tr>                 <xsl:apply-templates select = "configuration"/> 
              </table> 
            </xsl:for-each> 
          </xsl:for-each>             <xsl:for-each select="testPlanSettings">
                         <div class="tab" _locID="RunSettings">
                             Run settings               <hr/> 
            </div>             <table class="table-style">
                          <tr>
                                 <th></th> \t\t            <th></th> \t
              </tr>               <tr>
                                 <td>
                                     <xsl:for-each select="manualRuns">
                                         <div class ="sub-tab" _locID="ManualRuns">                       MANUAL RUNS                     </div>                     <xsl:apply-templates select = "properties"/> 
                  </xsl:for-each>                   <br /> 
                </td>                 <td>
                                     <xsl:for-each select="automatedRuns">
                                         <div class ="sub-tab" _locID="AutomatedRuns">                       AUTOMATED RUNS                     </div>                    <xsl:apply-templates select = "properties"/> 
                  </xsl:for-each> 
                </td> 
              </tr>               <tr>
                                 <td>
                                     <xsl:for-each select="builds">
                                         <div class="sub-tab" _locID="Build">                       BUILD                     </div>                     <xsl:apply-templates select = "properties"/> 
                  </xsl:for-each> 
                </td> 
              </tr> 
            </table> 
          </xsl:for-each> 
        </xsl:for-each>           <xsl:for-each select="testSuites">
                     <xsl:for-each select="testSuite">
                          <div class="heading" _locID="TestSuite">
                             Test suite <xsl:call-template name="url-generator"/>: <xsl:value-of select="@title"/> 
            </div>              <xsl:for-each select="suiteProperties">
                             <div class="tab" _locID="Properties">
                                 Properties                 <hr/> 
              </div>                 <div>
                                 <xsl:apply-templates select = "properties"/>                 <table class="body-text">
                                     <xsl:for-each select="requirement">
                                         <tr>
                                             <td class="property-name" _locID="Requirement">                         Requirement:                       </td>                       <td>
                                                 <xsl:call-template name="url-generator"/>: <xsl:value-of select="@title"/> 
                      </td> 
                    </tr> 
                  </xsl:for-each>                   <xsl:for-each select="configurations">
                                         <tr>
                                             <td class="property-name" _locID="Configurations">                         Configurations:                       </td>                       <td>
                                                 <xsl:for-each select="configuration">
                                                     <xsl:value-of select="@value"/>                           <xsl:if test="position()!=last()">                             ;                           </xsl:if> 
                        </xsl:for-each> 
                      </td> 
                    </tr> 
                  </xsl:for-each> 
                </table> 
              </div> 
            </xsl:for-each>              <xsl:for-each select="testCases">
                              <div class="tab" _locID="TestCases">
                                 Test cases&#160;(<xsl:value-of select="@count"/>)                 <hr/> 
              </div>                <xsl:for-each select="testCase">
                                 <div class ="test-case-heading heading" _locID="TestCase">
                                     Test case <xsl:call-template name="url-generator"/>: <xsl:value-of select="@title"/> 
                </div>                  <xsl:for-each select="properties">
                                     <xsl:if test="*">
                                         <div class="sub-tab" _locID="Properties">
                                             PROPERTIES                       <br/> 
                    </div>                     <xsl:apply-templates select = "."/> 
                  </xsl:if> 
                </xsl:for-each>                 <xsl:comment>Summary</xsl:comment>                  <xsl:for-each select="summary">
                                     <div class="sub-tab" _locID="Summary">
                                         SUMMARY                     <br/> 
                  </div>                   <div>
                                         <xsl:copy-of select="."/> 
                  </div>                   <br/> 
                </xsl:for-each>                  <xsl:comment>TestSteps</xsl:comment>                  <xsl:for-each select="testSteps">
                                     <div class="avoid-page-break">
                                       <div class="sub-tab" _locID="Steps">
                                           STEPS<br/> 
                    </div>                   <table class="table-style colored-table">
                                           <tr>
                                               <th width="5%" _locID="Number">                         #                       </th>                       <th width ="45%" _locID="Action">                         Action                       </th>                       <th width ="25%" _locID="ExpectedValue">                         Expected value                       </th>                       <th width ="25%" _locID="Attachments">                         Attachments                       </th> 
                      </tr>                     <xsl:for-each select="testStep">
                                               <xsl:variable name="css-class">
                                                   <xsl:choose>
                                                       <xsl:when test="position() mod 2 = 0">table-row-even</xsl:when>                           <xsl:otherwise>table-row-odd</xsl:otherwise> 
                          </xsl:choose> 
                        </xsl:variable>                       <tr class="{$css-class}">
                                                   <td>
                                                       <span>
                                                           <xsl:value-of select="@index"/> 
                            </span> 
                          </td>                         <td>
                                                       <xsl:for-each select="testStepAction">
                                                           <xsl:call-template name="childElementCopy" /> 
                            </xsl:for-each> 
                          </td>                         <td>
                                                       <xsl:for-each select="testStepExpected">
                                                           <xsl:call-template name="childElementCopy" /> 
                            </xsl:for-each> 
                          </td>                         <td>
                                                       <xsl:for-each select="stepAttachments">
                                                           <div class="step-attachments">
                                                               <xsl:call-template name="childElementCopy"/> 
                              </div> 
                            </xsl:for-each> 
                          </td> 
                        </tr> 
                      </xsl:for-each> 
                    </table> 
                  </div> 
                </xsl:for-each>                  <xsl:comment>Parameters</xsl:comment>                  <xsl:for-each select="parameters">
                                     <div class="sub-tab" _locID="Parameters">                     PARAMETERS                   </div>                   <xsl:for-each select="sharedParameterDataSet">
                                         <div class ="sub-tab" _locID="SharedParameter">
                                             Shared parameter <xsl:call-template name="url-generator"/>: <xsl:value-of select="@title"/><br></br> 
                    </div> 
                  </xsl:for-each>                   <table class="params-table colored-table">
                                         <tr class="shared-param-mapping">
                                             <xsl:for-each select="sharedParameterMapping">
                                                 <th>
                                                     <xsl:value-of select="@name"/> 
                        </th> 
                      </xsl:for-each> 
                    </tr>                     <tr>
                                             <xsl:for-each select="parameterFieldName">
                                                 <th>
                                                     <xsl:value-of select="@name"/> 
                        </th> 
                      </xsl:for-each> 
                    </tr>                      <xsl:for-each select="parametersData">
                                             <xsl:variable name="css-class">
                                                 <xsl:choose>
                                                     <xsl:when test="position() mod 2 = 0">table-row-even</xsl:when>                           <xsl:otherwise>table-row-odd</xsl:otherwise> 
                        </xsl:choose> 
                      </xsl:variable>                       <tr class="{$css-class}">
                                                 <xsl:for-each select="parameterFieldData">
                                                     <td>
                                                         <xsl:value-of select="@name"/> 
                          </td> 
                        </xsl:for-each> 
                      </tr> 
                    </xsl:for-each> 
                  </table>  
                </xsl:for-each>                  <xsl:comment>LinksAndAttachements</xsl:comment>                 <xsl:for-each select="linksAndAttachments">
                                     <xsl:for-each select="links">
                                         <div class="sub-tab" _locID="Links">                       LINKS                     </div>                     <table class="table-style">
                                             <tr>
                                                 <th width="5%" _locID="Id">                           ID                         </th>                         <th width="22.5%" _locID="WorkItemType">                           WorkItemType                         </th>                         <th width="22.5%" _locID="LinkType">                           Link type                         </th>                         <th width="50%" _locID="Title">                           Title                         </th> 
                      </tr>                       <xsl:for-each select="link">
                                                 <tr>
                                                     <td>
                                                         <xsl:call-template name="url-generator"/> 
                          </td>                           <td>
                                                         <span>
                                                             <xsl:value-of select="@workItemType"/> 
                            </span> 
                          </td>                           <td>
                                                         <span>
                                                             <xsl:value-of select="@type"/> 
                            </span> 
                          </td>                           <td>
                                                         <span>
                                                             <xsl:value-of select="@title"/> 
                            </span> 
                          </td> 
                        </tr> 
                      </xsl:for-each> 
                    </table>  
                  </xsl:for-each>                    <xsl:for-each select="attachments">
                                         <div class="sub-tab" _locID="Attachments">                       ATTACHMENTS                     </div>                     <table class="table-style">
                                             <tr>
                                                 <th width="28%" _locID="Name">                           Name                         </th>                         <th width="22%" _locID="Size">                           Size                         </th>                         <th width="20%" _locID="DateWhenAttachmentAdded">                           Date Attached                         </th>                         <th width="30%" _locID="Comments">                           Comments                         </th> 
                      </tr>                       <xsl:for-each select="attachment">
                                                 <tr>
                                                     <td>
                                                         <span>
                                                             <a target="_blank">
                                                                 <xsl:attribute name="href">
                                                                     <xsl:value-of select="@url"/> 
                                </xsl:attribute>                                 <xsl:value-of select="@name"/> 
                              </a> 
                            </span> 
                          </td>                           <td>
                                                         <span>
                                                             <xsl:value-of select="@size"/> 
                            </span> 
                          </td>                           <td>
                                                         <span>
                                                             <xsl:value-of select="@date"/> 
                            </span> 
                          </td>                           <td>
                                                         <span>
                                                             <xsl:value-of select="@comments"/> 
                            </span> 
                          </td> 
                        </tr> 
                      </xsl:for-each> 
                    </table> 
                  </xsl:for-each>  
                </xsl:for-each>                  <xsl:comment>Automation</xsl:comment>                  <xsl:for-each select="automation">
                                     <xsl:if test="*">
                                         <div class="sub-tab" _locID="AssociatedAutomation">                       ASSOCIATED AUTOMATION                     </div>                     <xsl:apply-templates select="properties"/> 
                  </xsl:if> 
                </xsl:for-each>                 <xsl:comment>Latest Test Outcome</xsl:comment>                 
                <xsl:for-each select="latestTestOutcomes">
                                     <div class="avoid-page-break">
                                         <div class="sub-tab" _locID="LatestTestOutcome">
                                             LATEST TEST OUTCOME<br/> 
                    </div> 
                  </div>                    <table class="table-style colored-table">
                                         <xsl:for-each select="testResult">
                                             <xsl:if test="position() = 1">
                                                 <xsl:for-each select="properties">
                                                     <tr>
                                                         <xsl:for-each select="property">
                                                             <th>
                                                                 <xsl:value-of select="@name"/> 
                              </th> 
                            </xsl:for-each> 
                          </tr> 
                        </xsl:for-each> 
                      </xsl:if>                       <xsl:variable name="css-class">
                                                 <xsl:choose>
                                                     <xsl:when test="position() mod 2 = 0">table-row-even</xsl:when>                           <xsl:otherwise>table-row-odd</xsl:otherwise> 
                        </xsl:choose> 
                      </xsl:variable>                       <xsl:for-each select="properties">
                                                 <tr class="{$css-class}">
                                                     <xsl:for-each select="property">
                                                         <td>
                                                             <xsl:choose>
                                                                   <xsl:when test="@url != ''">
                                                                         <span>
                                                                            <a target="_blank">
                                                                                 <xsl:attribute name="href">
                                                                                     <xsl:value-of select="@url"/> 
                                      </xsl:attribute>                                           <xsl:value-of select="@value"/> 
                                    </a> 
                                  </span> 
                                </xsl:when>                                   <xsl:otherwise>
                                                                         <xsl:value-of select="@value" /> 
                                </xsl:otherwise> 
                              </xsl:choose> 
                            </td> 
                          </xsl:for-each> 
                        </tr> 
                      </xsl:for-each> 
                    </xsl:for-each> 
                  </table>  
                </xsl:for-each> 
              </xsl:for-each>               <br></br>               <hr></hr> 
            </xsl:for-each> 
          </xsl:for-each> 
        </xsl:for-each> 
      </div> 
    </xsl:for-each> 
  </xsl:template>    <xsl:template name="suiteHierarchy">
         <xsl:param name="count" select="0"/>     <xsl:for-each select="suite">
             <xsl:call-template name="loop">
                 <xsl:with-param name="totalCount">
                     <xsl:value-of select="$count"/> 
        </xsl:with-param> 
      </xsl:call-template>       <xsl:value-of select="@type"/>:&#160;<span>
                 <xsl:value-of select="@title"/> (ID: <xsl:call-template name="url-generator"/>) 
      </span>       <br/>       <xsl:call-template name="suiteHierarchy">
                 <xsl:with-param name="count">
                     <xsl:value-of select="$count+4"/> 
        </xsl:with-param> 
      </xsl:call-template>  
    </xsl:for-each>  
  </xsl:template>    <xsl:template name="loop">
         <xsl:param name="count" select="0"/>     <xsl:param name="totalCount"></xsl:param>     <xsl:if test="($count &lt; $totalCount)">
             &#160;       <xsl:call-template name="loop">
                 <xsl:with-param name="count">
                     <xsl:value-of select="$count + 1"/> 
        </xsl:with-param>         <xsl:with-param name="totalCount">
                     <xsl:value-of select="$totalCount"/> 
        </xsl:with-param> 
      </xsl:call-template> 
    </xsl:if> 
  </xsl:template>     <xsl:template match="configuration">
         <tr>
             <td>
                 <xsl:value-of select="@id"/> 
      </td>       <td>
                 <xsl:value-of select="@value"/> 
      </td>       <td>
                 <xsl:for-each select="variables">
                     <span class="configuration-variable-style">
                         <xsl:value-of select="@name"/>:             <xsl:value-of select="@value"/>             <xsl:if test="position()!=last()">               ;             </xsl:if> 
          </span> 
        </xsl:for-each> 
      </td> 
    </tr> 
  </xsl:template>    <xsl:template match="properties">
         <table class="body-text">
             <xsl:for-each select="property">
                 <tr>
                     <td class="property-name">
                         <xsl:value-of select="@name"/>: 
          </td>           <td>
                         <xsl:value-of select="@value"/> 
          </td> 
        </tr> 
      </xsl:for-each> 
    </table> 
  </xsl:template>    <xsl:template name="url-generator" >
         <a target="_blank">
             <xsl:attribute name="href">
                 <xsl:value-of select="@url"/> 
      </xsl:attribute>       <xsl:value-of select="@id"/> 
    </a> 
  </xsl:template>    <xsl:template name="childElementCopy">
         <xsl:copy-of select="node()"/> 
  </xsl:template>  
</xsl:stylesheet>