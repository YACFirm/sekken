#This is a fork from savonrb/sekken

With a few enhancements like:

allow local files in schema importer - Mario Manno
if nsid is nil, find the type in the xmlns namespace - dedsm
collect attributes also needs the nil nsid check - dedsm
Support for relative paths - saulm
Improvements on resolver and importer - saulm
Fix error on base_file_path creation - saulm
Resolve includes on XSD - saulm
Add Sabre wsdl/xsd - saulm
fix for Schema imports with N level of nesting. - Andrew Whitmore


Most of this changes were made to support the Sabre SOAP API's
