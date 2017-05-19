;;;; Nikolas .emacs file
; Nikolas Maletschkin
; 

;;;; Клавиша Помощи
; Control-h это клавиша помощи; 
; после того как вы нажали control-h, нажмите какую-нибудь букву
; означающую тему о которой вы хотите узнать.
; Для получения обьяснений о возможностях помощи, 
; нажмите control-h три раза подряд.

; Чтобы получить информацию о каком-нибудь режиме нажмите control-h m
; если данный режим включен для этого буфера.  Например, чтобы
; получить информацию о режиме mail, запустите режим mail и нажмите
; control-h m

	
;;; режим Text и режим Auto Fill
; Следующие две линии включают по умолчанию в Emacs режим Text 
; и режим Auto Fill --- это в самый раз для писателей, которые хотят
; писать прозу, а не программы.
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)


;; scroll bar 
(scroll-bar-mode nil)
;; tool bar
(tool-bar-mode nil)
;; menu bar
;; (menu-bar-mode -1) 
(tooltip-mode      nil)
(blink-cursor-mode nil) ;; курсор не мигает
(setq use-dialog-box     nil) ;; никаких графических диалогов и окон - все через минибуфер
(setq redisplay-dont-pause t)  ;; лучшая отрисовка буфера
(setq ring-bell-function 'ignore) ;; отключить звуковой сигнал


;; скроллинг по одной строке
(setq scroll-step 1)
;; выделение текущей строки
(global-hl-line-mode 1)

;; Klammern anzeigen
(show-paren-mode 1)

;; Electric-modes settings
(electric-pair-mode    1) ;; автозакрытие {},[],() с переводом курсора внутрь скобок
(electric-indent-mode -1) ;; отключить индентацию  electric-indent-mod'ом (default in Emacs-24.4)

;; Linum plugin
;; (require 'linum) ;; вызвать Linum
;; (line-number-mode   t) ;; показать номер строки в mode-line
;; (global-linum-mode  t) ;; показывать номера строк во всех буферах
(column-number-mode t) ;; показать номер столбца в mode-line
;; (setq linum-format " %d") ;; задаем формат нумерации строк

;; Line wrapping
(setq word-wrap          t) ;; переносить по словам
(global-visual-line-mode t) 


;; Make all “yes or no” prompts show “y or n” instead
(fset 'yes-or-no-p 'y-or-n-p)

;; set proxy
(setq url-proxy-services
      '(
	("no_proxy" . "^\\(localhost\\|127.0.0.1\\|11.*\\)")
	("http" . "11.1.1.65:3128")
	("https" . "11.1.1.65:3128")
       )
)
;;
;; Login und Password encodiren, 
;; z.B. in *scratch*-buffer (base64-encode-string "himolla\\username:password") C-x C-e
;;
(setq url-http-proxy-basic-auth-storage
    (list (list "11.1.1.65:3128"
            '("Squid proxy-caching web server" 
                  . "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"))))

(setq gnutls-log-level 2)

