(module more-like-that.main
  {require {nvim more-like-that.aniseed.nvim
            str more-like-that.aniseed.string
            a more-like-that.aniseed.core}})

(def this :more-like-that.main)

(defn http-get [url]
  (nvim.ex.sview url)
  (let [content (nvim.fn.getline 1 "$")]
    (nvim.ex.bd)
    (nvim.fn.json_decode content)))

(defn get-synonyms [w]
  (let [url (..  "https://api.datamuse.com/words?rel_syn=" w)
        res (a.map (fn [e] (. e :word)) (http-get url))]
    (table.insert res 1 w)
    res))

(defn create-suggestion-buffer []
  (let [buf (nvim.create_buf false true)]
    (nvim.buf_set_option buf "bufhidden" "wipe")
    buf))

(defn make-window
  [buf width height]
  (let [opts {:style "minimal"
              :relative "cursor"
              :width width
              :height height
              :row 1
              :col -1}
        win (nvim.open_win buf true opts)]
    (nvim.buf_set_option buf "modifiable" false)
    (nvim.win_set_option win "cursorline" true)))

(defn max-len [entries]
  (nvim.fn.max (a.map a.count entries)))

(defn prefix-space [word]
  (.. " " word))

(defn populate-buffer [buf suggestions]
  (nvim.buf_set_lines buf 0 0 false (a.map prefix-space suggestions))
  buf)

(defn read-word []
  "Return the word under the cursor"
  (nvim.fn.expand "<cword>"))

(defn replace-word [replacement]
  "Replace the word under the cursor with `replacement`"
  (nvim.command (.. "normal ciw" replacement)))

(defn lua-call [mod function ...]
  "expand to a lua function call for `function` inside `module`"
  (let [astr (str.join ", " [...])]
    (.. "lua require('" mod "')['" function "'](" astr ")")))

(defn cancel-suggestion []
  (nvim.ex.q))

(defn confirm-selection []
  (let [line (nvim.fn.getline ".")
        word (str.trim line)]
    (nvim.ex.q)
    (replace-word word)))

(defn move-selection [offset]
  (let [[row col] (nvim.win_get_cursor 0)
        row (if (> offset 0)
              (math.min (+ offset row) (- (nvim.fn.line "$") 1))
              (math.max (+ offset row) 1))]
    (nvim.win_set_cursor 0 [row col])))

(defn disable-keys [buf]
  "Disable all letters mappings"
  (each [_ c (ipairs [:a :b :c :d :e :f :g :h :i :j :k :l :m
                      :n :o :p :q :r :s :t :u :v :w :x :y :z])]
    (nvim.buf_set_keymap buf :n (.. "<C-" c ">") "<Nop>" {:silent true})
    (nvim.buf_set_keymap buf :n (: c :upper) "<Nop>" {:silent true})
    (nvim.buf_set_keymap buf :n c "<Nop>" {:silent true}))
  buf)

(defn install-popup-mappings [buf]
  "Setup mappings for suggestion popup buffer"
  (let [mapping {"<C-n>" [:move-selection 1]
                 "<C-p>" [:move-selection -1]
                 "k" [:move-selection -1]
                 "j" [:move-selection 1]
                 "q" [:cancel-suggestion]
                 "<Esc>" [:cancel-suggestion]
                 "<CR>"  [:confirm-selection]}]
    (each [key args (pairs mapping)]
      (nvim.buf_set_keymap
        buf :n
        key (.. ":" (lua-call this (unpack args)) "<CR>")
        {:noremap true
         :silent true})))
  buf)

(defn activate []
  (let [suggestions (get-synonyms (read-word))
        width (+ 2 (max-len suggestions))
        height (length suggestions)]
    (-> (create-suggestion-buffer)
        (populate-buffer suggestions)
        (disable-keys) ; first disable all keys
        (install-popup-mappings) ; then enable the ones we want
        (make-window width height))))

(defn init []
  (nvim.ex.command_ "MLTSynonyms" (lua-call this :activate)))
