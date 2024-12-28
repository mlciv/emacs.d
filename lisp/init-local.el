(require 'package)
(push '("melpa" . "https://melpa.org/packages/")
      package-archives)
(push '("melpa-stable" . "https://stable.melpa.org/packages/")
      package-archives)
(push '("org" . "https://orgmode.org/elpa/")
      package-archives)
(push '("gnu" . "https://elpa.gnu.org/packages/")
      package-archives)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
    (package-install 'use-package))
(use-package validate   ; Validate options
   :ensure t)
(defalias 'after 'with-eval-after-load)
(normal-erase-is-backspace-mode 1)
(require 'init-functions)
;; for imenu auto completion
;; (require 'helm-config)
(require 'init-evil)
(require 'init-auctex)

;;(add-hook 'python-mode-hook #'flycheck-virtualenv-setup)

(provide 'init-local)
