
/* ==========================================================================
   PAM_VERDE — SISTEMA MULTILINGUE PT | EN | FR
   ==========================================================================
   Idiomas:
     PT = Português (texto original do R/Shiny)
     EN = English
     FR = Français

   Dicionário:
     www/i18n/traducoes.json

   Formato das entradas:
     ["Texto original", "English translation", "Traduction française"]

   Funcionalidades:
     - Alternância entre PT, EN e FR.
     - Guarda o idioma seleccionado no navegador.
     - Tradução dinâmica dos conteúdos Shiny, Plotly e tabelas.
     - Tradução dos atributos title e placeholder.
     - Restauração dos textos originais em português.
     - Exclusão dos depoimentos e elementos .i18n-skip.
     - Tradução exacta nas células das tabelas.
     - Não modifica os valores nem os cálculos dos gráficos.
   ========================================================================== */

(function () {
  'use strict';

  // ========================================================================
  // 1. CONFIGURAÇÃO
  // ========================================================================

  var LS_KEY = 'pamverde_idioma';
  var DICT_URL = 'i18n/traducoes.json';
  var SHINY_INPUT = 'idioma_app';

  var LANGUAGES = ['pt', 'en', 'fr'];

  var SKIP_SELECTOR =
    'blockquote, .i18n-skip, script, style, noscript, textarea';

  var EXACT_ONLY_SELECTOR = 'td';
  var ATTRS = ['title', 'placeholder'];

  var HAS_LETTER = /\p{L}/u;

  // ========================================================================
  // 2. ESTADO DO TRADUTOR
  // ========================================================================

  var state = {
    lang: 'pt',
    loaded: false,

    exact: new Map(),

    dictionaries: {
      en: new Map(),
      fr: new Map()
    },

    fragRe: null,
    nodeRules: [],
    preRules: [],
    fragRules: [],
    soltas: new Set()
  };

  // Registos dos textos originais e traduzidos.
  var textStore = new WeakMap();
  var attrStore = new WeakMap();

  // Regras provenientes do ficheiro JSON.
  var dataRulesParciais = [];

  // ========================================================================
  // 3. FUNÇÕES AUXILIARES
  // ========================================================================

  function norm(s) {
    return String(s).replace(/\s+/g, ' ').trim();
  }

  function escRe(s) {
    return s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  }

  function splitSegments(s) {
    return String(s).split(/<[^>]+>|%\{[^}]*\}|\n/);
  }

  function validLanguage(lang) {
    return LANGUAGES.indexOf(lang) !== -1;
  }

  // ========================================================================
  // 4. CARREGAR O DICIONÁRIO
  // ========================================================================

  function build(data) {
    state.dictionaries.en = new Map();
    state.dictionaries.fr = new Map();

    state.nodeRules = [];
    state.preRules = [];
    state.fragRules = [];
    state.fragRe = null;

    dataRulesParciais = data.regras_parciais || [];
    state.soltas = new Set(data.palavras_em_frases || []);

    // ----------------------------------------------------------
    // Entradas PT / EN / FR
    // ----------------------------------------------------------

    (data.entradas || []).forEach(function (par) {
      if (!Array.isArray(par) || par.length < 2) return;

      var original = String(par[0] || '');
      var ingles = String(par[1] || '');
      var frances = String(par[2] || '');

      var a = splitSegments(original);
      var bEN = splitSegments(ingles);
      var bFR = splitSegments(frances);

      if (a.length !== bEN.length || a.length !== bFR.length) {
        a = [original.replace(/<[^>]+>/g, ' ')];
        bEN = [ingles.replace(/<[^>]+>/g, ' ')];
        bFR = [frances.replace(/<[^>]+>/g, ' ')];
      }

      for (var i = 0; i < a.length; i++) {
        var k = norm(a[i]);
        var en = norm(bEN[i] || '');
        var fr = norm(bFR[i] || '');

        if (!k || !HAS_LETTER.test(k)) continue;

        if (en && !state.dictionaries.en.has(k)) {
          state.dictionaries.en.set(k, en);
        }

        if (fr && !state.dictionaries.fr.has(k)) {
          state.dictionaries.fr.set(k, fr);
        }
      }
    });

    // ----------------------------------------------------------
    // Regras para textos completos
    // ----------------------------------------------------------

    state.nodeRules = (data.regras_texto_completo || [])
      .map(function (r) {
        return [
          new RegExp(r.de, 'u'),
          {
            en: r.para || '',
            fr: r.para_fr || ''
          }
        ];
      });

    state.loaded = true;

    prepareLanguage();
  }

  // ========================================================================
  // 5. PREPARAR O IDIOMA ACTIVO
  // ========================================================================

  function prepareLanguage() {
    if (state.lang === 'en') {
      state.exact = state.dictionaries.en;
    } else if (state.lang === 'fr') {
      state.exact = state.dictionaries.fr;
    } else {
      state.exact = new Map();
    }

    var keys = [];

    state.exact.forEach(function (v, k) {
      if (!v || k === v) return;

      var letters = (k.match(/\p{L}/gu) || []).length;

      if (letters < 2) return;

      var isPhrase =
        /\s/.test(k) ||
        /[^\p{L}]/u.test(k);

      if (isPhrase || state.soltas.has(k)) {
        keys.push(k);
      }
    });

    // Primeiro as expressões mais longas.
    keys.sort(function (a, b) {
      return b.length - a.length;
    });

    var parts = keys.map(function (k) {
      var e = escRe(k).replace(/ /g, '\\s+');

      if (/^[\p{L}\p{N}]/u.test(k)) {
        e = '(?<![\\p{L}\\p{N}])' + e;
      }

      if (/[\p{L}\p{N}]$/u.test(k)) {
        e += '(?![\\p{L}\\p{N}])';
      }

      return e;
    });

    state.fragRe = parts.length
      ? new RegExp(parts.join('|'), 'gu')
      : null;

    // ----------------------------------------------------------
    // Regras parciais por idioma
    // ----------------------------------------------------------

    state.preRules = [];
    state.fragRules = [];

    dataRulesParciais.forEach(function (r) {
      var destino = state.lang === 'fr'
        ? (r.para_fr || '')
        : (r.para || '');

      if (!destino || state.lang === 'pt') return;

      var regra = [
        new RegExp(r.de, 'gu'),
        destino
      ];

      if (r.fase === 'antes') {
        state.preRules.push(regra);
      } else {
        state.fragRules.push(regra);
      }
    });
  }

  // ========================================================================
  // 6. TRADUZIR UMA CADEIA DE TEXTO
  // ========================================================================

  function translateString(raw, exactOnly) {
    raw = String(raw);

    var n = norm(raw);

    if (!n || !HAS_LETTER.test(n)) return null;
    if (state.lang === 'pt') return null;

    var lead = raw.match(/^\s*/)[0];
    var trail = raw.match(/\s*$/)[0];

    // 1. Tradução exacta.
    var e = state.exact.get(n);

    if (e !== undefined) {
      return e === n ? null : lead + e + trail;
    }

    // 2. Regras de texto completo.
    for (var i = 0; i < state.nodeRules.length; i++) {
      var r = state.nodeRules[i];

      var destino = state.lang === 'fr'
        ? r[1].fr
        : r[1].en;

      if (destino && r[0].test(n)) {
        return lead + n.replace(r[0], destino) + trail;
      }
    }

    // Nas células das tabelas, só traduzir rótulos exactos.
    if (exactOnly) return null;

    var out = raw;
    var j;

    // 3. Regras aplicadas antes das substituições.
    for (j = 0; j < state.preRules.length; j++) {
      out = out.replace(
        state.preRules[j][0],
        state.preRules[j][1]
      );
    }

    // 4. Frases e fragmentos do dicionário.
    if (state.fragRe) {
      out = out.replace(state.fragRe, function (m) {
        var t = state.exact.get(norm(m));
        return t === undefined ? m : t;
      });
    }

    // 5. Regras parciais posteriores.
    for (j = 0; j < state.fragRules.length; j++) {
      out = out.replace(
        state.fragRules[j][0],
        state.fragRules[j][1]
      );
    }

    return out !== raw ? out : null;
  }

  // ========================================================================
  // 7. ELEMENTOS EXCLUÍDOS
  // ========================================================================

  function isSkipped(el) {
    return !el || (
      el.closest &&
      el.closest(SKIP_SELECTOR) !== null
    );
  }

  function isExactOnly(el) {
    return !!(
      el &&
      el.closest &&
      el.closest(EXACT_ONLY_SELECTOR) !== null
    );
  }

  // ========================================================================
  // 8. TRADUZIR NÓS DE TEXTO
  // ========================================================================

  function translateTextNode(node) {
    var el = node.parentElement;

    if (isSkipped(el)) return;

    var cur = node.nodeValue;
    var rec = textStore.get(node);

    if (rec && cur === rec.t) return;

    var t = translateString(cur, isExactOnly(el));

    if (t !== null && t !== cur) {
      textStore.set(node, {
        o: cur,
        t: t
      });

      node.nodeValue = t;

    } else if (rec) {
      textStore.delete(node);
    }
  }

  function restoreTextNode(node) {
    var rec = textStore.get(node);

    if (!rec) return;

    if (node.nodeValue === rec.t) {
      node.nodeValue = rec.o;
    }

    textStore.delete(node);
  }

  // ========================================================================
  // 9. TRADUZIR ATRIBUTOS HTML
  // ========================================================================

  function translateAttrs(el) {
    if (isSkipped(el)) return;

    ATTRS.forEach(function (a) {
      if (!el.hasAttribute || !el.hasAttribute(a)) return;

      var cur = el.getAttribute(a);
      var recs = attrStore.get(el) || {};

      if (recs[a] && recs[a].t === cur) return;

      var t = translateString(cur, false);

      if (t !== null && t !== cur) {
        recs[a] = {
          o: cur,
          t: t
        };

        attrStore.set(el, recs);
        el.setAttribute(a, t);
      }
    });
  }

  function restoreAttrs(el) {
    var recs = attrStore.get(el);

    if (!recs) return;

    Object.keys(recs).forEach(function (a) {
      if (el.getAttribute(a) === recs[a].t) {
        el.setAttribute(a, recs[a].o);
      }
    });

    attrStore.delete(el);
  }

  // ========================================================================
  // 10. PERCORRER A PÁGINA
  // ========================================================================

  function walk(root, onText, onEl) {
    if (!root) return;

    if (root.nodeType === 3) {
      onText(root);
      return;
    }

    if (
      root.nodeType !== 1 &&
      root.nodeType !== 9 &&
      root.nodeType !== 11
    ) {
      return;
    }

    if (root.nodeType === 1) {
      if (isSkipped(root)) return;
      onEl(root);
    }

    var tw = document.createTreeWalker(
      root,
      NodeFilter.SHOW_TEXT | NodeFilter.SHOW_ELEMENT,
      null
    );

    var n;

    while ((n = tw.nextNode())) {
      if (n.nodeType === 3) {
        onText(n);
      } else {
        onEl(n);
      }
    }
  }

  function translateTree(root) {
    walk(root, translateTextNode, translateAttrs);
  }

  function restoreTree(root) {
    walk(root, restoreTextNode, restoreAttrs);
  }

  // ========================================================================
  // 11. OBSERVAR ALTERAÇÕES DINÂMICAS DO SHINY
  // ========================================================================

  var observer = new MutationObserver(function (muts) {
    if (state.lang === 'pt' || !state.loaded) return;

    for (var i = 0; i < muts.length; i++) {
      var m = muts[i];

      if (m.type === 'childList') {
        for (var j = 0; j < m.addedNodes.length; j++) {
          translateTree(m.addedNodes[j]);
        }

      } else if (m.type === 'characterData') {
        translateTextNode(m.target);

      } else if (m.type === 'attributes') {
        translateAttrs(m.target);
      }
    }
  });

  function startObserver() {
    observer.observe(document.body, {
      childList: true,
      subtree: true,
      characterData: true,
      attributes: true,
      attributeFilter: ATTRS
    });
  }

  // ========================================================================
  // 12. ESTILOS DOS BOTÕES
  // ========================================================================

  function injectStyle() {
    var css =
      '#pam-i18n-toggle{' +
        'position:absolute;' +
        'top:12px;' +
        'right:16px;' +
        'z-index:1031;' +
        'display:inline-flex;' +
        'border:1px solid rgba(255,255,255,.85);' +
        'border-radius:14px;' +
        'overflow:hidden;' +
        'font-size:11px;' +
        'line-height:1;' +
        'font-weight:bold;' +
      '}' +

      '#pam-i18n-toggle button{' +
        'background:transparent;' +
        'color:#fff;' +
        'border:0;' +
        'padding:6px 9px;' +
        'cursor:pointer;' +
        'font-weight:bold;' +
        'letter-spacing:.5px;' +
      '}' +

      '#pam-i18n-toggle button.active{' +
        'background:#fff;' +
        'color:#9442d4;' +
      '}' +

      '#pam-i18n-toggle button:focus{' +
        'outline:none;' +
      '}';

    var s = document.createElement('style');

    s.appendChild(document.createTextNode(css));
    document.head.appendChild(s);
  }

  // ========================================================================
  // 13. CRIAR OS BOTÕES PT | EN | FR
  // ========================================================================

  function injectToggle() {
    if (document.getElementById('pam-i18n-toggle')) return;

    var host = document.querySelector('.navbar') || document.body;

    var box = document.createElement('div');

    box.id = 'pam-i18n-toggle';
    box.className = 'i18n-skip';

    box.setAttribute('role', 'group');
    box.setAttribute(
      'aria-label',
      'Idioma / Language / Langue'
    );

    [
      ['pt', 'PT', 'Português'],
      ['en', 'EN', 'English'],
      ['fr', 'FR', 'Français']
    ].forEach(function (o) {
      var b = document.createElement('button');

      b.type = 'button';
      b.setAttribute('data-lang', o[0]);
      b.setAttribute('title', o[2]);
      b.setAttribute('aria-label', o[2]);
      b.textContent = o[1];

      b.addEventListener('click', function () {
        setLang(o[0]);
      });

      box.appendChild(b);
    });

    host.appendChild(box);

    paintToggle();
  }

  function paintToggle() {
    var box = document.getElementById('pam-i18n-toggle');

    if (!box) return;

    Array.prototype.forEach.call(
      box.querySelectorAll('button'),
      function (b) {
        var on = b.getAttribute('data-lang') === state.lang;

        b.className = on ? 'active' : '';

        b.setAttribute(
          'aria-pressed',
          on ? 'true' : 'false'
        );
      }
    );
  }

  // ========================================================================
  // 14. COMUNICAR COM O SHINY
  // ========================================================================

  function notifyShiny() {
    if (
      window.Shiny &&
      typeof window.Shiny.setInputValue === 'function'
    ) {
      window.Shiny.setInputValue(
        SHINY_INPUT,
        state.lang
      );
    }
  }

  // ========================================================================
  // 15. ALTERAR O IDIOMA
  // ========================================================================

  function setLang(lang) {
    if (!validLanguage(lang)) {
      lang = 'pt';
    }

    var changed = lang !== state.lang;

    // Restaurar antes de aplicar a tradução seguinte.
    if (changed && state.loaded) {
      restoreTree(document.body);
    }

    state.lang = lang;

    if (state.loaded) {
      prepareLanguage();
    }

    try {
      window.localStorage.setItem(LS_KEY, lang);
    } catch (e) {
      // Continuar mesmo se o armazenamento estiver indisponível.
    }

    paintToggle();

    if (lang === 'pt') {
      restoreTree(document.body);

    } else if (state.loaded) {
      translateTree(document.body);
    }

    if (changed) {
      notifyShiny();
    }
  }

  // ========================================================================
  // 16. INICIALIZAR
  // ========================================================================

  function init() {
    injectStyle();
    injectToggle();
    startObserver();

    var saved = 'pt';

    try {
      saved = window.localStorage.getItem(LS_KEY) || 'pt';
    } catch (e) {
      // O idioma inicial será português.
    }

    if (!validLanguage(saved)) {
      saved = 'pt';
    }

    fetch(DICT_URL, {
      cache: 'no-cache'
    })
      .then(function (r) {
        if (!r.ok) {
          throw new Error('HTTP ' + r.status);
        }

        return r.json();
      })
      .then(function (data) {
        build(data);
        setLang(saved);
      })
      .catch(function (err) {
        if (window.console) {
          console.warn(
            '[i18n] Erro ao carregar traducoes.json:',
            err
          );
        }
      });
  }

  // Comunicar o idioma quando o Shiny se liga.
  document.addEventListener('shiny:connected', function () {
    if (state.lang !== 'pt') {
      notifyShiny();
    }
  });

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  // ========================================================================
  // 17. API PÚBLICA
  // ========================================================================

  window.PAMi18n = {
    setLang: setLang,

    getLang: function () {
      return state.lang;
    },

    translate: function (s) {
      return translateString(String(s), false) || String(s);
    }
  };

})();
