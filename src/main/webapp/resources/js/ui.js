/* =========================================================
   Laptopshop UI Helpers
   - Toast, modal confirm, dropdown, qty stepper, misc
   ========================================================= */
(function () {
    'use strict';

    /* -------- Toast -------- */
    function ensureToastHost() {
        let host = document.querySelector('.ui-toasts');
        if (!host) {
            host = document.createElement('div');
            host.className = 'ui-toasts';
            host.setAttribute('role', 'status');
            host.setAttribute('aria-live', 'polite');
            document.body.appendChild(host);
        }
        return host;
    }

    const iconMap = {
        success: '<i class="bi bi-check-circle-fill"></i>',
        danger:  '<i class="bi bi-x-octagon-fill"></i>',
        warning: '<i class="bi bi-exclamation-triangle-fill"></i>',
        info:    '<i class="bi bi-info-circle-fill"></i>'
    };

    function toast(opts) {
        opts = opts || {};
        const type = opts.type || 'info';
        const title = opts.title || '';
        const message = opts.message || opts.msg || '';
        const duration = opts.duration != null ? opts.duration : 3200;
        const host = ensureToastHost();

        const el = document.createElement('div');
        el.className = 'ui-toast ui-toast--' + type;
        el.innerHTML =
            '<div class="ui-toast__icon">' + (iconMap[type] || iconMap.info) + '</div>' +
            '<div>' +
              (title ? '<p class="ui-toast__title">' + escapeHtml(title) + '</p>' : '') +
              '<p class="ui-toast__msg">' + escapeHtml(message) + '</p>' +
            '</div>' +
            '<button type="button" class="ui-toast__close" aria-label="Close">&times;</button>';

        el.querySelector('.ui-toast__close').addEventListener('click', () => close());
        host.appendChild(el);

        let t;
        function close() {
            if (!el.isConnected) return;
            el.style.animation = 'ui-toast-out 160ms forwards';
            setTimeout(() => el.remove(), 180);
            clearTimeout(t);
        }
        if (duration > 0) t = setTimeout(close, duration);
        return { close };
    }

    toast.success = (msg, title) => toast({ type: 'success', message: msg, title: title });
    toast.error   = (msg, title) => toast({ type: 'danger',  message: msg, title: title });
    toast.warning = (msg, title) => toast({ type: 'warning', message: msg, title: title });
    toast.info    = (msg, title) => toast({ type: 'info',    message: msg, title: title });

    /* -------- Modal confirm -------- */
    function confirmDialog(opts) {
        opts = opts || {};
        const title   = opts.title   || 'Xác nhận';
        const message = opts.message || 'Bạn có chắc chắn muốn thực hiện thao tác này?';
        const okText  = opts.okText  || 'Xác nhận';
        const cancelText = opts.cancelText || 'Huỷ';
        const variant = opts.variant || 'danger'; // danger | warning | primary
        const onOk    = opts.onOk;

        const iconColorMap = {
            danger:  { bg: '#fee2e2', fg: '#dc2626', icon: 'bi-exclamation-triangle-fill' },
            warning: { bg: '#fef3c7', fg: '#d97706', icon: 'bi-exclamation-circle-fill' },
            primary: { bg: '#dbeafe', fg: '#2563eb', icon: 'bi-info-circle-fill' }
        };
        const c = iconColorMap[variant] || iconColorMap.danger;
        const btnClass = variant === 'primary' ? 'ui-btn' : (variant === 'warning' ? 'ui-btn ui-btn--accent' : 'ui-btn ui-btn--danger');

        const backdrop = document.createElement('div');
        backdrop.className = 'ui-modal-backdrop';
        backdrop.innerHTML =
            '<div class="ui-modal" role="dialog" aria-modal="true">' +
              '<div class="ui-modal__header">' +
                '<div class="ui-modal__icon" style="background:' + c.bg + '; color:' + c.fg + ';"><i class="bi ' + c.icon + '"></i></div>' +
                '<h5 class="ui-modal__title">' + escapeHtml(title) + '</h5>' +
              '</div>' +
              '<div class="ui-modal__body">' + message + '</div>' +
              '<div class="ui-modal__footer">' +
                '<button type="button" class="ui-btn ui-btn--ghost" data-act="cancel">' + escapeHtml(cancelText) + '</button>' +
                '<button type="button" class="' + btnClass + '" data-act="ok">' + escapeHtml(okText) + '</button>' +
              '</div>' +
            '</div>';

        const prevActive = document.activeElement;
        const prevOverflow = document.body.style.overflow;

        function close() {
            backdrop.style.animation = 'ui-fade-in 120ms reverse forwards';
            setTimeout(() => backdrop.remove(), 150);
            document.removeEventListener('keydown', onKey);
            document.body.style.overflow = prevOverflow;
            if (prevActive && typeof prevActive.focus === 'function') {
                try { prevActive.focus(); } catch (_) {}
            }
        }
        function onKey(e) {
            if (e.key === 'Escape') { close(); return; }
            if (e.key === 'Tab') {
                const focusables = backdrop.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
                if (!focusables.length) return;
                const first = focusables[0];
                const last = focusables[focusables.length - 1];
                if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
                else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
            }
        }
        backdrop.addEventListener('click', (e) => {
            if (e.target === backdrop) close();
        });
        backdrop.querySelector('[data-act=cancel]').addEventListener('click', close);
        backdrop.querySelector('[data-act=ok]').addEventListener('click', () => {
            close();
            if (typeof onOk === 'function') onOk();
        });

        document.body.appendChild(backdrop);
        document.body.style.overflow = 'hidden';
        document.addEventListener('keydown', onKey);
        setTimeout(() => backdrop.querySelector('[data-act=ok]').focus(), 50);
        return { close };
    }

    /* -------- Auto-bind: [data-confirm] on <form> or <a> or <button> -------- */
    function bindConfirm() {
        document.addEventListener('click', (e) => {
            const el = e.target.closest('[data-confirm]');
            if (!el) return;
            e.preventDefault();
            confirmDialog({
                title: el.dataset.confirmTitle || 'Xác nhận xoá',
                message: el.dataset.confirm,
                okText: el.dataset.confirmOk || 'Xoá',
                cancelText: el.dataset.confirmCancel || 'Huỷ',
                variant: el.dataset.confirmVariant || 'danger',
                onOk: () => {
                    if (el.tagName === 'FORM') { el.submit(); return; }
                    const form = el.closest('form');
                    if (form && el.type === 'submit') { form.submit(); return; }
                    if (el.tagName === 'A' && el.href) { window.location.href = el.href; return; }
                    if (el.dataset.confirmForm) {
                        const f = document.getElementById(el.dataset.confirmForm);
                        if (f) f.submit();
                    }
                }
            });
        });
    }

    /* -------- Qty stepper -------- */
    function bindQtyStepper() {
        document.addEventListener('click', (e) => {
            const btn = e.target.closest('.ui-qty__btn, .btn-minus, .btn-plus');
            if (!btn) return;
            const wrap = btn.closest('.ui-qty, .quantity, .input-group');
            if (!wrap) return;
            const input = wrap.querySelector('input[type=text], input[type=number], .ui-qty__input');
            if (!input) return;
            const isPlus = btn.classList.contains('ui-qty__btn--plus') || btn.classList.contains('btn-plus') || btn.dataset.act === 'plus';
            const current = parseInt(input.value || '1', 10) || 1;
            const next = isPlus ? current + 1 : Math.max(1, current - 1);
            input.value = next;
            input.dispatchEvent(new Event('change', { bubbles: true }));
        });
    }

    /* -------- Password toggle -------- */
    function bindPwdToggle() {
        document.addEventListener('click', (e) => {
            const t = e.target.closest('.ls-pwd__toggle, [data-password-toggle]');
            if (!t) return;
            const wrap = t.closest('[data-password]') || t.parentElement;
            const input = wrap ? wrap.querySelector('input') : null;
            if (!input) return;
            input.type = input.type === 'password' ? 'text' : 'password';
            t.querySelector('i').className = input.type === 'password' ? 'bi bi-eye' : 'bi bi-eye-slash';
        });
    }

    /* -------- Dropdown (data-dropdown) -------- */
    function bindDropdown() {
        document.addEventListener('click', (e) => {
            const trigger = e.target.closest('[data-dd-toggle]');
            // Close all when clicking outside a dropdown
            if (!trigger) {
                document.querySelectorAll('.is-open[data-dd]').forEach(d => d.classList.remove('is-open'));
                return;
            }
            e.preventDefault();
            const dd = trigger.closest('[data-dd]');
            if (!dd) return;
            const isOpen = dd.classList.contains('is-open');
            document.querySelectorAll('.is-open[data-dd]').forEach(d => d.classList.remove('is-open'));
            if (!isOpen) dd.classList.add('is-open');
        });
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') document.querySelectorAll('.is-open[data-dd]').forEach(d => d.classList.remove('is-open'));
        });
    }

    /* -------- Back to top -------- */
    function bindBackToTop() {
        const fab = document.querySelector('.ui-fab, .back-to-top');
        if (!fab) return;
        const onScroll = () => {
            if (window.scrollY > 400) fab.classList.add('is-visible');
            else fab.classList.remove('is-visible');
        };
        window.addEventListener('scroll', onScroll, { passive: true });
        onScroll();
        fab.addEventListener('click', (e) => {
            if (fab.getAttribute('href') === '#') {
                e.preventDefault();
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        });
    }

    /* -------- Sticky header shadow -------- */
    function bindStickyHeader() {
        const h = document.querySelector('.ls-header');
        if (!h) return;
        const onScroll = () => { if (window.scrollY > 8) h.classList.add('is-scrolled'); else h.classList.remove('is-scrolled'); };
        window.addEventListener('scroll', onScroll, { passive: true });
        onScroll();
    }

    /* -------- Mobile nav toggle (client) -------- */
    function bindMobileNav() {
        const tg = document.querySelector('.ls-mobile-toggle');
        const nav = document.querySelector('.ls-nav');
        const catbar = document.querySelector('.ls-header__catbar');
        if (tg && tg.matches('[data-category-toggle]')) return;
        if (!tg || !nav) return;
        tg.addEventListener('click', () => {
            const isOpen = nav.classList.toggle('is-open');
            if (catbar) catbar.classList.toggle('is-open', isOpen);
            tg.setAttribute('aria-expanded', String(isOpen));
        });
        document.addEventListener('click', (e) => {
            if (!nav.classList.contains('is-open')) return;
            if (e.target.closest('.ls-header')) return;
            nav.classList.remove('is-open');
            if (catbar) catbar.classList.remove('is-open');
            tg.setAttribute('aria-expanded', 'false');
        });
    }

    /* -------- Retail category drawer -------- */
    function bindCategoryDrawer() {
        const drawer = document.querySelector('.ls-category-drawer');
        const backdrop = document.querySelector('.ls-category-backdrop');
        const toggles = document.querySelectorAll('[data-category-toggle]');
        if (!drawer || !toggles.length) return;
        let previousFocus = null;

        const open = () => {
            previousFocus = document.activeElement;
            document.body.classList.add('ls-category-open');
            drawer.setAttribute('aria-hidden', 'false');
            toggles.forEach((toggle) => toggle.setAttribute('aria-expanded', 'true'));
            if (backdrop) backdrop.hidden = false;
            document.body.style.overflow = 'hidden';
            focusFirst(drawer);
        };
        const close = () => {
            document.body.classList.remove('ls-category-open');
            drawer.setAttribute('aria-hidden', 'true');
            toggles.forEach((toggle) => toggle.setAttribute('aria-expanded', 'false'));
            if (backdrop) backdrop.hidden = true;
            document.body.style.overflow = '';
            restoreFocus(previousFocus);
        };

        toggles.forEach((toggle) => toggle.addEventListener('click', open));
        document.querySelectorAll('[data-category-close]').forEach((btn) => btn.addEventListener('click', close));
        drawer.querySelectorAll('a').forEach((link) => link.addEventListener('click', close));
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') close();
            trapFocus(e, drawer, document.body.classList.contains('ls-category-open'));
        });
    }

    /* -------- Retail catalog filter drawer -------- */
    function bindCatalogFilterDrawer() {
        const filter = document.querySelector('#lsCatalogFilter');
        const backdrop = document.querySelector('.ls-filter-backdrop');
        if (!filter) return;
        let previousFocus = null;

        const open = () => {
            previousFocus = document.activeElement;
            document.body.classList.add('ls-filter-open');
            if (backdrop) backdrop.hidden = false;
            document.body.style.overflow = 'hidden';
            focusFirst(filter);
        };
        const close = () => {
            document.body.classList.remove('ls-filter-open');
            if (backdrop) backdrop.hidden = true;
            document.body.style.overflow = '';
            restoreFocus(previousFocus);
        };

        document.querySelectorAll('[data-filter-open]').forEach((btn) => btn.addEventListener('click', open));
        document.querySelectorAll('[data-filter-close]').forEach((btn) => btn.addEventListener('click', close));
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') close();
            trapFocus(e, filter, document.body.classList.contains('ls-filter-open'));
        });
    }

    /* -------- Retail sort pills -------- */
    function bindSortPills() {
        document.addEventListener('click', (e) => {
            const pill = e.target.closest('[data-sort-value]');
            if (!pill) return;
            const value = pill.dataset.sortValue || 'gia-nothing';
            const radio = document.querySelector('input[name="radio-sort"][value="' + value + '"]');
            if (radio) radio.checked = true;
            const btn = document.getElementById('btnFilter');
            if (btn) btn.click();
        });
    }

    /* -------- Product grid/list view toggle -------- */
    function bindProductViewToggle() {
        document.addEventListener('click', (e) => {
            const btn = e.target.closest('.ls-view-toggle button[data-view]');
            if (!btn) return;
            const wrap = btn.closest('.ls-view-toggle');
            const grid = document.getElementById('productGrid');
            if (!wrap || !grid) return;
            wrap.querySelectorAll('button').forEach((item) => item.classList.remove('is-active'));
            btn.classList.add('is-active');
            grid.classList.toggle('is-list', btn.dataset.view === 'list');
        });
    }

    /* -------- Checkout/cart retail interactions -------- */
    function bindRetailCommercePolish() {
        document.addEventListener('change', (e) => {
            const radio = e.target.closest('.ls-payment-tile input[type="radio"]');
            if (!radio) return;
            const group = radio.closest('.ls-payment-tiles');
            if (!group) return;
            group.querySelectorAll('.ls-payment-tile').forEach((tile) => {
                const input = tile.querySelector('input[type="radio"]');
                tile.classList.toggle('is-active', !!input && input.checked);
            });
        });

        document.addEventListener('click', (e) => {
            const apply = e.target.closest('.ls-cart-voucher button');
            if (!apply) return;
            const voucher = apply.closest('.ls-cart-voucher');
            const code = voucher && voucher.querySelector('input') ? voucher.querySelector('input').value.trim() : '';
            if (!code) {
                toast.warning('Hãy nhập mã ưu đãi trước khi áp dụng.');
                return;
            }
            toast.info('Mã ưu đãi đã được lưu để nhân viên kiểm tra khi xác nhận đơn. Tổng tiền hiện chưa tự động giảm.');
        });
    }

    /* -------- Search suggestions -------- */
    function bindSearchSuggest() {
        const form = document.querySelector('.ls-search');
        const input = document.querySelector('[data-search-suggest-input]');
        const panel = document.querySelector('[data-search-suggest]');
        if (!form || !input || !panel) return;

        let timer = null;
        let controller = null;

        const hide = () => {
            panel.hidden = true;
            panel.innerHTML = '';
            form.classList.remove('has-suggestions');
        };

        const render = (items) => {
            if (!items || !items.length) {
                panel.innerHTML = '<div class="ls-search-suggest__empty">Không tìm thấy gợi ý phù hợp</div>';
                panel.hidden = false;
                form.classList.add('has-suggestions');
                return;
            }

            panel.innerHTML = items.map((item) => (
                '<a href="/product/' + encodeURIComponent(item.id) + '" class="ls-search-suggest__item">' +
                    '<img src="/images/product/' + escapeHtml(item.image || '') + '" alt="" />' +
                    '<span><strong>' + escapeHtml(item.name) + '</strong><small>' + escapeHtml(item.factory || 'Laptop') + '</small></span>' +
                    '<b>' + formatMoney(item.price) + '₫</b>' +
                '</a>'
            )).join('');
            panel.hidden = false;
            form.classList.add('has-suggestions');
        };

        input.addEventListener('input', () => {
            const keyword = input.value.trim();
            clearTimeout(timer);
            if (keyword.length < 2) {
                hide();
                return;
            }
            timer = setTimeout(async () => {
                if (controller) controller.abort();
                controller = new AbortController();
                try {
                    const res = await fetch('/api/products/suggest?name=' + encodeURIComponent(keyword), {
                        signal: controller.signal,
                        headers: { 'Accept': 'application/json' }
                    });
                    if (!res.ok) throw new Error('suggest failed');
                    render(await res.json());
                } catch (err) {
                    if (err.name !== 'AbortError') hide();
                }
            }, 220);
        });

        document.addEventListener('click', (e) => {
            if (!e.target.closest('.ls-search')) hide();
        });
        input.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') hide();
        });
    }

    /* -------- Browser-local wishlist -------- */
    function bindWishlist() {
        const key = 'laptopshop:wishlist';
        const read = () => {
            try { return JSON.parse(localStorage.getItem(key) || '[]'); }
            catch (_) { return []; }
        };
        const write = (items) => localStorage.setItem(key, JSON.stringify(items));
        const setState = (button, active) => {
            button.classList.toggle('is-active', active);
            button.setAttribute('aria-pressed', String(active));
            const icon = button.querySelector('i');
            if (icon) icon.className = active ? 'bi bi-heart-fill' : 'bi bi-heart';
        };

        const syncButtons = () => {
            const ids = new Set(read().map((item) => String(item.id)));
            document.querySelectorAll('[data-wishlist-toggle]').forEach((button) => {
                setState(button, ids.has(String(button.dataset.productId)));
            });
        };

        document.addEventListener('click', (e) => {
            const button = e.target.closest('[data-wishlist-toggle]');
            if (!button) return;
            e.preventDefault();

            const id = String(button.dataset.productId || '');
            const name = button.dataset.productName || 'Sản phẩm';
            if (!id) return;

            const items = read();
            const exists = items.some((item) => String(item.id) === id);
            const next = exists ? items.filter((item) => String(item.id) !== id) : [...items, { id, name }];
            write(next);
            setState(button, !exists);
            if (exists) toast.info('Đã bỏ khỏi danh sách yêu thích trên trình duyệt này.');
            else toast.success('Đã lưu ' + name + ' vào yêu thích trên trình duyệt này.');
        });

        syncButtons();
    }

    /* -------- Newsletter signup -------- */
    function bindNewsletterSignup() {
        document.addEventListener('submit', (e) => {
            const form = e.target.closest('[data-newsletter-form]');
            if (!form) return;
            e.preventDefault();

            const input = form.querySelector('input[type="email"]');
            if (input && !input.checkValidity()) {
                input.reportValidity();
                return;
            }

            toast.success('Đã ghi nhận email nhận ưu đãi. Laptopshop sẽ gửi tin khi có khuyến mãi phù hợp.');
            form.reset();
        });
    }

    /* -------- Sidebar toggle (admin) -------- */
    function bindSidebarToggle() {
        const tg = document.querySelector('.la-sidebar-toggle');
        if (!tg) return;
        tg.addEventListener('click', () => document.body.classList.toggle('la-sidebar-open'));
        const bd = document.querySelector('.la-sidebar-backdrop');
        if (bd) bd.addEventListener('click', () => document.body.classList.remove('la-sidebar-open'));
    }

    /* -------- Image uploader preview -------- */
    function bindUploader() {
        document.querySelectorAll('.la-uploader').forEach((up) => {
            const input = up.querySelector('input[type=file]');
            const preview = up.querySelector('.la-uploader__preview');
            if (!input) return;
            const setFile = (f) => {
                if (!f || !preview) return;
                const r = new FileReader();
                r.onload = (e) => {
                    preview.src = e.target.result;
                    up.classList.add('has-file');
                };
                r.readAsDataURL(f);
            };
            input.addEventListener('change', (e) => setFile(e.target.files && e.target.files[0]));
            ['dragenter', 'dragover'].forEach(ev => up.addEventListener(ev, (e) => { e.preventDefault(); up.classList.add('is-drag'); }));
            ['dragleave', 'drop'].forEach(ev => up.addEventListener(ev, (e) => { e.preventDefault(); up.classList.remove('is-drag'); }));
            up.addEventListener('drop', (e) => {
                const f = e.dataTransfer && e.dataTransfer.files && e.dataTransfer.files[0];
                if (!f) return;
                const dt = new DataTransfer();
                dt.items.add(f);
                input.files = dt.files;
                setFile(f);
            });
        });
    }

    /* -------- Tabs -------- */
    function bindTabs() {
        document.addEventListener('click', (e) => {
            const tab = e.target.closest('[data-tab]');
            if (!tab) return;
            const key = tab.dataset.tab;
            const scope = tab.closest('[data-tabs]') || document;
            scope.querySelectorAll('[data-tab]').forEach(t => t.classList.toggle('is-active', t === tab));
            scope.querySelectorAll('[data-tab-panel]').forEach(p => p.hidden = (p.dataset.tabPanel !== key));
        });
    }

    /* -------- Filter chips auto-sync (product listing) -------- */
    // Helpers
    function focusableElements(scope) {
        return Array.from(scope.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'))
            .filter((el) => !el.disabled && el.offsetParent !== null);
    }

    function focusFirst(scope) {
        const items = focusableElements(scope);
        if (items.length) items[0].focus();
    }

    function restoreFocus(el) {
        if (el && typeof el.focus === 'function') {
            try { el.focus(); } catch (_) {}
        }
    }

    function trapFocus(e, scope, enabled) {
        if (!enabled || e.key !== 'Tab') return;
        const items = focusableElements(scope);
        if (!items.length) return;
        const first = items[0];
        const last = items[items.length - 1];
        if (e.shiftKey && document.activeElement === first) {
            e.preventDefault();
            last.focus();
        } else if (!e.shiftKey && document.activeElement === last) {
            e.preventDefault();
            first.focus();
        }
    }

    function formatMoney(value) {
        return new Intl.NumberFormat('vi-VN', { maximumFractionDigits: 0 }).format(Number(value || 0));
    }

    function escapeHtml(s) {
        return String(s == null ? '' : s)
            .replaceAll('&', '&amp;')
            .replaceAll('<', '&lt;')
            .replaceAll('>', '&gt;')
            .replaceAll('"', '&quot;')
            .replaceAll("'", '&#39;');
    }

    /* -------- Init -------- */
    function init() {
        bindConfirm();
        bindQtyStepper();
        bindPwdToggle();
        bindDropdown();
        bindBackToTop();
        bindStickyHeader();
        bindMobileNav();
        bindCategoryDrawer();
        bindCatalogFilterDrawer();
        bindSortPills();
        bindProductViewToggle();
        bindRetailCommercePolish();
        bindSearchSuggest();
        bindWishlist();
        bindNewsletterSignup();
        bindSidebarToggle();
        bindUploader();
        bindTabs();
    }

    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
    else init();

    window.UI = { toast, confirm: confirmDialog };
    window.uiToast = toast;
})();
