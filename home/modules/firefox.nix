{ lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      extensions =
        with pkgs.nur.repos.rycee.firefox-addons; [
          # Note: Need to apply Catppuccin Firefox Color theme (Lavender) manually. It will stick afterwards.
          firefox-color
          onepassword-password-manager
          ublock-origin
          vimium
          # Everhour
          (buildFirefoxXpiAddon {
            pname = "everhour";
            version = "1.6.235";
            addonId = "time-tracker-on-site@everhour.com";
            url = "https://everhour.com/addon/firefox/everhour_time_tracker.xpi";
            sha256 = "sha256-HE5L/QQwRLdLfrbG76Rftr1B928OFn5FvbCyXVwaByc=";
            meta = {
              homepage = "https://everhour.com/";
              description = "Everhour integration extension";
              platforms = lib.platforms.all;
            };
          })
        ];
      settings = {
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.showMobileBookmarks" = false;
        "browser.compactmode.show" = true;
        "browser.contentblocking.report.lockwise.enabled" = false;
        "browser.formfill.enable" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "duckduckgo";
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.quitShortcut.disabled" = true;
        "browser.search.region" = "NL";
        "browser.search.suggest.enabled" = false;
        "browser.send_pings" = false;
        "browser.startup.page" = 3;
        "browser.tabs.drawInTitlebar" = false;
        "browser.theme.dark-private-windows" = true;
        "browser.toolbars.bookmarks.visibility" = false;
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["firefoxcolor_mozilla_com-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","save-to-pocket-button","downloads-button","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","developer-button","firefoxcolor_mozilla_com-browser-action"],"dirtyAreaCache":["unified-extensions-area","nav-bar","toolbar-menubar","TabsToolbar","PersonalToolbar"],"currentVersion":20,"newElementCount":4}
        '';
        "browser.uitour.enabled" = false;
        "browser.urlbar.eventTelemetry.enabled" = false;
        "browser.urlbar.quicksuggest.scenario" = "offline";
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.warnOnQuit" = false;
        "cookiebanners.service.mode" = 1;
        "cookiebanners.service.mode.privateBrowsing" = 1;
        "cookiebanners.ui.desktop.enabled" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "devtools.cache.disabled" = true;
        "devtools.command-button-screenshot.enabled" = true;
        "devtools.everOpened" = true;
        "dom.forms.autocomplete.formautofill" = false;
        "dom.payments.defaults.saveAddress" = false;
        "dom.private-attribution.submission.enabled" = false;
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "extensions.abuseReport.enabled" = false;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.pocket.showHome" = false;
        "extensions.ui.extension.hidden" = true;
        "extensions.webcompat-reporter.enabled" = false;
        "identity.fxaccounts.commands.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "identity.fxaccounts.pairing.enabled" = false;
        "identity.fxaccounts.toolbar.enabled" = false;
        "layers.acceleration.force-enabled" = true;
        "network.allow-experiments" = false;
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "ui.systemUsesDarkTheme" = true;
      };
    };
  };
}
