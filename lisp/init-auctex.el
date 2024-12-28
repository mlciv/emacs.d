;;; LaTeX with AUCTeX
(setq-default TeX-master nil)
(use-package tex-site                   ; AUCTeX initialization
  :ensure auctex)

(use-package tex                        ; TeX editing/processing
  :ensure auctex
  :defer t
  :config
  (validate-setq
   TeX-parse-self t                     ; Parse documents to provide completion
                                        ; for packages, etc.
   TeX-auto-save t                      ; Automatically save style information
   TeX-electric-sub-and-superscript t   ; Automatically insert braces after
                                        ; sub- and superscripts in math mode
   ;;;TeX-electric-math '("\\(" . "\\)")
   ;; Don't insert magic quotes right away.
   TeX-quote-after-quote t
   ;; Don't ask for confirmation when cleaning
   TeX-clean-confirm nil
   ;; Provide forward and inverse search with SyncTeX
   TeX-source-correlate-mode t
   TeX-source-correlate-method 'synctex)
  (setq-default TeX-master nil          ; Ask for the master file
                TeX-engine 'default ;luatex will cause the section style not correct, Use a modern engine
                ;; Redundant in 11.88, but keep for older AUCTeX
                TeX-PDF-mode t)


  ;; Move to chktex
  (setcar (cdr (assoc "Check" TeX-command-list)) "chktex -v6 %s"))


(use-package tex-buf                    ; TeX buffer management
  :ensure auctex
  :defer t
  ;; Don't ask for confirmation when saving before processing
  :config (validate-setq TeX-save-query nil))


(use-package tex-style                  ; TeX style
  :ensure auctex
  :defer t
  :config
  ;; Enable support for csquotes
  (validate-setq LaTeX-csquotes-close-quote "}"
                 LaTeX-csquotes-open-quote "\\enquote{"))


(use-package tex-fold                   ; TeX folding
  :ensure auctex
  :defer t
  :init (add-hook 'TeX-mode-hook #'TeX-fold-mode))


(use-package tex-mode                   ; TeX mode
  :ensure auctex
  :defer t
  :config
  (font-lock-add-keywords 'latex-mode
                          `((,(rx "\\"
                                  symbol-start
                                  "fx" (1+ (or (syntax word) (syntax symbol)))
                                  symbol-end)
                             . font-lock-warning-face))))


(use-package latex                      ; LaTeX editing
  :ensure auctex
  :defer t
  :config
  ;;; Teach TeX folding about KOMA script sections
  ;(validate-setq
  ; TeX-outline-extra `((,(rx (0+ space) "\\section*{") 2)
  ;                     (,(rx (0+ space) "\\subsection*{") 3)
  ;                     (,(rx (0+ space) "\\subsubsection*{") 4)
  ;                     (,(rx (0+ space) "\\minisec{") 5))
  ; ;; No language-specific hyphens please
  ; LaTeX-babel-hyphen "")


  (add-hook 'LaTeX-mode-hook #'LaTeX-math-mode)) ; Easy math input


(use-package auctex-latexmk             ; latexmk command for AUCTeX
  :ensure t
  :defer t
  :after latex
  :config (auctex-latexmk-setup))


(use-package auctex-skim                ; Skim as viewer for AUCTeX
  :load-path "lisp/"
  :commands (auctex-skim-select)
  :after tex
  :config (auctex-skim-select))


(use-package bibtex                     ; BibTeX editing
  :defer t
  :config
  ;; Run prog mode hooks for bibtex
  (add-hook 'bibtex-mode-hook (lambda () (run-hooks 'prog-mode-hook)))

  ;; Use a modern BibTeX dialect
  (bibtex-set-dialect 'biblatex))

(use-package reftex                     ; TeX/BibTeX cross-reference management
  :defer t
  :init (add-hook 'LaTeX-mode-hook #'reftex-mode)
  :config
  (setq
   reftex-plug-into-AUCTeX t
   ;; Automatically derive labels, and prompt for confirmation
   reftex-insert-label-flags '(t t))
  ;; Provide basic RefTeX support for biblatex
;; (unless (assq 'biblatex reftex-cite-format-builtin)
;;    (add-to-list 'reftex-cite-format-builtin
;;                 '(biblatex "The biblatex package"
;;                            ((?\C-m . "\\cite[]{%l}")
;;                             (?t . "\\textcite{%l}")
;;                             (?a . "\\autocite[]{%l}")
;;                             (?p . "\\parencite{%l}")
;;                             (?f . "\\footcite[][]{%l}")
;;                             (?F . "\\fullcite[]{%l}")
;;                             (?x . "[]{%l}")
;;                             (?X . "{%l}"))))
;;    (validate-setq reftex-cite-format 'biblatex))
:diminish reftex-mode)

(provide 'init-auctex)
