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
package org.sonatype.nexus.common.app;

/**
 * List of available feature flags
 * You can change it's values by editing ${data-dir}/nexus.properties configuration file.
 *
 * @since 3.20
 */
public interface FeatureFlags
{
  /* Go (hosted) repository is experimental. Available values: true, false. Default value: false */
  String FEATURE_GOLANG_HOSTED = "nexus.golang.hosted";

  /* Database externalization. Available values: true, false. Default value: false */
  String DATASTORE_ENABLED = "nexus.datastore.enabled";
  String DATASTORE_ENABLED_NAMED = "${nexus.datastore.enabled:-false}";

  /* Database externalization developers only. Available values: true, false. Default value: false */
  String DATASTORE_DEVELOPER = "nexus.datastore.developer";
  String DATASTORE_DEVELOPER_NAMED = "${nexus.datastore.developer:-false}";

  /* Distributed event service. Available values: true, false. Default value: false */
  String DATASTORE_CLUSTERED_ENABLED = "nexus.datastore.clustered.enabled";
  String DATASTORE_CLUSTERED_ENABLED_NAMED = "${nexus.datastore.clustered.enabled:-false}";

  //Enable Datastore search
  String DATASTORE_SEARCH_ENABLED = "nexus.datastore.search.enabled";

  //Enable elastic search
  String ELASTIC_SEARCH_ENABLED = "nexus.elasticsearch.enabled";

  /* Orient flag for marking content that is orient only, and should be disabled when datastore is enabled */
  String ORIENT_ENABLED = "nexus.orient.enabled";

  /* JWT externalization. Available values: true, false. Default value: false */
  String JWT_ENABLED = "nexus.jwt.enabled";

  /* Session flag for marking content that is only for session, and should be disabled when jwt is enabled */
  String SESSION_ENABLED = "nexus.session.enabled";
}
