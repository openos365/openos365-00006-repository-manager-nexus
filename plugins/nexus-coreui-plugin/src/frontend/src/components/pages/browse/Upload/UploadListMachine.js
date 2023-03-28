/*
 * Sonatype Nexus (TM) Open Source Version
 * Copyright (c) 2008-present Sonatype, Inc.
 * All rights reserved. Includes the third-party code listed at http://links.sonatype.com/products/nexus/oss/attributions.
 *
 * This program and the accompanying materials are made available under the terms of the Eclipse Public License Version 1.0,
 * which accompanies this distribution and is available at http://www.eclipse.org/legal/epl-v10.html.
 *
 * Sonatype Nexus (TM) Open Source Version is distributed with Sencha Ext JS pursuant to a FLOSS Exception agreed upon
 * between Sonatype, Inc. and Sencha Inc. Sencha Ext JS is licensed under GPL v3 and cannot be redistributed as part of a
 * closed source work.
 *
 * Sonatype Nexus (TM) Professional Version is available from Sonatype, Inc. "Sonatype" and "Sonatype Nexus" are trademarks
 * of Sonatype, Inc. Apache Maven is a trademark of the Apache Software Foundation. M2eclipse is a trademark of the
 * Eclipse Foundation. All other trademarks are the property of their respective owners.
 */
import Axios from 'axios';
import {assign} from 'xstate';
import {APIConstants, ExtAPIUtils, ListMachineUtils} from '@sonatype/nexus-ui-plugin';

const {EXT: {UPLOAD: {ACTION, METHODS}, REPOSITORY}} = APIConstants;

export default ListMachineUtils.buildListMachine({
  id: 'UploadListMachine',
  sortableFields: ['name', 'format']
}).withConfig({
  actions: {
    setData: assign( (_, {data: [repositories, definitions]}) => {
      const formats = new Set();
      definitions.data.forEach((def) => formats.add(def.format));

      const filteredRepos = repositories.filter((repo) => (
        formats.has(repo.format)
        && repo.type === 'hosted'
        && (repo.status == null || repo.status?.online !== false)
        && repo.versionPolicy !== 'SNAPSHOT'
      ));

      return {
        pristineData: filteredRepos
      }
    }),
    filterData: assign({
      data: ({filter, pristineData}, _) => pristineData.filter(
        ({name, format}) => ListMachineUtils.hasAnyMatches([name, format], filter)
      )
    })
  },
  services: {
    fetchData: () => {
      return Axios.all([
        ExtAPIUtils.extAPIRequest(REPOSITORY.ACTION, REPOSITORY.METHODS.READ_REFERENCES, {})
            .then(ExtAPIUtils.checkForErrorAndExtract),
        ExtAPIUtils.extAPIRequest(ACTION, METHODS.GET_UPLOAD_DEFINITIONS).then(v => v.data.result),
      ])
    },
  }
})
