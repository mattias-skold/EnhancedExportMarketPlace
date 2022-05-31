<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" />

	<xsl:template match="/">
		<html>
			<head>
				<meta charset="UTF-8" />
				<meta name='word-properties' data-avdelning="Development" data-category="myCategory" />
				<style>
					.Conversation {display:table;}
					.ConversationItem {display:table-row; }
					.madeBy {display:table-cell; padding:6px; border-bottom:6px solid white;}
					.comment {min-height:50px;display:table-cell; padding:6px; border-bottom:6px solid white;}
					.comment p {margin:0px;}
					.time{display:table-cell;vertical-align:bottom;border-bottom:6px solid white}
					.Part_1 {background-color:lightyellow;}
					.Part_2 {background-color:lightpink;}
					.Part_3 {background-color:aliceblue;}

					body {font-family: 'Segoe UI'; font-size: 11px;}
					.StoryInfo{font-size: '9px';}
					.tag-box{
					margin-left:6 px;
					padding-left: 6px;
					padding-top: 2px;
					padding-right: 6px;
					padding-bottom: 2px;
					font-size: 9px;
					color: #4F4F4F;
					background-color: #d7e6f3;
					}
					h2 {font-size: 22px; margin-bottom:2px;}
					h3 {font-size: 18px; margin-bottom:2px;}
					h4 {font-size: 14px; margin-bottom:2px;}
					th {font-weight:lighter; text-align:left; border-bottom:1px solid lightgrey}

					.SectionHeader {font-weight:bold;}
				</style>
			</head>
			<body>
				<!-- Insert a fake table to force word to load the output as a doc -->
				<table>
					<tr>
						<td></td>
					</tr>
				</table>

				<h1>State transition analytics</h1>
                <hr />

                <h2>Summary</h2>
                <table>
                    <tr>
        				<xsl:for-each select="/result/StateTransitionSummary/StateTransition">
                            <td>
                                <b> <xsl:value-of select="@name"  /> </b><br />
                                <xsl:call-template name="SummaryTbl">
                                    <xsl:with-param name="colPrefix" select="'in'" />
                                </xsl:call-template>
                            </td>
        				</xsl:for-each>          
                    </tr>
                </table>


				<xsl:for-each select="/result/StateTransitionSummary/StateTransition">
                    <xsl:variable name="unit" ><xsl:call-template name="getUnit" /></xsl:variable>
                    <xsl:variable name="unitFactor" ><xsl:call-template name="getFactorForUnit" /></xsl:variable>
					<xsl:variable name="curState" select="@name" />
					<xsl:variable name="toAvg" select="@toStateAvg div $unitFactor" />
					<xsl:variable name="to90Perc" select="@toState90Perc  div $unitFactor" />
					<xsl:variable name="to10Perc" select="@toState10Perc  div $unitFactor" />
					<xsl:variable name="inAvg" select="@inStateAvg  div $unitFactor" />
					<xsl:variable name="in90Perc" select="@inState90Perc  div $unitFactor" />
					<xsl:variable name="in10Perc" select="@inState10Perc  div $unitFactor" />

					<h2>
						 <xsl:value-of select="$curState"  /> State  
					</h2>
					
					<table>
                        <xsl:if test="position()!=1">
                            <tr>
                                <td>
                                    <h3>
                                        Time to <xsl:value-of select="$curState" />  
                                    </h3>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td>
                                    <xsl:call-template name="SummaryTbl">
                                        <xsl:with-param name="colPrefix" select="'to'" />
                                    </xsl:call-template>
                                </td>
                                <td>
                                    <xsl:call-template name="showChart">
                                        <xsl:with-param name="serieName">Time (<xsl:value-of select="$unit" />) to <xsl:value-of select="$curState" /> </xsl:with-param>
                                        <xsl:with-param name="factor" select="$unitFactor" />
                                        <xsl:with-param name="mode" select="'To'" />
                                        <xsl:with-param name="transitions" select = "//workitem/StateTransitions/StateTransition[@name=$curState]" />
                                        <xsl:with-param name="the90Perc" select = "$to90Perc" />
                                        <xsl:with-param name="avg" select = "$toAvg" />
                                        <xsl:with-param name="the10Perc" select = "$to10Perc" />
                                    </xsl:call-template>

                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="position()!=last()">
                            <tr>
                                <td>
                                    <h3>Time in <xsl:value-of select="$curState" /> state</h3> 
                                </td>
                            </tr>

                            <tr valign="top">
                                <td>
                                    <xsl:call-template name="SummaryTbl">
                                        <xsl:with-param name="colPrefix" select = "'in'" />
                                    </xsl:call-template>
                                </td>
                                <td>
                                    <xsl:call-template name="showChart">
                                        <xsl:with-param name="serieName">Time (<xsl:value-of select="$unit" />) in <xsl:value-of select="$curState" /></xsl:with-param>
                                        <xsl:with-param name="factor" select="$unitFactor" />
                                        <xsl:with-param name="mode" select="'In'" />
                                        <xsl:with-param name="transitions" select = "//workitem/StateTransitions/StateTransition[@name=$curState]" />
                                        <xsl:with-param name="the90Perc" select = "$in90Perc" />
                                        <xsl:with-param name="avg" select = "$inAvg" />
                                        <xsl:with-param name="the10Perc" select = "$in10Perc" />
                                    </xsl:call-template>
                                    
                                </td>
                            </tr>
                        </xsl:if>    
    				</table>
				<!--
            
