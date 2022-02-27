/* window.vala
 *
 * Copyright 2022 Otoniel Reyes
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Registry {
	public class Window : Gtk.ApplicationWindow {

		public Window (Gtk.Application app) {
			Object (application: app);

			set_default_size (400, 600);

			var header = new Gtk.HeaderBar () {
			    show_title_buttons = true,
			};
			set_titlebar (header);

			var label = new Gtk.Label ("Hello World!");
			set_child (label);
		}
	}
}
