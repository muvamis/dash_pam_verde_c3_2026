/* ==========================================================================
   PAM_VERDE — Alternância de idioma Português / English
   --------------------------------------------------------------------------
   Este ficheiro troca APENAS os textos apresentados ao utilizador.
   - Não altera dados, valores, cálculos nem objectos dos gráficos: a tradução
     é feita sobre o texto já desenhado no ecrã (DOM), por isso as barras,
     cores, eixos, escalas e dimensões ficam exactamente iguais.
   - O dicionário central está em  www/i18n/traducoes.json
   - Ao voltar a "PT" é reposto o texto original, tal como foi gerado pelo R.
   ========================================================================== */
(function () {
  'use strict';

  var LS_KEY = 'pamverde_idioma';
  var DICT_URL = 'i18n/traducoes.json';
  var SHINY_INPUT = 'idioma_app';

  // Zonas que nunca são traduzidas:
  //  - blockquote: depoimentos das participantes (dados originais)
  //  - .i18n-skip: marcação manual para excluir algo da tradução
  var SKIP_SELECTOR = 'blockquote, .i18n-skip, script, style, noscript, textarea';
  // Células de tabela: só tradução exacta (rótulos conhecidos), nunca parcial
  var EXACT_ONLY_SELECTOR = 'td';
  var ATTRS = ['title', 'placeholder'];
  var HAS_LETTER = /[A-Za-zÀ-ɏ]/;

  var state = {
    lang: 'pt',
    loaded: false,
    exact: new Map(),
    fragRe: null,
    nodeRules: [],
    preRules: [],
    fragRules: []
  };
  var textStore = new WeakMap();   // nó de texto -> {o: original, t: traduzido}
  var attrStore = new WeakMap();   // elemento -> {attr: {o, t}}

  function norm(s) { return s.replace(/\s+/g, ' ').trim(); }
  function escRe(s) { return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); }
  function splitSegments(s) {
    // separa por etiquetas HTML, marcadores do plotly (%{...}) e quebras de linha
    return String(s).split(/<[^>]+>|%\{[^}]*\}|\n/);
  }

  // ------------------------------------------------------------------------
  // Construção do dicionário a partir de traducoes.json
  // ------------------------------------------------------------------------
  function build(data) {
    var exact = state.exact;
    (data.entradas || []).forEach(function (par) {
      var a = splitSegments(par[0]), b = splitSegments(par[1]);
      if (a.length !== b.length) {
        a = [String(par[0]).replace(/<[^>]+>/g, ' ')];
        b = [String(par[1]).replace(/<[^>]+>/g, ' ')];
      }
      for (var i = 0; i < a.length; i++) {
        var k = norm(a[i]), v = norm(b[i]);
        if (!k || !HAS_LETTER.test(k)) continue;
        if (!exact.has(k)) exact.set(k, v);
      }
    });

    var soltas = new Set(data.palavras_em_frases || []);
    var keys = [];
    exact.forEach(function (v, k) {
      if (k === v) return;
      var letters = (k.match(/\p{L}/gu) || []).length;
      if (letters < 2) return;
      var isPhrase = /\s/.test(k) || /[^\p{L}]/u.test(k);
      if (isPhrase || soltas.has(k)) keys.push(k);
    });
    keys.sort(function (x, y) { return y.length - x.length; });
    if (keys.length) {
      var parts = keys.map(function (k) {
        var e = escRe(k).replace(/ /g, '\\s+');
        if (/^[\p{L}\p{N}]/u.test(k)) e = '(?<![\\p{L}\\p{N}])' + e;
        if (/[\p{L}\p{N}]$/u.test(k)) e = e + '(?![\\p{L}\\p{N}])';
        return e;
      });
      state.fragRe = new RegExp(parts.join('|'), 'gu');
    }
    state.nodeRules = (data.regras_texto_completo || []).map(function (r) {
      return [new RegExp(r.de, 'u'), r.para];
    });
    state.preRules = []; state.fragRules = [];
    (data.regras_parciais || []).forEach(function (r) {
      var rule = [new RegExp(r.de, 'gu'), r.para];
      if (r.fase === 'antes') state.preRules.push(rule); else state.fragRules.push(rule);
    });
    state.loaded = true;
  }

  // ------------------------------------------------------------------------
  // Tradução de uma cadeia de texto
  // ------------------------------------------------------------------------
  function translateString(raw, exactOnly) {
    var n = norm(raw);
    if (!n || !HAS_LETTER.test(n)) return null;
    var lead = raw.match(/^\s*/)[0], trail = raw.match(/\s*$/)[0];

    var e = state.exact.get(n);
    if (e !== undefined) return e === n ? null : lead + e + trail;

    for (var i = 0; i < state.nodeRules.length; i++) {
      var r = state.nodeRules[i];
      if (r[0].test(n)) return lead + n.replace(r[0], r[1]) + trail;
    }
    if (exactOnly) return null;

    var out = raw, j;
    // 1) regras parciais aplicadas ao texto original (fase "antes")
    for (j = 0; j < state.preRules.length; j++) {
      out = out.replace(state.preRules[j][0], state.preRules[j][1]);
    }
    // 2) substituição das frases/fragmentos conhecidos (do mais longo para o mais curto)
    if (state.fragRe) {
      out = out.replace(state.fragRe, function (m) {
        var t = state.exact.get(norm(m));
        return t === undefined ? m : t;
      });
    }
    // 3) regras parciais para o que restar (padrões com números)
    for (j = 0; j < state.fragRules.length; j++) {
      out = out.replace(state.fragRules[j][0], state.fragRules[j][1]);
    }
    return out !== raw ? out : null;
  }

  function isSkipped(el) {
    return !el || (el.closest && el.closest(SKIP_SELECTOR) !== null);
  }
  function isExactOnly(el) {
    return el.closest && el.closest(EXACT_ONLY_SELECTOR) !== null;
  }

  // ------------------------------------------------------------------------
  // Nós de texto
  // ------------------------------------------------------------------------
  function translateTextNode(node) {
    var el = node.parentElement;
    if (isSkipped(el)) return;
    var cur = node.nodeValue;
    var rec = textStore.get(node);
    if (rec && cur === rec.t) return;               // já traduzido
    var t = translateString(cur, isExactOnly(el));
    if (t !== null && t !== cur) {
      textStore.set(node, { o: cur, t: t });
      node.nodeValue = t;
    } else if (rec) {
      textStore.delete(node);
    }
  }
  function restoreTextNode(node) {
    var rec = textStore.get(node);
    if (!rec) return;
    if (node.nodeValue === rec.t) node.nodeValue = rec.o;
    textStore.delete(node);
  }

  // ------------------------------------------------------------------------
  // Atributos (title, placeholder)
  // ------------------------------------------------------------------------
  function translateAttrs(el) {
    if (isSkipped(el)) return;
    ATTRS.forEach(function (a) {
      if (!el.hasAttribute || !el.hasAttribute(a)) return;
      var cur = el.getAttribute(a);
      var recs = attrStore.get(el) || {};
      if (recs[a] && recs[a].t === cur) return;
      var t = translateString(cur, false);
      if (t !== null && t !== cur) {
        recs[a] = { o: cur, t: t };
        attrStore.set(el, recs);
        el.setAttribute(a, t);
      }
    });
  }
  function restoreAttrs(el) {
    var recs = attrStore.get(el);
    if (!recs) return;
    Object.keys(recs).forEach(function (a) {
      if (el.getAttribute(a) === recs[a].t) el.setAttribute(a, recs[a].o);
    });
    attrStore.delete(el);
  }

  // ------------------------------------------------------------------------
  // Percorrer a página
  // ------------------------------------------------------------------------
  function walk(root, onText, onEl) {
    if (!root) return;
    if (root.nodeType === 3) { onText(root); return; }
    if (root.nodeType !== 1 && root.nodeType !== 9 && root.nodeType !== 11) return;
    if (root.nodeType === 1) {
      if (isSkipped(root)) return;
      onEl(root);
    }
    var tw = document.createTreeWalker(root, NodeFilter.SHOW_TEXT | NodeFilter.SHOW_ELEMENT, null);
    var n;
    while ((n = tw.nextNode())) {
      if (n.nodeType === 3) onText(n); else onEl(n);
    }
  }
  function translateTree(root) { walk(root, translateTextNode, translateAttrs); }
  function restoreTree(root) { walk(root, restoreTextNode, restoreAttrs); }

  // ------------------------------------------------------------------------
  // Observador: traduz conteúdos novos (saídas Shiny, gráficos, tabelas,
  // tooltips do plotly, listas dos filtros) enquanto o idioma for EN
  // ------------------------------------------------------------------------
  var observer = new MutationObserver(function (muts) {
    if (state.lang !== 'en' || !state.loaded) return;
    for (var i = 0; i < muts.length; i++) {
      var m = muts[i];
      if (m.type === 'childList') {
        for (var j = 0; j < m.addedNodes.length; j++) translateTree(m.addedNodes[j]);
      } else if (m.type === 'characterData') {
        translateTextNode(m.target);
      } else if (m.type === 'attributes') {
        translateAttrs(m.target);
      }
    }
  });
  function startObserver() {
    observer.observe(document.body, {
      childList: true, subtree: true, characterData: true,
      attributes: true, attributeFilter: ATTRS
    });
  }

  // ------------------------------------------------------------------------
  // Botão PT | EN
  // ------------------------------------------------------------------------
  function injectStyle() {
    var css =
      '#pam-i18n-toggle{position:absolute;top:12px;right:16px;z-index:1031;' +
      'display:inline-flex;border:1px solid rgba(255,255,255,.85);border-radius:14px;' +
      'overflow:hidden;font-size:11px;line-height:1;font-weight:bold;}' +
      '#pam-i18n-toggle button{background:transparent;color:#fff;border:0;' +
      'padding:6px 9px;cursor:pointer;font-weight:bold;letter-spacing:.5px;}' +
      '#pam-i18n-toggle button.active{background:#fff;color:#9442d4;}' +
      '#pam-i18n-toggle button:focus{outline:none;}';
    var s = document.createElement('style');
    s.appendChild(document.createTextNode(css));
    document.head.appendChild(s);
  }
  function injectToggle() {
    if (document.getElementById('pam-i18n-toggle')) return;
    var host = document.querySelector('.navbar') || document.body;
    var box = document.createElement('div');
    box.id = 'pam-i18n-toggle';
    box.className = 'i18n-skip';
    box.setAttribute('role', 'group');
    box.setAttribute('aria-label', 'Idioma / Language');
    [['pt', 'PT', 'Português'], ['en', 'EN', 'English']].forEach(function (o) {
      var b = document.createElement('button');
      b.type = 'button';
      b.setAttribute('data-lang', o[0]);
      b.setAttribute('title', o[2]);
      b.textContent = o[1];
      b.addEventListener('click', function () { setLang(o[0]); });
      box.appendChild(b);
    });
    host.appendChild(box);
    paintToggle();
  }
  function paintToggle() {
    var box = document.getElementById('pam-i18n-toggle');
    if (!box) return;
    Array.prototype.forEach.call(box.querySelectorAll('button'), function (b) {
      var on = b.getAttribute('data-lang') === state.lang;
      b.className = on ? 'active' : '';
      b.setAttribute('aria-pressed', on ? 'true' : 'false');
    });
  }

  function notifyShiny() {
    if (window.Shiny && typeof window.Shiny.setInputValue === 'function') {
      window.Shiny.setInputValue(SHINY_INPUT, state.lang);
    }
  }

  function setLang(lang) {
    lang = lang === 'en' ? 'en' : 'pt';
    var changed = lang !== state.lang;
    state.lang = lang;
    try { window.localStorage.setItem(LS_KEY, lang); } catch (e) { /* ignorar */ }
    paintToggle();
    if (lang === 'en') {
      if (state.loaded) translateTree(document.body);
    } else {
      restoreTree(document.body);
    }
    if (changed) notifyShiny();
  }

  function init() {
    injectStyle();
    injectToggle();
    startObserver();
    var saved = 'pt';
    try { saved = window.localStorage.getItem(LS_KEY) || 'pt'; } catch (e) { /* ignorar */ }
    fetch(DICT_URL, { cache: 'no-cache' })
      .then(function (r) { return r.json(); })
      .then(function (data) {
        build(data);
        if (saved === 'en') setLang('en');
        else if (state.lang === 'en') translateTree(document.body);
      })
      .catch(function (err) {
        if (window.console) console.warn('[i18n] Dicionário não carregado:', err);
      });
  }

  // Quando o Shiny liga, envia o idioma actual (só relevante se for EN)
  document.addEventListener('shiny:connected', function () {
    if (state.lang === 'en') notifyShiny();
  });

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
  else init();

  window.PAMi18n = {
    setLang: setLang,
    getLang: function () { return state.lang; },
    translate: function (s) { return translateString(String(s), false) || String(s); }
  };
})();
