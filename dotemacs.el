;; local load path 
(add-to-list 'load-path "~/elisp")
(progn (cd "~/elisp") (normal-top-level-add-subdirs-to-load-path))

;; no splash screen
(setq inhibit-splash-screen t)

;; identity
(setq user-full-name "Kieran Healy")
(setq user-mail-address "kjhealy@gmail.com")
(setq mail-host-address "gmail.com")

;; Auto fill mode --- automatic line wrapping.
(add-hook 'text-mode-hook
  '(lambda () (auto-fill-mode 1))) 

;; Color Theme
(require 'color-theme)
(color-theme-initialize)
(load-file "~/elisp/custom-color-themes.el")
(color-theme-twilighter)

;;(setq my-exec-path '("/usr/texbin" "/usr/local/bin" "/Applications/Emacs.app/Contents/Resources/bin"))
;;(map 'nil '(lambda (item) (setq exec-path (cons item exec-path))) my-exec-path)
;;(setenv "PATH" (mapconcat 'identity exec-path path-separator))

;; magit
;; (require 'magit)

;; DVC (another alternative to VC/magit)
(load-file "~/elisp/dvc/dvc-load.el") 
(require 'dvc-autoloads)

;; AUCTeX
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;; ESS
(load "~/elisp/ess/lisp/ess-site.el")

;; R-noweb mode, for Sweave.
 (defun Rnw-mode ()
   (require 'ess-noweb)
   (noweb-mode)
   (if (fboundp 'R-mode)
       (setq noweb-default-code-mode 'R-mode)))

 (add-to-list 'auto-mode-alist '("\\.Rnw\\'" . Rnw-mode))
 (add-to-list 'auto-mode-alist '("\\.Snw\\'" . Rnw-mode))

 (setq reftex-file-extensions
       '(("Snw" "Rnw" "nw" "tex" ".tex" ".ltx") ("bib" ".bib")))
 (setq TeX-file-extensions
       '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))

(add-hook 'LaTeX-mode-hook
          (function (lambda ()
                      (add-to-list 'LaTeX-command-style
                                   '("\\`fontspec\\'" "xelatex %S%(PDFout)"))
                      )
                    )     
)
  (autoload 'reftex-mode     "reftex" "RefTeX Minor Mode" t)
  (autoload 'turn-on-reftex  "reftex" "RefTeX Minor Mode" nil)
  (autoload 'reftex-citation "reftex-cite" "Make citation" nil)
  (autoload 'reftex-index-phrase-mode "reftex-index" "Phrase mode" t)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
  (add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode

;; Make RefTeX faster
   (setq reftex-enable-partial-scans t)
   (setq reftex-save-parse-info t)
   (setq reftex-use-multiple-selection-buffers t)
   (setq reftex-plug-into-AUCTeX t)

;; Make RefTex able to find my local bib files
   (setq reftex-bibpath-environment-variables
      '("/Users/kjhealy/Documents/bibs/"))

;; RefTex format for biblatex
(setq reftex-cite-format 
  '((?\C-m . "\\cite[]{%l}") 
   (?t    . "\\textcite[]{%l}") 
   (?p    . "\\parencite[]{%l}") 
   (?o    . "\\citepr[]{%l}") 
   (?n    . "\\nocite{%l}"))) 
(setq reftex-cite-prompt-optional-args t) 

; put as much syntax highlighting into documents as possible
(require 'font-lock)

; (global-font-lock-mode 3)
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1); Emacs
  (setq font-lock-auto-fontify t)); XEmacs

;;name and path of file in title bar
(setq frame-title-format '("%S:" (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; PDF mode for latex
'(TeX-PDF-mode t)

;; misc
; Make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

; turn on recent files menu
(require 'recentf)
(recentf-mode 1)

; use cocoAspell instead of ispell
(setq ispell-program-name "~/Library/PreferencePanes/Spelling.prefPane/Contents/MacOS/cocoAspell")

;; ispell --- make ispell skip \citep, \citet etc in .tex files.
(setq ispell-tex-skip-alists
  '((;;("%\\[" . "%\\]") ; AMStex block comment...
     ;; All the standard LaTeX keywords from L. Lamport's guide:
     ;; \cite, \hspace, \hspace*, \hyphenation, \include, \includeonly, \input,
     ;; \label, \nocite, \rule (in ispell - rest included here)
     ("\\\\addcontentsline"              ispell-tex-arg-end 2)
     ("\\\\add\\(tocontents\\|vspace\\)" ispell-tex-arg-end)
     ("\\\\\\([aA]lph\\|arabic\\)"	 ispell-tex-arg-end)
     ;;("\\\\author"			 ispell-tex-arg-end)
     ;; New regexp here --- kjh
     ("\\\\cite\\(t\\|p\\|year\\|yearpar\\)" ispell-tex-arg-end)
     ("\\\\bibliographystyle"		 ispell-tex-arg-end)
     ("\\\\makebox"			 ispell-tex-arg-end 0)
     ("\\\\e?psfig"			 ispell-tex-arg-end)
     ("\\\\document\\(class\\|style\\)" .
      "\\\\begin[ \t\n]*{[ \t\n]*document[ \t\n]*}"))
    (;; delimited with \begin.  In ispell: displaymath, eqnarray, eqnarray*,
     ;; equation, minipage, picture, tabular, tabular* (ispell)
     ("\\(figure\\|table\\)\\*?"	 ispell-tex-arg-end 0)
     ("list"				 ispell-tex-arg-end 2)
     ("program"		. "\\\\end[ \t\n]*{[ \t\n]*program[ \t\n]*}")
     ("verbatim\\*?"	. "\\\\end[ \t\n]*{[ \t\n]*verbatim\\*?[ \t\n]*}"))))


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-output-view-style (quote (("^dvi$" ("^landscape$" "^pstricks$\\|^pst-\\|^psfrag$") "%(o?)dvips -t landscape %d -o && gv %f") ("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "%(o?)dvips %d -o && gv %f") ("^dvi$" ("^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "^landscape$") "%(o?)xdvi %dS -paper a4r -s 0 %d") ("^dvi$" "^\\(?:a4\\(?:dutch\\|paper\\|wide\\)\\|sem-a4\\)$" "%(o?)xdvi %dS -paper a4 %d") ("^dvi$" ("^\\(?:a5\\(?:comb\\|paper\\)\\)$" "^landscape$") "%(o?)xdvi %dS -paper a5r -s 0 %d") ("^dvi$" "^\\(?:a5\\(?:comb\\|paper\\)\\)$" "%(o?)xdvi %dS -paper a5 %d") ("^dvi$" "^b5paper$" "%(o?)xdvi %dS -paper b5 %d") ("^dvi$" "^letterpaper$" "%(o?)xdvi %dS -paper us %d") ("^dvi$" "^legalpaper$" "%(o?)xdvi %dS -paper legal %d") ("^dvi$" "^executivepaper$" "%(o?)xdvi %dS -paper 7.25x10.5in %d") ("^dvi$" "." "%(o?)xdvi %dS %d") ("^pdf$" "." "open -a skim %o") ("^html?$" "." "netscape %o"))))
 '(show-paren-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
