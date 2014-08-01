
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '(\"\\\\.m$\" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;; Elpy
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
(require 'package)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(package-initialize)
(elpy-enable)

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;; International keyboards bug workaround
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
(require 'iso-transl)

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;; Wrap lines
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
(global-visual-line-mode 1) ; 1 for on, 0 for off.

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;; Open files in new window
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;(setq pop-up-frames t) ; t for true, nil for false

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;;; Show lines numbers
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;

(global-linum-mode 1) ; display line numbers in margin. Emacs 23 only.

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;;; Highlight cursor line
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
(global-hl-line-mode 1) ; turn on highlighting current line

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;;; Color hex values
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
(defun xah-syntax-color-hex ()
"Syntax color hex color spec such as ¡¸#ff1100¡¹ in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("#[abcdef[:digit:]]\\{6\\}"
      (0 (put-text-property
          (match-beginning 0)
          (match-end 0)
          'face (list :background (match-string-no-properties 0)))))))
  (font-lock-fontify-buffer)
  )
(add-hook 'css-mode-hook 'xah-syntax-color-hex)
(add-hook 'php-mode-hook 'xah-syntax-color-hex)
(add-hook 'html-mode-hook 'xah-syntax-color-hex)

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;;; Color HSL values
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;

(defun xah-syntax-color-hsl ()
  "Syntax color hex color spec such as ¡¸hsl(0,90%,41%)¡¹ in current buffer."
  (interactive)
  (font-lock-add-keywords
   nil
  '(("hsl( *\\([0-9]\\{1,3\\}\\) *, *\\([0-9]\\{1,3\\}\\)% *, *\\([0-9]\\{1,3\\}\\)% *)"
     (0 (put-text-property
         (+ (match-beginning 0) 3)
         (match-end 0)
         'face (list :background
 (concat "#" (mapconcat 'identity
                        (mapcar
                         (lambda (x) (format "%02x" (round (* x 255))))
                         (color-hsl-to-rgb
                          (/ (string-to-number (match-string-no-properties 1)) 360.0)
                          (/ (string-to-number (match-string-no-properties 2)) 100.0)
                          (/ (string-to-number (match-string-no-properties 3)) 100.0)
                          ) )
                        "" )) ;  "#00aa00"
                      ))))) )
  (font-lock-fontify-buffer)
  )
(add-hook 'css-mode-hook 'xah-syntax-color-hsl)
(add-hook 'php-mode-hook 'xah-syntax-color-hsl)
(add-hook 'html-mode-hook 'xah-syntax-color-hsl)

;;;; ;;;; ;;;; ;;;; ;;;; ;;;;
;;; Latex things
;;;; ;;;; ;;;; ;;;; ;;;; ;;;;


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (tsdh-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