-->
				<h3> Details</h3>
				<table>
					<tr>
						<td>Id</td>
						<td>Title  </td>
						<td>Time to state</td>
						<td>Bussines hours to state</td>
						<td>Time in state</td>
						<td>Bussines hours in state</td>
					</tr>
					<xsl:for-each select="//workitem/StateTransitions/StateTransition[@name=$curState]">
						<tr>
							<td>
								<xsl:value-of select="../../@id"  />
							</td>
							<td>
								<xsl:value-of select="../../System.Title"  />
							</td>
							<td>
								<span class="timeRangeMs">
									<xsl:value-of select="@timeToState"  />
								</span>
							</td>
							<td>
								<span class="timeRangeMs">
									<xsl:value-of select="@businessTimeToState"  />
								</span>
							</td>
							<td>
								<span class="timeRangeMs">
									<xsl:value-of select="@timeInState"  />
								</span>
							</td>
							<td>
								<span class="timeRangeMs">
									<xsl:value-of select="@businessTimeInState"  />
								</span>
							</td>
						</tr>
					</xsl:for-each>
				</table>
				</xsl:for-each>



				<p/>


				<h1>Kanaban column analytics</h1>
                <hr />
              <h2>Summary</h2>
                <table>
                    <tr>
        				<xsl:for-each select="/result/KanbanTransitionSummary/KanbanTransition">
                            <td>
                                <b> <xsl:value-of select="@name"  /> </b>
                                <hr/>
                                <xsl:call-template name="SummaryTbl">
                                    <xsl:with-param name="colPrefix" select="'in'" />
                                </xsl:call-template>
                            </td>
        				</xsl:for-each>          
                    </tr>
                </table>

				<xsl:for-each select="/result/KanbanTransitionSummary/KanbanTransition">
					<xsl:variable name="curState" select="@name" />
                    <xsl:variable name="unit" ><xsl:call-template name="getUnit" /></xsl:variable>
                    <xsl:variable name="unitFactor" ><xsl:call-template name="getFactorForUnit" /></xsl:variable>
					<xsl:variable name="toAvg" select="@toStateAvg" />
					<xsl:variable name="to90Perc" select="@toState90Perc" />
					<xsl:variable name="to10Perc" select="@toState10Perc" />
					<xsl:variable name="inAvg" select="@inStateAvg" />
					<xsl:variable name="in90Perc" select="@inState90Perc" />
					<xsl:variable name="in10Perc" select="@inState10Perc" />

					<h2>
						<xsl:value-of select="$curState" /> column
					</h2>
				
					<table>
                        <xsl:if test="position()!=1">
                            <tr>
                                <td>
                                    <h3>
                                        Time to <xsl:value-of select="$curState" /> column
                                    </h3>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td>
                                    <xsl:call-template name="SummaryTbl">
                                        <xsl:with-param name="colPrefix" select="'to'" />
                                    </xsl:call-template>
                                </td>
                                <td>
                                    <xsl:call-template name="showChart">
                                        <xsl:with-param name="serieName">Time (<xsl:value-of select="$unit" />) to <xsl:value-of select="$curState" /> column</xsl:with-param>
                                        <xsl:with-param name="factor" select="$unitFactor" />
                                        <xsl:with-param name="mode" select="'To'" />
                                        <xsl:with-param name="transitions" select = "//workitem/KanbanTransitions/KanbanTransition[@name=$curState]" />
                                        <xsl:with-param name="the90Perc" select = "$to90Perc" />
                                        <xsl:with-param name="avg" select = "$toAvg" />
                                        <xsl:with-param name="the10Perc" select = "$to10Perc" />
                                    </xsl:call-template>
                                </td>
                            </tr>
                        </xsl:if>
                        <xsl:if test="position()!=last">
                            <tr>
                                <td>
                                    <h3>
                                        Time in <xsl:value-of select="$curState" /> column
                                    </h3>
                                </td>
                            </tr>

                            <tr valign="top">
                                <td>
                                    <xsl:call-template name="SummaryTbl">
                                        <xsl:with-param name="colPrefix" select = "'in'" />
                                    </xsl:call-template>
                                </td>
                                <td>
                                    <xsl:call-template name="showChart">
                                        <xsl:with-param name="serieName">Time ( <xsl:value-of select="$unit" />) in <xsl:value-of select="$curState" /> column</xsl:with-param>
                                        <xsl:with-param name="factor" select="$unitFactor" />
                                        <xsl:with-param name="mode" select="'In'" />
                                        <xsl:with-param name="transitions" select = "//workitem/KanbanTransitions/KanbanTransition[@name=$curState]" />
                                        <xsl:with-param name="the90Perc" select = "$in90Perc" />
                                        <xsl:with-param name="avg" select = "$inAvg" />
                                        <xsl:with-param name="the10Perc" select = "$in10Perc" />
                                    </xsl:call-template>
                                </td>
                            </tr>
                        </xsl:if>
					</table>

					<h3> Details</h3>
					<table>
						<tr>
							<td>Id</td>
							<td>Title  </td>
							<td>Time to state</td>
							<td>Bussines hours to state</td>
							<td>Time in state</td>
							<td>Bussines hours in state</td>
						</tr>
						<xsl:for-each select="//workitem/KanbanTransitions/KanbanTransition[@name=$curState]">
							<tr>
								<td>
									<xsl:value-of select="../../@id"  />
								</td>
								<td>
									<xsl:value-of select="../../System.Title"  />
								</td>
								<td>
									<span class="timeRangeMs">
										<xsl:value-of select="@timeToState"  />
									</span>
								</td>
								<td>
									<span class="timeRangeMs">
										<xsl:value-of select="@businessTimeToState"  />
									</span>
								</td>
								<td>
									<span class="timeRangeMs">
										<xsl:value-of select="@timeInState"  />
									</span>
								</td>
								<td>
									<span class="timeRangeMs">
										<xsl:value-of select="@businessTimeInState"  />
									</span>
								</td>
							</tr>
						</xsl:for-each>
					</table>
				</xsl:for-each>
				<p/>

			</body>
		</html>
	</xsl:template>


 <xsl:template name="showChart">
     <xsl:param name = "serieName" />
     <xsl:param name = "factor" />
     <xsl:param name = "mode" />
     <xsl:param name = "transitions" />
     <xsl:param name = "the90Perc" />
     <xsl:param name = "avg" />
     <xsl:param name = "the10Perc" />
     <xsl:value-of select="$mode" />
    <div class="quickChart" chartType="custom" height="400" width="600" size="150" xAxisTitle="Date" yAxisTitle="InState">
        {
        "hostOptions": {
        "height": 400,
        "width": 600
        },
        "chartType": "hybrid",
        "specializedOptions":{"chartTypes":["scatter"]},
        "title":"HEJ HÅ",
        "xAxis":{
            "labelValues": [<xsl:apply-templates select="$transitions" mode="seriesLabelsOnly" />]
        },
            "yAxis":{             
                <xsl:call-template name="getLabelFormat" />                          
            
            "annotationLines": [
            {
                "labelText": "90th percentil",
                "lineColor": "lightgrey",
                "axisPosition": <xsl:value-of select="$the90Perc" />
            }, 
            {
                "labelText": "Average",
                "lineColor": "lightgrey",
                "axisPosition": <xsl:value-of select="$avg" />
            }, 
            {
                "labelText": "10th percentil",
                "lineColor": "lightgrey",
                "axisPosition": <xsl:value-of select="$the10Perc" />
            }
            ]
        },
        
        "series": [
        {"name":"<xsl:value-of select="$serieName" />", "data":[<xsl:apply-templates select="$transitions" mode="seriesData" ><xsl:with-param name="factor" select="$factor" /><xsl:with-param name="mode" select="$mode" /></xsl:apply-templates>]}									],
        "legend": {
        "enabled": "false",
        "rightAlign": "true"
        }
        }
    </div>
