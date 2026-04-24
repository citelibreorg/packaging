<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="site-path" select="site-path" />
<xsl:template match="page[page-level=0]">
<div class="container my-5 main-site-map">
    <div class="row">
        <div class="col">
            <ul class="list-unstyled site-map-level-one">
                <li>
                    <a href="{$site-path}?page_id=1" target="_top">
                        <i class="fa fa-home">&#160;</i> Home
                    </a>
                </li>
                <li>
                    <a href="jsp/site/Portal.jsp?page=forms&amp;view=stepView&amp;id_form=1&amp;init=true" target="_top">
                        Report a problem
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
</xsl:template>
</xsl:stylesheet>