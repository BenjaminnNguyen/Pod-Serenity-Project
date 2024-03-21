package cucumber.models;

import java.lang.reflect.Field;

public class BaseModel {

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;

		if (o == null || getClass() != o.getClass())
			return false;

		Field[] fields = this.getClass().getDeclaredFields();
		for (Field field : fields) {
			try {
				if (!field.get(this).equals(field.get(o))) {
					return false;
				}
			} catch (IllegalArgumentException | IllegalAccessException e) {
				e.printStackTrace();
				return false;
			}
		}
		return true;
	}

}
