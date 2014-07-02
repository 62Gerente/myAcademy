<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:p="http://xml.di.uminho.pt/paragraph2007" xmlns:t="http://xml.di.uminho.pt/test2014" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" />
    
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4">
                    <fo:region-body margin-top="2.5cm" margin-bottom="2.5cm" />
                    <fo:region-before extent="2cm" />
                    <fo:region-after extent="2cm" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="A4">
               
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block border-bottom="medium solid #2cc0d5" margin="1cm" margin-left="2cm" margin-right="2cm" text-align="right" font="10pt Helvetica-Neue-Light">
                        <fo:inline baseline-shift="-50%">
                            <fo:basic-link external-destination="url('http://0.0.0.0:3000')">
                                <fo:external-graphic content-height="scale-to-fit" content-width="3cm" src="url(public/system/export/template/logo.jpg)" />
                            </fo:basic-link>
                        </fo:inline>
                        <fo:inline baseline-shift="+50%">
                            Resume of
                            <fo:basic-link external-destination="url('http://0.0.0.0:3000/{//teacher/basic_info/username}')" color="#666">
                                <xsl:value-of select="//teacher/basic_info/name" />
                            </fo:basic-link>
                        </fo:inline>
                    </fo:block>
                </fo:static-content>
               
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block border-top="medium solid #2cc0d5" margin-left="2cm" margin-right="2cm" padding-top="0.2cm" text-align="right" font="10pt Helvetica-Neue-Light">
                        <fo:basic-link external-destination="url('http://0.0.0.0:3000/{//teacher/basic_info/username}')" color="#2cc0d5">
                            http://0.0.0.0:3000/
                            <xsl:value-of select="//teacher/basic_info/username" />
                        </fo:basic-link>
                    </fo:block>
                </fo:static-content>
                
                <fo:flow flow-name="xsl-region-body" font="12pt Helvetica-Neue-Light" margin="2.5cm">
                    <xsl:apply-templates />
                </fo:flow>
            </fo:page-sequence>
            
        </fo:root>
    </xsl:template>
    
    <!-- Basic Info -->
    
    <xsl:template match="basic_info">
        <fo:block text-align="left" margin-top="25px">
            <xsl:apply-templates select="//teacher/basic_info/photo" />
            <fo:block margin-left="4.5cm">
                <xsl:apply-templates select="name" />
                <xsl:apply-templates select="birthday" />
                <xsl:apply-templates select="status" />
                <xsl:apply-templates select="institution" />
                <xsl:apply-templates select="phone" />
                <xsl:apply-templates select="email" />
                <xsl:apply-templates select="url" />
            </fo:block>
            <xsl:apply-templates select="bio" />
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="basic_info/photo">
        <fo:inline margin-left="1cm">
            <fo:external-graphic height="0cm" text-align="left" scaling="uniform" scaling-method="resample-any-method" margin-left="3cm" overflow="visible" content-width="3.7cm" src="url({.})" />
        </fo:inline>
    </xsl:template>
    
    
    <xsl:template match="basic_info/name">
        <fo:inline font-size="17pt" font-style="bold" vertical-align="sub">
            <xsl:value-of select="." />
        </fo:inline>
    </xsl:template>
    
    
    <xsl:template match="basic_info/bio">
        <fo:block font="11pt Helvetica-Neue" margin-top="1cm" margin-bottom="0.3cm" text-align="justify">
            <fo:inline font-weight="bold" color="#2cc0d5">Biography: </fo:inline>
            <fo:inline>
                <xsl:value-of select="." />
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="basic_info/status">
        <fo:block font="11pt Helvetica-Neue">
            <fo:inline font-weight="bold" color="#2cc0d5">Status: </fo:inline>
            <fo:inline>
                <xsl:value-of select="." />
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="basic_info/phone">
        <fo:block font="11pt Helvetica-Neue">
            <fo:inline font-weight="bold" color="#2cc0d5">Phone: </fo:inline>
            <fo:inline>
                <xsl:value-of select="." />
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="basic_info/email">
        <fo:block font="11pt Helvetica-Neue">
            <fo:inline font-weight="bold" color="#2cc0d5">Email: </fo:inline>
            <fo:inline>
                <xsl:value-of select="." />
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="basic_info/birthday">
        <fo:block font="11pt Helvetica-Neue">
            <fo:inline font-weight="bold" color="#2cc0d5">Birthday: </fo:inline>
            <fo:inline>
                <xsl:value-of select="." />
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="basic_info/url">
        <fo:block font="11pt Helvetica-Neue">
            <fo:inline font-weight="bold" color="#2cc0d5">URL: </fo:inline>
            <fo:inline>
                <fo:basic-link external-destination="url('{.}')" color="#666">
                    <xsl:value-of select="." />
                </fo:basic-link>
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="basic_info/institution">
        <fo:block font="11pt Helvetica-Neue">
            <fo:inline font-weight="bold" color="#2cc0d5">Institution:</fo:inline>
            <fo:inline>
                <xsl:value-of select="." />
            </fo:inline>
        </fo:block>
    </xsl:template>
    
    
    <!-- Academic Info -->
    
    
    <xsl:template match="academic_info">
        <fo:block font="12pt Helvetica-Neue" margin-right="40%" margin-bottom="1cm" padding="6pt" padding-bottom="1pt" border-bottom="medium solid #2cc0d5">
            <fo:inline baseline-shift="-50%">
                <fo:external-graphic content-height="0.9cm" content-width="scale-to-fit" src="url(public/system/export/template/academic_info.jpg)" />
            </fo:inline>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="course" />
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="course">
        <fo:block font="12pt Helvetica-Neue"  padding="2pt">
            <fo:inline background-color="#10c037" padding="5px" color="#FFF" font-weight="bold"><xsl:value-of select="academic_degree" /></fo:inline>
            <fo:inline> in <xsl:value-of select="course_name" /></fo:inline>
            <fo:inline font="10pt Helvetica-Neue"> ( <xsl:value-of select="b_date" /> - <xsl:value-of select="e_date" /> ) </fo:inline>
            
        </fo:block>
        <fo:block font="10pt Helvetica-Neue" color="#666" padding="4pt" margin-left="0.3cm" margin-bottom="0.5cm">
            Academic degree obtained at <xsl:value-of select="institution" />
        </fo:block>
    </xsl:template>
    
    
    <!-- Hobbies -->
    
    
    <xsl:template match="hobbies">
        <fo:block font="12pt Helvetica-Neue" margin-right="40%" margin-bottom="1cm" padding="6pt" padding-bottom="1pt" border-bottom="medium solid #2cc0d5">
            <fo:inline baseline-shift="-50%">
                <fo:external-graphic content-height="0.9cm" content-width="scale-to-fit" src="url(public/system/export/template/hobbies.jpg)" />
            </fo:inline>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="hobbie" />
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="hobbie">
        <fo:block font="13pt Helvetica-Neue" font-style="bold" color="#10c037" padding="4pt" >
            <xsl:value-of select="activity" />
        </fo:block>
        <fo:block font="9pt Helvetica-Neue" padding="4pt" margin="0.3cm" text-align="justify">
            <xsl:value-of select="description" />
        </fo:block>
    </xsl:template>
    
    
    <!-- Research Projects -->
    
    
    <xsl:template match="research_projects">
        <fo:block font="12pt Helvetica-Neue" margin-right="40%" margin-bottom="1cm" padding="6pt" padding-bottom="1pt" border-bottom="medium solid #2cc0d5">
            <fo:inline baseline-shift="-50%">
                <fo:external-graphic content-height="0.9cm" content-width="scale-to-fit" src="url(public/system/export/template/projects.jpg)" />
            </fo:inline>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="project" />
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="research_projects/project">
        <fo:block font="12pt Helvetica-Neue" font-weight="bold" padding="4pt" margin-top="0.8cm">
            <xsl:value-of select="name" />
        </fo:block>
        <fo:block font="9pt Helvetica-Neue" padding="4pt" text-align="justify">
            <xsl:text>Devolpment: </xsl:text>
            <xsl:value-of select="b_date" />
            <xsl:text> - </xsl:text>
            <xsl:value-of select="e_date" />
            <fo:inline>  |  </fo:inline>
            <fo:basic-link external-destination="url('{url}')" color="#666">
                <xsl:value-of select="url" />
            </fo:basic-link>
        </fo:block>
        <fo:block font="9pt Helvetica-Neue" padding="4pt" text-align="justify">
            <xsl:value-of select="description" />
        </fo:block>
    </xsl:template>
    
    
    <!-- Publications -->
    
    
    <xsl:template match="publications">
        <fo:block font="12pt Helvetica-Neue" margin-right="40%" margin-bottom="1cm" padding="6pt" padding-bottom="1pt" border-bottom="medium solid #2cc0d5">
            <fo:inline baseline-shift="-50%">
                <fo:external-graphic content-height="0.9cm" content-width="scale-to-fit" src="url(public/system/export/template/publications.jpg)" />
            </fo:inline>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="publication" />
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="publications/publication">
        <fo:block font="9pt Helvetica-Neue" padding="4pt" text-align="justify">
            <fo:inline font-weight="bold">
                <xsl:text>[</xsl:text>
                <xsl:value-of select="type" />
                <xsl:text>] </xsl:text>
                <xsl:value-of select="title" />
            </fo:inline>
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="authors" />
            <xsl:value-of select="publisher" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="address" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="chapter" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="pages" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="volume" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="isbn" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="issn" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="booktitle" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="journal" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="number" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="published" />
            <xsl:text>, </xsl:text>
            <xsl:value-of select="school" />
            <xsl:text>, </xsl:text>
            <fo:basic-link external-destination="url('{uri}')" color="#666">
                <xsl:value-of select="uri" />
            </fo:basic-link>
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="publication/authors">
        <xsl:value-of select="author" />
        <xsl:text>, </xsl:text>
    </xsl:template>
    
    
    <!-- Thesis Supervisions -->
    
    
    <xsl:template match="thesis_supervisions">
        <fo:block font="12pt Helvetica-Neue" margin-right="40%" margin-bottom="1cm" padding="6pt" padding-bottom="1pt" border-bottom="medium solid #2cc0d5">
            <fo:inline baseline-shift="-50%">
                <fo:external-graphic content-height="0.9cm" content-width="scale-to-fit" src="url(public/system/export/template/supervisions.jpg)" />
            </fo:inline>
        </fo:block>
        <fo:block>
            <xsl:apply-templates select="supervision" />
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="thesis_supervisions/supervision">
        <fo:block font="9pt Helvetica-Neue" font-weight="bold" padding="4pt" text-align="justify">
            <xsl:value-of select="academic_degree" />
            <xsl:text> :: </xsl:text>
            <xsl:value-of select="title" />
        </fo:block>
        <fo:block font="9pt Helvetica-Neue" padding-left="4pt" text-align="justify" margin-bottom="0.7cm">
            <xsl:value-of select="student" />
            <xsl:text> at </xsl:text>
            <xsl:value-of select="institution" />
            <xsl:text> ( </xsl:text>
            <xsl:value-of select="b_date" />
            <xsl:text> - </xsl:text>
            <xsl:value-of select="e_date" />
            <xsl:text> ) </xsl:text>
        </fo:block>
    </xsl:template>
    
    
    <!-- Thesis Examinations -->
    
    
    <xsl:template match="thesis_examinations">
        <fo:block font="12pt Helvetica-Neue" margin-right="40%" margin-bottom="1cm" padding="6pt" padding-bottom="1pt" border-bottom="medium solid #2cc0d5">
            <fo:inline baseline-shift="-50%">
                <fo:external-graphic content-height="0.9cm" content-width="scale-to-fit" src="url(public/system/export/template/examinations.jpg)" />
            </fo:inline>
        </fo:block>
        <fo:block >
            <xsl:apply-templates select="examination" />
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="thesis_examinations/examination">
        <fo:block font="9pt Helvetica-Neue" font-weight="bold" padding="4pt">
            <xsl:value-of select="academic_degree" />
            <xsl:text> :: </xsl:text>
            <xsl:value-of select="title" />
        </fo:block>
        <fo:block font="9pt Helvetica-Neue" padding-left="4pt" margin-bottom="0.7cm">
            <xsl:value-of select="student" />
            <xsl:text> at </xsl:text>
            <xsl:value-of select="institution" />
            <xsl:text> - </xsl:text>
            <xsl:value-of select="date" />
        </fo:block>
    </xsl:template>
    
    
    <!-- Teaching -->
    
    
    <xsl:template match="teaching">
        <fo:block font="12pt Helvetica-Neue" margin-right="40%" margin-bottom="1cm" padding="6pt" padding-bottom="1pt" border-bottom="medium solid #2cc0d5">
            <fo:inline baseline-shift="-50%">
                <fo:external-graphic content-height="0.9cm" content-width="scale-to-fit" src="url(public/system/export/template/teaching.jpg)" />
            </fo:inline>
        </fo:block>
        <fo:block >
            <xsl:apply-templates select="subject" />
        </fo:block>
    </xsl:template>
    
    
    <xsl:template match="teaching/subject">
        <fo:block font="12pt Helvetica-Neue" font-weight="bold" padding="4pt" margin-top="0.8cm">
            <xsl:value-of select="name" /> (<xsl:value-of select="academic_year" />)
        </fo:block>
        <fo:block font="9pt Helvetica-Neue" padding="4pt">
            <xsl:value-of select="course" /> - <xsl:value-of select="institution" />
        </fo:block>
    </xsl:template>
    
    
</xsl:stylesheet>