;; M-x auf C-x C-m setzen
(global-set-key "\C-x\C-m" 'execute-extended-command)

(global-set-key [(control tab)] 'previous-buffer)
(global-set-key [(control shift tab)] 'next-buffer)
(global-set-key [f4] 'revert-buffer)
(global-set-key [f5] 'neotree-toggle)
(global-set-key [f6] 'org-pomodoro)
(global-set-key [f8] 'linum-mode) ;; без этой штуки жить нельзя
(global-set-key [f11] 'ibuffer)
;; Это покруче, Ctrl-D в тотал командере, сохраняйте букмарки везде
;; (C-x r m) и открывайте их.
(global-set-key [f10] 'bookmark-bmenu-list)
;; Undo. по умолчанию емакс уходит в бакграундr
(global-set-key "\C-z" 'undo)
;; command ‘occur’ lists all lines of the current buffer that match a
;; regexp that you give it
(global-set-key (kbd "C-c o") 'occur)

;; Einige wichtige Tastenkürzel für Org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;; Capture mit "C-c c" oder F9
(global-set-key "\C-cc" 'org-capture)
(global-set-key [f9] 'org-capture)

;; если вы работаете с большим количеством файлов/буферов и решили
;; закрыть emacs, а потом решили возобновить работу. не открывать же
;; их заново… попросим emacs сохранять сессию перед выходом.
;;(desktop-change-dir "m:/emacs/desktopsave")
;;(setq desktop-path (list "m:/emacs/desktopsave"))
(desktop-save-mode t)
   (setq desktop-buffers-not-to-save
        (concat "\\("
                "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
                "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
	        "\\)$"))
(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

;; make PC keyboard's Win key or other to type Super or Hyper, for
;; emacs running on Windows.
(setq w32-pass-lwindow-to-system nil)
(setq w32-lwindow-modifier 'meta) ; Left Windows key

(setq w32-pass-rwindow-to-system nil)
(setq w32-rwindow-modifier 'meta) ; Right Windows key

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'meta) ; Menu/App key

;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(dolist (source '(
                  ;; TODO: Maybe, use this after emacs24 is released
                  ;; (development versions of packages)
                  ("melpa" . "http://melpa.org/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)

;; Variable für Betriebssystem setzen
(defvar gnulinux-p (string-match "linux" (symbol-name system-type)))
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))


(add-hook 'calendar-load-hook
              (lambda ()
                (calendar-set-date-style 'european)))

(setq solar-n-hemi-seasons
      '("Frühlingsanfang" "Sommeranfang" "Herbstanfang" "Winteranfang"))

(setq holiday-general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 5 1 "1. Mai")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")))

;; Feiertage für Bayern, weitere auskommentiert
(setq holiday-christian-holidays
      '((holiday-float 12 0 -4 "1. Advent" 24)
        (holiday-float 12 0 -3 "2. Advent" 24)
        (holiday-float 12 0 -2 "3. Advent" 24)
        (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        (holiday-fixed 1 6 "Heilige Drei Könige")
        (holiday-easter-etc -48 "Rosenmontag")
        (holiday-easter-etc -3 "Gründonnerstag")
        (holiday-easter-etc  -2 "Karfreitag")
        (holiday-easter-etc   0 "Ostersonntag")
        (holiday-easter-etc  +1 "Ostermontag")
        (holiday-easter-etc +39 "Christi Himmelfahrt")
        (holiday-easter-etc +49 "Pfingstsonntag")
        (holiday-easter-etc +50 "Pfingstmontag")
        (holiday-easter-etc +60 "Fronleichnam")
        (holiday-fixed 8 15 "Mariae Himmelfahrt")
        (holiday-fixed 11 1 "Allerheiligen")
        (holiday-float 11 3 1 "Buss- und Bettag" 16)
        (holiday-float 11 0 1 "Totensonntag" 20)))

(setq calendar-holidays
      (append holiday-general-holidays holiday-local-holidays holiday-other-holidays
              holiday-christian-holidays holiday-solar-holidays))
;; Org-Mode 
;; Org mode soll für alle Dateien mit den Endungen .org und
;; .org_archive geladen werden
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

;; Agenda-Files
(if gnulinux-p
  (progn
   (setq org-agenda-files (quote 
    ("~/org/gtd.org"
     "~/org/inbox.org"			   
     "~/org/journal.org")
     "~/org/birthday.org"))))
(if mswindows-p
 (progn
  (setq org-agenda-files (list
    "m:/emacs/org/birthday.org"
    "m:/emacs/org/gtd.org" 
    "m:/emacs/org/inbox.org"			   
    "m:/emacs/org/journal.org"))))


;; Nur einen Stern bei Headlines anzeigen, die anderen ausblenden
;;(setq org-hide-leading-stars 'hidesTars)

;; Eingabetaste folgt Links:
(setq org-return-follows-link t)
 
;; Capture templates for: TODO tasks, Notes, appointments, phone
;; calls, meetings, and org-protocol
(if gnulinux-p
    (progn
      (setq org-capture-templates
	    (quote (
		    ("t" "Todo" entry (file "~/org/inbox.org")
		     "* TODO %?\nCreated on %U\n")
		    ("p" "Project" entry (file "~/org/inbox.org")
		     "* TODO %? :PROJ:\nCreated on %U\n")
		    ("j" "Journal" entry (file+datetree "~/org/journal.org")
		     "* %? :JOURNAL:\nEntered on %U\n %i\n" )
		    ("d" "Dokumentation" entry (file+headline "~/org/gtd.org" "Doku")
		     "* %?\nCreated on %U\n" )
		    )))))
(if mswindows-p
 (progn
      (setq org-capture-templates
	    (quote (
		    ("t" "Todo" entry (file "m:/emacs/org/inbox.org")
		     "* TODO %?\nCreated on %U\n")
		    ("p" "Project" entry (file "m:/emacs/org/inbox.org")
		     "* TODO %? :PROJ:\nCreated on %U\n")
		    ("j" "Journal" entry (file+datetree "m:/emacs/org/journal.org")
		     "* %? :JOURNAL:\nEntered on %U\n %i\n" )
		    ("d" "Dokumentation" entry (file+headline "m:/emacs/org/gtd.org" "Doku")
		     "* %? :DOKU:\nCreated on %U\n" )
		    )))))

;;Drawers konfigurieren
;;Die folgende Einstellung ermöglicht das Einklappen der jeweiligen Elemente.
(setq org-drawers (quote ("PROPERTIES" "CLOCKTABLE" "LOGBOOK" "CLOCK")))

;; Refiling Tasks

;; Use IDO for target completion
(setq org-completion-use-ido t)
;; Targets include this file and any file contributing to the agenda -
;;up to 5 levels deep
(setq org-refile-targets (quote((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
;; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
;; Targets complete in steps so we start with filename, TAB shows the
;; next level of targets etc
(setq org-outline-path-complete-in-steps t)

;; Stadien von Aufgaben und entsprechende Farb-Definitionen

;; Ein "!" - Zeitstempel
;; Ein "@" - Notiz mit Zeitstempel
(setq org-todo-keywords
      '(
        (sequence "TODO(t!)" "STARTED(s!)" "NEXT(n@)" "WAITING(w@)" "|" "DONE(d!)")
        (sequence "|" "CANCELED(c@)" "DELEGATED(l@)" "SOMEDAY(f!)")
	))

(setq org-todo-keyword-faces
      '(
        ("NEXT" . (:foreground "IndianRed1" :weight bold))   
        ("STARTED" . (:foreground "OrangeRed" :weight bold))
        ("WAITING" . (:foreground "IndianRed1" :weight bold)) 
        ("CANCELED" . (:foreground "LimeGreen" :weight bold))
        ("DELEGATED" . (:foreground "LimeGreen" :weight bold))
        ("SOMEDAY" . (:foreground "LimeGreen" :weight bold))
        ))

;; Fast TODO Selection
(setq org-use-fast-todo-selection t)

;; Logging
;; Logging notiert Änderungen im Todo-Stadium von Aufgaben.

;; Einen Zeitstempel eintragen, wenn eine Aufgabe als erledigt markiert wird
(setq org-log-done 'time)

;; Einen eigenen Drawer benutzen
(setq org-log-into-drawer t)

;; Eindeutschen
;; deutsch as export language
(setq org-export-default-language "de")
;; deutscher Kalender:
(setq calendar-week-start-day 1
      calendar-day-name-array
        ["Sonntag" "Montag" "Dienstag" "Mittwoch"
         "Donnerstag" "Freitag" "Samstag"]
      calendar-month-name-array
        ["Januar" "Februar" "März" "April" "Mai"
         "Juni" "Juli" "August" "September"
         "Oktober" "November" "Dezember"])

;; Die Org-Agenda

;; Die Org Agenda macht einen wesentlichen Teil der Magie des Org mode
;; aus. Sie sammelt die verschiedensten Informationen aus beliebig
;; vielen Org mode Dateien zusammen und stellt sie übersichtlich dar.

;; Zunächst einige grundlegende Einstellungen:
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)

;; Compact the block agenda view
(setq org-agenda-compact-blocks t)

;;
(setq org-agenda-skip-scheduled-if-done t)

;;
(setq org-agenda-include-diary t)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (
	      
	      ("j" "Journal" tags "JOURNAL"
	       ((org-agenda-overriding-header "Tagebuch und Notizen")
                (org-tags-match-list-sublevels nil)
		(org-agenda-files '("m:/emacs/org/journal.org"))))
              ("s" "someday" todo "SOMEDAY"
               ((org-agenda-overriding-header "Irgendwann")
                ))
	      (" " "Agenda"
	       ((agenda "" nil)
		(tags "REFILE"
                      ((org-agenda-overriding-header "Posteingang zum Sortieren")
		       ))
		(tags-todo "PROJ/-DONE"
                      ((org-agenda-overriding-header "Projekte")
		       ))
                (tags-todo "-CANCELED/NEXT-IDEA-SOMEDAY"
                           ((org-agenda-overriding-header "Nächste Schritt")
                            (org-tags-match-list-sublevels t)
                            (org-agenda-sorting-strategy
                             '(todo-state-down effort-up category-keep))))
		(tags-todo "-REFILE/-CANCELED-WAITING-IDEA-SOMEDAY"
                           ((org-agenda-overriding-header "Aufgaben ohne Zeiten")
			    (org-agenda-skip-function
			     (lambda nil
			       (org-agenda-skip-entry-if
				(quote scheduled)
				(quote deadline)
				)))
                            (org-agenda-sorting-strategy
                             '(category-keep))))
		(todo "WAITING"
                           ((org-agenda-overriding-header "Aufgaben wartend und angehalten")
                            (org-agenda-skip-function 'bh/skip-non-tasks)
                            (org-tags-match-list-sublevels nil)
			    ))
                 (todo "SOMEDAY"
                      ((org-agenda-overriding-header "Aufgaben für Irgendwann")
                      ))
                 (todo "DONE|CANCELED"
                      ((org-agenda-overriding-header "Aufgaben zum Archivieren")
                       (org-agenda-skip-function 'bh/skip-non-archivable-tasks)
                      ))
	      )))))


;; Agenda auto start
;;(setq inhibit-splash-screen t)
;;(org-agenda-list)
;;(delete-other-windows)

;;
;; Auto resize windows by golden ratio
;;
;;(require 'golden-ratio)
;;(golden-ratio-mode 1)
;; prevent Golden Ratio mode to be activated for certain mode
;;(setq golden-ratio-exclude-modes '("ediff-mode"
;;                                   "eshell-mode"
;;                                   "dired-mode"
;;				   "neotree-mode"))


;; Neotree
(require 'neotree)
;; Every time when the neotree window is opened, let it find current
;; file and jump to node
(setq neo-smart-open t)

;; FTP für Windows
(setq ange-ftp-ftp-program-name "C:/Program Files (x86)/Emacs 25.1/bin/ftp.exe")

;; Multi-web-mode
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)

;; switch-window Window switching, the visual way. --- A *visual* way
;; to choose a window to switch to
;; 
;; If you do not use El-Get or ELPA, you need to require the package first:
(require 'switch-window)
;; Rebind your C-x o key:
(global-set-key (kbd "C-x o") 'switch-window)



;; Setup ASPELL for 64-bit Windows 7
;;
;; First you need to download and install both the aspell executable
;; and at least one dictionary from http://aspell.net/win32/.  These
;; will be two separate downloads, be sure to get both.  Under the
;; 64-bit version of Windows 7 the default install directory for both
;; of them is “C:\Program Files (x86)\Aspell\dict\”.  “C:\Program
;; Files (x86)” is used for 32-bit executables, while “C:\Program
;; Files” is for the 64-bit ones.
;;
;; Next we need to make a series of changes in your InitFile.  You
;; need to add the path of the aspell exec to your emacs exec-path.  I
;; tried the path string without the C: at the beginning but it did
;; not work consistently.
    (add-to-list 'exec-path "C:/Program Files (x86)/Aspell/bin/")
;; We need tell emacs to use aspell, and where your custom dictionary
;; is.
    (setq ispell-program-name "aspell")
    (setq ispell-personal-dictionary "~/.ispell")
;; Then, we need to turn it on.
    (require 'ispell)
;; Lastly you need some way of invoking it.  “M-$” is the default
;; method, which will check the word currently under the point.  If a
;; region is active “M-$ will check all words within the region.
;; However, I like to customize all the keybindings.  So, here’s an
;; example to use it with FlySpell:
    (global-set-key (kbd "<f7>") 'ispell-word)
    (global-set-key (kbd "C-<f7>") 'flyspell-mode)
;; Deutsche Rechtschreibung falls \usepackage{ngerman}
;; oder german benutzt wird
(ispell-change-dictionary "german" t)


;; load god-mode
(require 'god-mode)
;; Toggle between God mode and non-God mode using ESC:
(global-set-key (kbd "<escape>") 'god-local-mode)
;; If you want to enable/disable on all active and future buffers, use this:
;; (global-set-key (kbd "<escape>") 'god-mode-all)
;; You can change the cursor style indicate whether you're in God mode or not.
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'box
                      'bar)))
(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)
;; You can pause god-mode when overwrite-mode is enabled and resume when overwrite-mode is disabled.
(defun god-toggle-on-overwrite ()
  "Toggle god-mode on overwrite-mode."
  (if (bound-and-true-p overwrite-mode)
      (god-local-mode-pause)
    (god-local-mode-resume)))
(add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)

;; zoom-window provides functions which zooms specific window in frame and
;; restore original window configuration. This is like tmux's zoom/unzoom
;; features.
(require 'zoom-window)
;; Zoom-mode-zoom: toggle zoom
(global-set-key (kbd "C-x C-z") 'zoom-window-zoom)

;; Use NyanCat to show buffer size and position in mode-line.
;; You can customize this minor mode, see option ‘nyan-mode’.
;; Note: If you turn this mode on then you probably want to turn off
;; option ‘scroll-bar-mode’.
(require 'nyan-mode)
(setq nyan-animate-nyancat t)
(setq nyan-wavy-trail t)
(nyan-mode)

;; Babel Setup vor DITAA
(setq org-ditaa-jar-path "~/.emacs.d/ditaa/ditaa.jar")

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)




;; ende
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1b1a24" "#ee11dd" "#4c406d" "#b4f5fe" "#8CD0D3" "#DC8CC3" "#ffa500" "#8584ae"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (silkworm)))
 '(custom-safe-themes
   (quote
    ("8767634da767f26529c066970e85c12262780d82706c847c7e8b3b5beadf8dd1" "604df4e364738a338cfaf10db323eafb5b7ca4a3ccba41b27c1930da3dff52c8" "9ab46512b8b69478b057f79d0eb0faee61d19e53917a868a14e41bf357cee6d4" "20b3819da3fcf420fba2ffd9f2b1ff7c261ee5eb36c237f9ffc0b38bb1ca22be" "8dc4a35c94398efd7efee3da06a82569f660af8790285cd211be006324a4c19a" "67a66bb848f64117e7236005480cecbcc8eb2ef2fc875cd754a7c5192c71447c" "2d9619187e7c2bd17a05f22c4f5702368ccee23d7f93017f8d6ddbcaf407b91e" default)))
 '(fci-rule-color "#252634")
 '(line-number-mode nil)
 '(nrepl-message-colors
   (quote
    ("#ee11dd" "#8584ae" "#b4f5fe" "#4c406d" "#ffe000" "#ffa500" "#ffa500" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (graphviz-dot-mode zoom-window zenburn-theme zen-and-art-theme wpuzzle w3 vlf visual-fill-column undo-tree switch-window sudoku ssh speed-type rainbow-mode pomodoro php-mode org-pomodoro nyan-mode neotree multi-web-mode monokai-theme molokai-theme moe-theme markdown-preview-eww goto-chg golden-ratio god-mode focus css-mode color-theme-solarized color-theme-modern centered-window-mode 2048-game)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#0bafed")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#ee11dd")
     (60 . "#8584ae")
     (80 . "#ffe000")
     (100 . "#efef80")
     (120 . "#b4f5fe")
     (140 . "#4c406d")
     (160 . "#4c406d")
     (180 . "#1b1a24")
     (200 . "#4c406d")
     (220 . "#65ba08")
     (240 . "#ffe000")
     (260 . "#ffa500")
     (280 . "#6CA0A3")
     (300 . "#0bafed")
     (320 . "#8CD0D3")
     (340 . "#ffa500")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "#ece3db")))))
