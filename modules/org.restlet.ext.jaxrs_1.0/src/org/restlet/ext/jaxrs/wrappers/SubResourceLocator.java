/*
 * Copyright 2005-2008 Noelios Consulting.
 * 
 * The contents of this file are subject to the terms of the Common Development
 * and Distribution License (the "License"). You may not use this file except in
 * compliance with the License.
 * 
 * You can obtain a copy of the license at
 * http://www.opensource.org/licenses/cddl1.txt See the License for the specific
 * language governing permissions and limitations under the License.
 * 
 * When distributing Covered Code, include this CDDL HEADER in each file and
 * include the License file at http://www.opensource.org/licenses/cddl1.txt If
 * applicable, add the following below this CDDL HEADER, with the fields
 * enclosed by brackets "[]" replaced with your own identifying information:
 * Portions Copyright [yyyy] [name of copyright owner]
 */

package org.restlet.ext.jaxrs.wrappers;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.ws.rs.Path;
import javax.ws.rs.WebApplicationException;

import org.restlet.data.Request;
import org.restlet.data.Response;
import org.restlet.ext.jaxrs.core.CallContext;
import org.restlet.ext.jaxrs.exceptions.MissingAnnotationException;
import org.restlet.ext.jaxrs.exceptions.InstantiateParameterException;
import org.restlet.ext.jaxrs.exceptions.InstantiateRessourceException;
import org.restlet.ext.jaxrs.exceptions.NoMessageBodyReadersException;
import org.restlet.ext.jaxrs.exceptions.RequestHandledException;

/**
 * A method of a resource class that is used to locate sub-resources of the
 * corresponding resource, see section 2.3.1.
 * 
 * @author Stephan Koops
 * 
 */
public class SubResourceLocator extends AbstractMethodWrapper implements
        ResourceMethodOrLocator {
    /**
     * Creates a new wrapper for the given sub resource locator.
     * 
     * @param javaMethod
     *                The Java method wich creats the sub resource
     * @param path
     *                the path on the method
     * @param resourceClass
     *                the wrapped resource class.
     */
    public SubResourceLocator(Method javaMethod, Path path,
            ResourceClass resourceClass) {
        super(javaMethod, path, resourceClass);
    }

    /**
     * Creates a sub resource
     * 
     * @param resourceObject
     *                the wrapped resource object.
     * @param callContext
     *                Contains the encoded template Parameters, that are read
     *                from the called URI, the Restlet {@link Request} and the
     *                Restlet {@link Response}.
     * @param jaxRsRouter
     * @return Returns the wrapped sub resource object.
     * @throws InvocationTargetException
     * @throws InstantiateParameterException
     * @throws NoMessageBodyReadersException
     * @throws RequestHandledException
     * @throws WebApplicationException
     * @throws MissingAnnotationException
     * @throws InstantiateRessourceException
     * @throws InstantiateParameterException
     */
    public ResourceObject createSubResource(ResourceObject resourceObject,
            CallContext callContext, HiddenJaxRsRouter jaxRsRouter)
            throws InvocationTargetException, MissingAnnotationException,
            WebApplicationException, RequestHandledException,
            NoMessageBodyReadersException, InstantiateRessourceException,
            InstantiateParameterException {
        Object[] args;
        Class<?>[] parameterTypes = this.javaMethod.getParameterTypes();
        if (parameterTypes.length == 0)
            args = new Object[0];
        else
            args = getParameterValues(parameterTypes, javaMethod
                    .getGenericParameterTypes(), javaMethod
                    .getParameterAnnotations(), leaveEncoded, callContext,
                    jaxRsRouter);
        Object subResObj;
        try {
            subResObj = javaMethod.invoke(resourceObject
                    .getJaxRsResourceObject(), args);
        } catch (IllegalArgumentException e) {
            Class<?> returnType = javaMethod.getReturnType();
            throw new InstantiateRessourceException(returnType, e);
        } catch (IllegalAccessException e) {
            Class<?> returnType = javaMethod.getReturnType();
            throw new InstantiateRessourceException(returnType, e);
        }
        if (subResObj == null) {
            // TESTEN what happens, if sub resource is null? Status 500?
            // TODO JSR311: what happens, if sub resource is null? Status 500?
        }
        return new ResourceObject(subResObj);
    }
}