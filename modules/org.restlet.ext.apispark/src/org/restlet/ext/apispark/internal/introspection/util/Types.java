/**
 * Copyright 2005-2014 Restlet
 * 
 * The contents of this file are subject to the terms of one of the following
 * open source licenses: Apache 2.0 or LGPL 3.0 or LGPL 2.1 or CDDL 1.0 or EPL
 * 1.0 (the "Licenses"). You can select the license that you prefer but you may
 * not use this file except in compliance with one of these Licenses.
 * 
 * You can obtain a copy of the Apache 2.0 license at
 * http://www.opensource.org/licenses/apache-2.0
 * 
 * You can obtain a copy of the LGPL 3.0 license at
 * http://www.opensource.org/licenses/lgpl-3.0
 * 
 * You can obtain a copy of the LGPL 2.1 license at
 * http://www.opensource.org/licenses/lgpl-2.1
 * 
 * You can obtain a copy of the CDDL 1.0 license at
 * http://www.opensource.org/licenses/cddl1
 * 
 * You can obtain a copy of the EPL 1.0 license at
 * http://www.opensource.org/licenses/eclipse-1.0
 * 
 * See the Licenses for the specific language governing permissions and
 * limitations under the Licenses.
 * 
 * Alternatively, you can obtain a royalty free commercial license with less
 * limitations, transferable or non-transferable, directly at
 * http://restlet.com/products/restlet-framework
 * 
 * Restlet is a registered trademark of Restlet S.A.S.
 */

package org.restlet.ext.apispark.internal.introspection.util;

import java.io.File;
import java.lang.reflect.Type;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.restlet.ext.apispark.internal.model.Representation;

/**
 * @author Manuel Boillod
 */
public abstract class Types {

    /** TypeInfo cache. */
    private static final ConcurrentMap<TypeInfoKey, TypeInfo> cache = new ConcurrentHashMap<>();

    private static final List<String> primitivesTypes = Arrays.asList("byte",
            "short", "integer", "long", "float", "double", "boolean", "string",
            "date", "file");

    private static final Map<Class<?>, String> primitiveTypesByClass;

    static {
        primitiveTypesByClass = new HashMap<Class<?>, String>();
        primitiveTypesByClass.put(Byte.TYPE, "byte");
        primitiveTypesByClass.put(Byte.class, "byte");
        primitiveTypesByClass.put(Short.TYPE, "short");
        primitiveTypesByClass.put(Short.class, "short");
        primitiveTypesByClass.put(Integer.TYPE, "integer");
        primitiveTypesByClass.put(Integer.class, "integer");
        primitiveTypesByClass.put(Long.TYPE, "long");
        primitiveTypesByClass.put(Long.class, "long");
        primitiveTypesByClass.put(Float.TYPE, "float");
        primitiveTypesByClass.put(Float.class, "float");
        primitiveTypesByClass.put(Double.TYPE, "double");
        primitiveTypesByClass.put(Double.class, "double");
        primitiveTypesByClass.put(Boolean.TYPE, "boolean");
        primitiveTypesByClass.put(Boolean.class, "boolean");
        primitiveTypesByClass.put(Double.TYPE, "double");
        primitiveTypesByClass.put(Double.class, "double");
        primitiveTypesByClass.put(String.class, "string"); // others types could
                                                           // be considered as
                                                           // string
        primitiveTypesByClass.put(Date.class, "date"); // others types could be
                                                       // considered as date
    }

    public static TypeInfo getTypeInfo(Class<?> clazz, Type type) {
        TypeInfoKey key = new TypeInfoKey(clazz, type);
        TypeInfo typeInfo = cache.get(key);

        if (typeInfo == null) {
            typeInfo = new TypeInfo(clazz, type);
            cache.put(key, typeInfo);
        }
        return typeInfo;
    }

    /**
     * Returns simple type name for primitive type or full name otherwise
     */
    public static String convertPrimitiveType(Class<?> type) {
        String primitiveName = primitiveTypesByClass.get(type);
        if (primitiveName != null) {
            return primitiveName;
        }
        if (CharSequence.class.isAssignableFrom(type)) {
            return "string";
        }
        if (Date.class.isAssignableFrom(type)) {
            return "date";
        }
        if (Representation.class.isAssignableFrom(type)
                || File.class.isAssignableFrom(type)) {
            return "file";
        }
        return type.getSimpleName();
    }

    public static boolean isPrimitiveType(Class<?> type) {
        return (primitiveTypesByClass.get(type) != null
                || CharSequence.class.isAssignableFrom(type)
                || Date.class.isAssignableFrom(type) || Representation.class
                    .isAssignableFrom(type));
    }

    public static boolean isPrimitiveType(String typename) {
        return primitivesTypes.contains(typename);
    }

    public static String toString(Class<?> clazz, Type type) {
        if (type == null) {
            return clazz.toString();
        } else {
            return type.toString();
        }
    }

    private static class TypeInfoKey {

        private final Class<?> clazz;

        private final Type type;

        public TypeInfoKey(Class<?> clazz, Type type) {
            this.clazz = clazz;
            this.type = type;
        }

        @Override
        public boolean equals(Object obj) {
            if (obj instanceof TypeInfoKey) {
                TypeInfoKey that = (TypeInfoKey) obj;
                return Objects.equals(this.clazz, that.clazz)
                        && Objects.equals(this.type, that.type);
            }
            return false;
        }

        @Override
        public int hashCode() {
            return Objects.hash(clazz, type);
        }
    }
}