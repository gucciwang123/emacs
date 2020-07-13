;;;keybinds
(defun add-tab () (interactive) (insert-char 9))
(global-set-key (kbd "<tab>") 'add-tab)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-x") 'kill-region)
(global-set-key (kbd "C-s-c") 'kill-rectangle)
(global-set-key (kbd "C-c") 'kill-region-save)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-S-v") 'yank-rectangle)
(global-set-key (kbd "C-S-s") 'save-buffer)
(global-set-key (kbd "C-h") 'isearch-forward)
(global-set-key (kbd "C-S-h") 'isearch-backward)
(global-set-key (kbd "C-s") 'next-line)
(global-set-key (kbd "C-a") 'left-char)
(global-set-key (kbd "C-w") 'previous-line)
(global-set-key (kbd "C-d") 'right-char)
(global-set-key (kbd "C-S-d") 'end-of-line)
(global-set-key (kbd "C-S-a") 'beginning-of-line)
(global-unset-key (kbd "C-l"))
(global-set-key (kbd "C-l e") 'eval-region)
(global-set-key (kbd "C-S-<SPC>") 'rectangle-mark-mode)
(global-set-key (kbd "C-S-f") 'ido-dired)
(global-set-key (kbd "M-c") 'kill-emacs)

(global-set-key (kbd "M-e") 'next-multiframe-window)
(global-set-key (kbd "M-q") 'previous-multiframe-window)

(defun split-window-above () (interactive) (split-window-below) (next-multiframe-window) (tabbar-press-home) (next-buffer))
(defun split-window-left () (interactive) (split-window-right) (next-multiframe-window) (tabbar-press-home) (next-buffer))
(defun __split-window-right () (interactive) (split-window-right) (tabbar-press-home) (next-buffer))
(defun __split-window-below () (interactive) (split-window-below) (tabbar-press-home) (next-buffer))
(global-set-key (kbd "M-s") 'split-window-above)
(global-set-key (kbd "M-w") '__split-window-below)
(global-set-key (kbd "M-a") '__split-window-right)
(global-set-key (kbd "M-d") 'split-window-left)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key  (kbd "C-1") 'kill-buffer-and-window)
(global-set-key (kbd "C-0") 'kill-current-buffer)
(global-set-key (kbd "C-S-0") 'kill-buffer)

(defun bash () (interactive) (split-window-below) (other-window 1) (term "/bin/bash"))
(global-set-key (kbd "C-t") 'bash)

;;;packages
;;smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;;ido
(require 'ido)
(ido-mode 1)

;;multiple cursors
(require 'multiple-cursors)
(global-unset-key (kbd "S-<down-mouse-1>"))
(global-set-key (kbd "S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-S-1") 'mc/mark-next-like-this)
(global-set-key (kbd "C-S-2") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-S-3") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-S-4") 'mc/skip-to-previous-like-this)

;;origami
(add-to-list 'load-path "~/emacs/origami.el/")
(require 'origami)
(origami-mode)
(global-set-key (kbd "M-2") 'origami-toggle-node)
(global-set-key (kbd "M-3") 'origami-toggle-all-nodes)

;;eglotee
(require 'eglot)
(global-unset-key (kbd "C-b"))
(global-set-key (kbd "C-b e") 'eglot)
(global-set-key (kbd "C-b E") 'eglot-shutdown)

;;company
(require 'company)
(global-company-mode)
(global-set-key (kbd "<backtab>") 'company-complete)

;; Tabbar
(require 'tabbar)
(set-face-attribute
 'tabbar-default nil
 :background "gray20"
 :foreground "gray20"
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-unselected nil
 :background "gray30"
 :foreground "white"
 :box '(:line-width 5 :color "gray30" :style nil))
(set-face-attribute
 'tabbar-selected nil
 :background "gray75"
 :foreground "black"
 :box '(:line-width 5 :color "gray75" :style nil))
(set-face-attribute
 'tabbar-highlight nil
 :background "white"
 :foreground "black"
 :underline nil
 :box '(:line-width 5 :color "white" :style nil))
(set-face-attribute
 'tabbar-button nil
 :box '(:line-width 1 :color "gray20" :style nil))
(set-face-attribute
 'tabbar-separator nil
 :background "gray20"
 :height 0.6)

;; Change padding of the tabs
;; we also need to set separator to avoid overlapping tabs by highlighted tabs
(custom-set-variables
 '(tabbar-separator (quote (0.5))))
;; adding spaces
(defun tabbar-buffer-tab-label (tab)
  "Return a label for TAB.
That is, a string used to represent it on the tab bar."
  (let ((label  (if tabbar--buffer-show-groups
                    (format "[%s]  " (tabbar-tab-tabset tab))
                  (format "%s  " (tabbar-tab-value tab)))))
    ;; Unless the tab bar auto scrolls to keep the selected tab
    ;; visible, shorten the tab label to keep as many tabs as possible
    ;; in the visible area of the tab bar.
    (if tabbar-auto-scroll-flag
        label
      (tabbar-shorten
       label (max 1 (/ (window-width)
                       (length (tabbar-view
                                (tabbar-current-tabset)))))))))
(tabbar-mode 1)

(defun my/tabbar-buffer-groups ()
  (cond ((member (buffer-name)
                 '("*Completions*"
                   "*scratch*"
                   "*Messages*"
                   "*Ediff Registry*"
				   "*terminal*
					*Backtrace*"))
         (list "Output"))
        (t (list "Sources"))))
(setq tabbar-buffer-groups-function #'my/tabbar-buffer-groups)
;;keybinds
(global-set-key (kbd "C-q") 'tabbar-backward)
(global-set-key (kbd "C-e") 'tabbar-forward)

;;all-the-icons
(add-to-list 'load-path "~/emacs/all-the-icons.el/")
(require 'all-the-icons)

;;neo-tree
(add-to-list 'load-path "~/emacs/neotree/")
(setq neo-keymap-style 'concise)
(require 'neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-window-fixed-size nil)
;;neotree hidden
(setq neo-hidden-regexp-list '("^\\." "\\.cs\\.meta$" "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "\\.cmake" "\\.a" "\\.o" "\\.so"
			       "Makefile" "CMakeFiles" "compile_commands.json" "LICENSE" "CMakeCache.txt"))
;;keybinds
(global-unset-key (kbd "C-f"))
(global-set-key (kbd "C-f d") 'neotree-toggle)
(global-set-key (kbd "C-f h") 'neotree-hidden-file-toggle)
(global-set-key (kbd "C-f r") 'neotree-refresh)

;;;settings
(electric-pair-mode 1)
(delete-selection-mode 1)
(electric-indent-mode 1)
(setq-default tab-width 4)

;;;enviorment
(set-frame-size (selected-frame )250 120)
(neotree-toggle)

