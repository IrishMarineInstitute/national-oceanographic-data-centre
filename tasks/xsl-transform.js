var fs = require('fs');
var child_process = require('child_process');
var xsltjs = require('xsltjs');

module.exports = function(grunt) {
	grunt.registerTask('xsl-transform', function(xmlIn, xsl, xmlOut) {
		var done = this.async();
		
		xmlIn = './iso-xml/3677.xml';
		xsl = './xslt/iso2html.xsl';
		xmlOut = './html/ie_marine_data__dataset_3677.html';
		
		fs.readFile(xmlIn, function read(err, data){
			if(err){throw err;}
			const xmlInStrD = data.toString();
			readXsl(xmlInStrD,xsl,xmlOut);
		});
	});
};

function readXsl(xmlInStrD,xsl,xmlOut){
	fs.readFile(xsl, function(err, data){
		if(err){throw err;}
		const xslStrD = data.toString();
		procXML(xmlInStrD,xslStrD,xmlOut);
	});
}

function procXML(xmlInStrD,xslStrD,xmlOutStr){
	
	var xmlOut = "";
	
	const transformSpec = {
		source: xmlInStrD,
		xslt: xslStrD,
		result: xmlOut,
		debug: true,
		logger: null
	};
	
	xsltjs.XSLT.transform(transformSpec, (errorMessage, resultXML) => {
		if (errorMessage) {
			throw new Error(error);
		} else if (resultXML) {
			fs.writeFile(xmlOutStr, resultXML, function write(err){
				if (err) {throw err};
			});
		}
	});
	
	
}