(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5034d4b3ebd327bbdc1bbf925b6bf7e4dfbe4f3f84ee4d21e154143f128c6e04" default))
 '(safe-local-variable-values
   '((eval setq bibtex-completion-bibliography
      (concat
       (projectile-project-root)
       "/ce-group-assignment.bib"))
     (eval setq bibtex-completion-bibliography
      (concat
       (projectile-project-root)
       "/ucs.bib"))
     (eval setq bibtex-completion-bibliography
      (concat
       (projectile-project-root)
       "/resources/bep.bib"))))
 '(warning-suppress-types
   '((org-element-cache)
     (before-save-hook)
     (before-save-hook)
     (after-init-hook)
     (after-init-hook))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:slant italic))))
 '(font-lock-keyword-face ((t (:slant italic)))))
