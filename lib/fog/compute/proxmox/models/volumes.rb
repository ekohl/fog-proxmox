# frozen_string_literal: true

# Copyright 2018 Tristan Robert

# This file is part of Fog::Proxmox.

# Fog::Proxmox is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Fog::Proxmox is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with Fog::Proxmox. If not, see <http://www.gnu.org/licenses/>.

require 'fog/proxmox/models/collection'
require 'fog/compute/proxmox/models/volume'

module Fog
  module Compute
    class Proxmox
      # class Volumes Collection of volumes
      class Volumes < Fog::Proxmox::Collection
        model Fog::Compute::Proxmox::Volume

        def all(_options = {})
          load_response(service.list_volumes, 'volumes')
        end

        def get(id)
          all
          cached_volume = find { |volume| volume.id == id }
          return cached_volume if cached_volume
        end

        def destroy(id)
          volume = find_by_id(id)
          volume.destroy
        end
      end
    end
  end
end
