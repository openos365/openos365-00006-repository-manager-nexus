/*
 * Sonatype Nexus (TM) Open Source Version
 * Copyright (c) 2008-present Sonatype, Inc.
 * All rights reserved. Includes the third-party code listed at http://links.sonatype.com/products/nexus/oss/attributions.
 *
 * This program and the accompanying materials are made available under the terms of the Eclipse Public License Version 1.0,
 * which accompanies this distribution and is available at http://www.eclipse.org/legal/epl-v10.html.
 *
 * Sonatype Nexus (TM) Professional Version is available from Sonatype, Inc. "Sonatype" and "Sonatype Nexus" are trademarks
 * of Sonatype, Inc. Apache Maven is a trademark of the Apache Software Foundation. M2eclipse is a trademark of the
 * Eclipse Foundation. All other trademarks are the property of their respective owners.
 */
package org.sonatype.nexus.repository.content.error;

import java.util.HashMap;
import java.util.Map;

import static java.lang.String.format;

public class MissingAssetException
    extends RuntimeException
{
  private final String assetPath;

  private final boolean isWritableMember;

  private final String repositoryName;

  private final String componentName;

  private final String message;

  public MissingAssetException(
      final String assetPath,
      final boolean isWritableMember,
      final String repositoryName,
      final String componentName)
  {
    this.assetPath = assetPath;
    this.isWritableMember = isWritableMember;
    this.repositoryName = repositoryName;
    this.componentName = componentName;
    this.message = buildMessage();
  }

  private String buildMessage() {
    String message = format("missing asset with path '%s'", assetPath);

    if (isWritableMember) {
      message += ", staging move is not supported if the source is configured as the writable repository for a group repository.";
    }
    return message;
  }

  @Override
  public String getMessage() {
    return message;
  }

  public String getAssetPath() {
    return assetPath;
  }

  public String getComponentName() {
    return componentName;
  }

  public String getRepositoryName() {
    return repositoryName;
  }

  public Map<String, String> getData() {
    Map<String, String> data = new HashMap<>();
    data.put("path", assetPath);
    data.put("component", componentName);
    data.put("repository", repositoryName);

    return data;
  }
}
