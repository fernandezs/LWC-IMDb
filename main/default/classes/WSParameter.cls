public class WSParameter  {
	public String name;
	public Boolean isRequired;
	public Boolean urlEncoding;
	public String value;
	
	public WSParameter(String name, String value, Boolean isRequired) {
		this(name, value, IsRequired, true);
	}

	public WSParameter(String name, String value, Boolean isRequired, Boolean urlEncoding) {
		this.name = name;
		this.isRequired = IsRequired;
		this.value = value;
		this.urlEncoding = urlEncoding;
	}

	public override String toString() {
		if (urlEncoding) {
			return (!String.isBlank(value)) ? EncodingUtil.urlEncode(value, 'UTF-8') : '';
		} else {
			return value;
		}
	}
}