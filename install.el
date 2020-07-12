(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(package-install 'smex)
(package-install 'multiple-cursors)
(package-install 'company)
(package-install 'eglot)
(package-install 'tabbar)
(package-install 'gruber-darker-theme)
(package-install 's)
(package-install 'dash)

(package-install 'all-the-icons)
(require 'all-the-icons)
(all-the-icons-install-fonts)