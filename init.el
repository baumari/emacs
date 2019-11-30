
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flymake-cursor flymake pacmacs mew xclip flycheck-irony flyspell-correct multi-term hlinum nlinum flycheck yatex))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(linum-highlight-face ((t (:foreground "black" :background "yellow")))))
(setq make-backup-files nil)
(setq auto-save-default nil)

;; flymake
;;(require 'flymake)
;;(custom-set-faces
;;  '(flymake-errline ((((class color)) (:background "red"))))
;;  '(flymake-warnline ((((class color)) (:background "red")))))
;;(push '("\\.h\\'" flymake-simple-make-init flymake-master-cleanup)
;;      flymake-allowed-file-name-masks)
;;(add-hook 'c++-mode-hook
;;          '(lambda()
;;             (flymake-mode t)
;;             (flymake-cursor-mode t)
;;             (setq flymake-check-was-interrupted t)
;;             (local-set-key "\C-c\C-v" 'flymake-start-syntax-check)
;;             (local-set-key "\C-c\C-p" 'flymake-goto-prev-error)
;;             (local-set-key "\C-c\C-n" 'flymake-goto-next-error)
;;          )
;;	  )
;;(defun flymake-show-help ()
;;  (when (get-char-property (point) 'flymake-overlay)
;;    (let ((help (get-char-property (point) 'help-echo)))
;;      (if help (message "%s" help)))))
;;(add-hook 'post-command-hook 'flymake-show-help)


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;(require 'flycheck)
;;(flycheck-define-checker c/c++
;;  "A C/C++ checker using g++."
;;  :command ("g++" "-Wall" "-Wextra" source)
;;  :error-patterns  ((error line-start
;;                           (file-name) ":" line ":" column ":" " error: " (message)
;;                           line-end)
;;                    (warning line-start
;;                           (file-name) ":" line ":" column ":" " warning: " (message)
;;                           line-end))
;;  :modes (c-mode c++-mode))
;;(global-flycheck-mode)
;;(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
;;(flycheck-mode t)

;;;(require 'linum)
(require 'hlinum)
(hlinum-activate)

(setq linum-format "%3d ")
(global-linum-mode 1)

;;active window mode
(global-set-key (kbd "<C-left>")  'windmove-left)
(global-set-key (kbd "<C-down>")  'windmove-down)
(global-set-key (kbd "<C-up>")    'windmove-up)
(global-set-key (kbd "<C-right>") 'windmove-right)

;; resize window buffer
(global-set-key (kbd "C-x <C-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-x <C-left>")  'shrink-window-horizontally)
(global-set-key (kbd "C-x <C-up>")    'enlarge-window)
(global-set-key (kbd "C-x <C-down>")  'shrink-window)

(require 'multi-term)
(setq  multi-term-program shell-file-name)

(global-set-key (kbd "C-c t") '(lambda ()
                                (interactive)
                                (multi-term)))


(setq-default ispell-program-name "aspell")
(eval-after-load "ispell"
'(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
;; 
(global-set-key (kbd "C-M-$") 'ispell-complete-word)


(mapc                                   ;; 以下flyspell-modeの設定
 (lambda (hook)
   (add-hook hook 'flyspell-prog-mode))
 '(
   ;; ここに書いたモードではコメント領域のところだけ
   emacs-lisp-mode-hook                 ;; flyspell-mode が有効になる
   ))
(mapc
   (lambda (hook)
     (add-hook hook
                      '(lambda () (flyspell-mode 1))))
   '(
     yatex-mode-hook     ;; ここに書いたモードでは
                                    ;; flyspell-mode が有効になる
     ))
(mapc
   (lambda (hook)
     (add-hook hook
                      '(lambda () (flyspell-mode 1))))
   '(
     text-mode-hook     ;; ここに書いたモードでは
                                    ;; flyspell-mode が有効になる
     ))
(mapc
   (lambda (hook)
     (add-hook hook
                      '(lambda () (flyspell-mode 0))))
   '(
     c-mode-hook     ;; ここに書いたモードでは
                                    ;; flyspell-mode が有効になる
     ))
(mapc
   (lambda (hook)
     (add-hook hook
                      '(lambda () (flyspell-mode 0))))
   '(
     c++-mode-hook     ;; ここに書いたモードでは
                                    ;; flyspell-mode が有効になる
     ))

(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
;;
;; PATH
;;
(setenv "PATH" "/usr/local/bin:/Library/TeX/texbin/:/Applications/Skim.app/Contents/SharedSupport:$PATH" t)
(setq exec-path (append '("/usr/local/bin" "/Library/TeX/texbin" "/Applications/Skim.app/Contents/SharedSupport") exec-path))
;;
;; YaTeX
;;
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-latex-message-code 'utf-8)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)
(setq YaTeX-dvi2-command-ext-alist
      '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|atril\\|xreader\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|MicrosoftEdge\\|microsoft-edge\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
(setq tex-command "ptex2pdf -u -l -ot '-synctex=1'")
;;(setq tex-command "lualatex -synctex=1")
(setq bibtex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
(setq makeindex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/upmendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
(setq dvi2-command "open -a Preview")
(setq tex-pdfview-command "open -a Preview")
(setq dviprint-command-format "open -a \"Adobe Acrobat Reader DC\" `echo %s | gsed -e \"s/\\.[^.]*$/\\.pdf/\"`")

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))
;;
;; RefTeX with YaTeX
;;
;;(add-hook 'yatex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

;;color settings
(progn
  (set-face-background 'mode-line "LightSkyBlue")
  (set-face-background 'mode-line-inactive "LightSteelBlue")
  )

;; flycheck-irony
(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
       (flycheck-irony-setup))))

(setq x-select-enable-clipboard t)

;; MEW
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-name "Inaba Kento") ;; (user-full-name)
(setq mew-user "kento") ;; (user-login-name)
(setq mew-mail-domain "nh.scphys.kyoto-u.ac.jp")
(setq mew-proto "%")
(setq mew-imap-user "a0123502@st.kyoto-u.ac.jp");; (user-login-name)
(setq mew-imap-server "outlook.office365.com") ;; if not localhost
(setq mew-imap-auth t)
(setq mew-smtp-user "a0123502@st.kyoto-u.ac.jp")
(setq mew-smtp-server "smtp-auth.kuins.kyoto-u.ac.jp") ;; if not localhost
(setq mew-smtp-auth t)

(setq window-system nil)
(setq display-graphic-p nil)





