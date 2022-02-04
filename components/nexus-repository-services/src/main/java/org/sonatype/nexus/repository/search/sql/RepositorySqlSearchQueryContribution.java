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
package org.sonatype.nexus.repository.search.sql;

import java.util.Collection;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;

import javax.inject.Inject;
import javax.inject.Named;
import javax.inject.Singleton;

import org.sonatype.nexus.repository.Repository;
import org.sonatype.nexus.repository.group.GroupFacet;
import org.sonatype.nexus.repository.manager.RepositoryManager;
import org.sonatype.nexus.repository.rest.SearchMappings;
import org.sonatype.nexus.repository.search.query.SearchFilter;
import org.sonatype.nexus.repository.types.GroupType;

import static com.google.common.base.Preconditions.checkNotNull;
import static java.lang.String.join;
import static java.util.Optional.ofNullable;
import static java.util.stream.Collectors.toSet;

/**
 * Creates query conditions for the repository_name search term(s) using the leaf repository names.
 *
 * Search terms are split by whitespace.
 *
 * @since 3.next
 */
@Named(RepositorySqlSearchQueryContribution.NAME)
@Singleton
public class RepositorySqlSearchQueryContribution
    extends SqlSearchQueryContributionSupport
{
  public static final String NAME = NAME_PREFIX + "repository_name";

  public static final String SPACE = " ";

  private final RepositoryManager repositoryManager;

  @Inject
  public RepositorySqlSearchQueryContribution(
      final SqlSearchQueryConditionBuilder sqlSearchQueryConditionBuilder,
      final Map<String, SearchMappings> searchMappings,
      final RepositoryManager repositoryManager)
  {
    super(sqlSearchQueryConditionBuilder, searchMappings);
    this.repositoryManager = checkNotNull(repositoryManager);
  }

  @Override
  public void contribute(final SqlSearchQueryBuilder queryBuilder, final SearchFilter searchFilter) {
    ofNullable(searchFilter)
        .map(this::expandRepositories)
        .flatMap(this::buildQueryCondition)
        .ifPresent(queryBuilder::add);
  }

  private SearchFilter expandRepositories(final SearchFilter searchFilter) {
    Set<String> values = split(searchFilter.getValue());
    Set<String> repositories = getLeafMembers(values);
    repositories.addAll(excludeGroupMembers(values));
    return new SearchFilter(searchFilter.getProperty(), join(SPACE, repositories));
  }

  private Set<String> excludeGroupMembers(final Set<String> values) {
    return values.stream()
        .map(repositoryManager::get)
        .filter(Objects::nonNull)
        .filter(this::isNotGroupRepository)
        .map(Repository::getName)
        .collect(toSet());
  }

  private boolean isNotGroupRepository(final Repository repository) {
    return !GroupType.NAME.equals(repository.getType().getValue());
  }

  private Set<String> getLeafMembers(final Set<String> values) {
    return values.stream()
        .map(repositoryManager::get)
        .filter(Objects::nonNull)
        .map(repository -> repository.optionalFacet(GroupFacet.class))
        .filter(Optional::isPresent)
        .map(Optional::get)
        .map(GroupFacet::leafMembers)
        .flatMap(Collection::stream)
        .map(Repository::getName)
        .collect(toSet());
  }
}
