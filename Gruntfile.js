module.exports = function(grunt){
	
	grunt.loadTasks('tasks');
	grunt.registerTask('default',['xsl-transform']);
};