</xsl:template>

    <xsl:template name="getLabelFormat">

        <xsl:if test="@toState90Perc div 3600000 &lt; 100">"labelFormatMode":"numberSeconds_HourMinuteSeconds", </xsl:if>
        <xsl:if test="@toState90Perc div 3600000 &gt; 99"> </xsl:if>
        
    </xsl:template>
    <xsl:template name="getFactorForUnit">
        <xsl:if test="@toState90Perc div 3600000 &lt; 100">1000</xsl:if>
        <xsl:if test="@toState90Perc div 3600000 &gt; 99">86400000</xsl:if>
    </xsl:template>
    
    <xsl:template name="getUnit">
        <xsl:if test="@toState90Perc div 3600000 &lt; 100">hours</xsl:if>
        <xsl:if test="@toState90Perc div 3600000 &gt; 99">days</xsl:if>
    </xsl:template>

	<xsl:template name="SummaryTbl">
		<xsl:param name = "colPrefix" />

		<xsl:variable name="colAvg" ><xsl:value-of select="$colPrefix" />StateAvg</xsl:variable>
		<xsl:variable name="colBHAvg" ><xsl:value-of select="$colPrefix" />StateBHAvg</xsl:variable>

		<xsl:variable name="col90Perc" ><xsl:value-of select="$colPrefix" />State90Perc</xsl:variable>
		<xsl:variable name="colBH90Perc" ><xsl:value-of select="$colPrefix" />StateBH90Perc</xsl:variable>
		<xsl:variable name="col10Perc" ><xsl:value-of select="$colPrefix" />State10Perc</xsl:variable>
		<xsl:variable name="colBH10Perc" ><xsl:value-of select="$colPrefix" />StateBH10Perc</xsl:variable>

		<table>
			<tr>
				<td></td>
				<td>Calender time </td>
				<td>Business hours</td>
			</tr>
			<tr>
				<td>90th  percentile</td>
				<td>
					<span class="timeRangeMs">
                        <xsl:copy-of select="*"  />
						<xsl:value-of select="@*[local-name() = $col90Perc]"  />
					</span>
				</td>
				<td>
					<span class="timeRangeMs">
						<xsl:value-of select="@*[local-name() = $colBH90Perc]"  />
					</span>
				</td>
			</tr>
			<tr>
				<td>Average</td>
				<td>
					<span class="timeRangeMs">
						<xsl:value-of select="@*[local-name() = $colAvg]"/>
					</span>
				</td>
				<td>
					<span class="timeRangeMs">
						<xsl:value-of select="@*[local-name() = $colBHAvg]"  />
					</span>
				</td>
			</tr>
			<tr>
				<td>10th  percentile</td>
				<td>
					<span class="timeRangeMs">
						<xsl:value-of select="@*[local-name() = $col10Perc]"  />
					</span>
				</td>
				<td>
					<span class="timeRangeMs">
						<xsl:value-of select="@*[local-name() = $colBH10Perc]"  />
					</span>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template match="//StateTransition | //KanbanTransition" mode="seriesDataNamed">
		{"x":"<xsl:value-of select="@date" />", "y":<xsl:value-of select="@timeInState div 1000" />}<xsl:if test="position() != last()">,</xsl:if>
	</xsl:template>
	
    <xsl:template match="//StateTransition | //KanbanTransition" mode="seriesDataOld">
		["<xsl:value-of select="@date" />", <xsl:value-of select="@timeInState div 1000" />]<xsl:if test="position() != last()">,</xsl:if>
	</xsl:template>

	<xsl:template match="//StateTransition | //KanbanTransition" mode="seriesDataTimeTo">
 		<xsl:param name = "factor" />
		<xsl:value-of select="@timeToState div $factor" />
		<xsl:if test="position() != last()">,</xsl:if>
	</xsl:template>

	<xsl:template match="//StateTransition | //KanbanTransition" mode="seriesData">
    	<xsl:param name = "factor" />
    	<xsl:param name = "mode" />
        
        <xsl:if test="$mode='To'"><xsl:value-of select="@timeToState div $factor" /></xsl:if>
        <xsl:if test="$mode='In'"><xsl:value-of select="@timeInState div $factor" /></xsl:if>        
		<xsl:if test="position() != last()">,</xsl:if>
	</xsl:template>

	<xsl:template match="//StateTransition | //KanbanTransition" mode="seriesLabelsOnly">
		"<xsl:value-of select="@date" />"<xsl:if test="position() != last()">,</xsl:if>
	</xsl:template>


	<xsl:template match="//tag">
		<span class="tag-box">
			<xsl:value-of select="text()" />
		</span>
	</xsl:template>


	<xsl:template match="//System.Description">

		<xsl:copy-of select="*" />
	</xsl:template>

	<xsl:template match="//Microsoft.VSTS.Common.AcceptanceCriteria">

		<span class="SectionHeader">Acceptance criteria:</span>
		<br/>
		<xsl:copy-of select="*" />
	</xsl:template>



</xsl:stylesheet>
