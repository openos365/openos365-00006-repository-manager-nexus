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
package org.sonatype.nexus.repository.content.fluent.internal;

import java.util.Map;

import org.sonatype.nexus.common.entity.Continuation;
import org.sonatype.nexus.repository.content.fluent.FluentAsset;
import org.sonatype.nexus.repository.content.fluent.FluentQuery;

import static com.google.common.base.Preconditions.checkNotNull;

/**
 * {@link FluentQuery} implementation for {@link FluentAsset}s.
 *
 * @since 3.26
 */
public class FluentAssetQueryImpl
    implements FluentQuery<FluentAsset>
{
  private final FluentAssetsImpl assets;

  private final String kind;

  private final String filter;

  private final Map<String, Object> filterParams;

  FluentAssetQueryImpl(final FluentAssetsImpl assets, final String kind) {
    this.assets = checkNotNull(assets);
    this.kind = checkNotNull(kind);
    this.filter = null;
    this.filterParams = null;
  }

  FluentAssetQueryImpl(final FluentAssetsImpl assets,
                       final String filter,
                       final Map<String, Object> filterParams)
  {
    this.assets = checkNotNull(assets);
    this.kind = null;
    this.filter = checkNotNull(filter);
    this.filterParams = checkNotNull(filterParams);
  }

  @Override
  public int count() {
    return assets.doCount(kind, filter, filterParams);
  }

  @Override
  public Continuation<FluentAsset> browse(final int limit, final String continuationToken) {
    return assets.doBrowse(limit, continuationToken, kind, filter, filterParams);
  }
}
