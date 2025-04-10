// Config file for Finicky
// Specifies which browser to open based on the URL
// Docs: https://github.com/johnste/finicky
module.exports = {
    defaultBrowser: "Safari",

    // Options for all browsers
    options: {
        hideIcon: false, // Show icon in menu bar
        logRequests: true, // Log all requests for debugging
    },

    // URL rewriting rules
    rewrite: [{
            // Force HTTPS for security
            match: ({ url }) => url.protocol === "http",
            url: { protocol: "https" }
        },
        {
            // Clean up tracking parameters
            match: () => true,
            url: ({ url }) => {
                const removeParams = [
                    // Analytics tracking
                    'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content',
                    // Social media tracking
                    'fbclid', 'igshid', 'twclid',
                    // Google tracking
                    '_ga', '_gl', 'gclid', 'dclid',
                    // Microsoft tracking
                    'msclkid',
                    // Generic tracking
                    'ref', 'source', 'ref_src', 'platform',
                    'campaign_id', 'affiliate', 'referrer',
                    // Amazon tracking
                    'tag', 'ascsubtag', 'linkId',
                    // Other common tracking
                    'share', 'share_source'
                ];
                removeParams.forEach(param => url.searchParams.delete(param));
                return url;
            }
        },
        {
            // Convert YouTube shorts to regular videos
            match: ({ url }) => url.host === "www.youtube.com" && url.pathname.startsWith("/shorts/"),
            url: ({ url }) => ({
                ...url,
                pathname: `/watch`,
                searchParams: { v: url.pathname.split("/")[2] }
            })
        },
        {
            // Convert Twitter/X mobile links to desktop
            match: ({ url }) => url.host === "x.com" || url.host === "mobile.twitter.com",
            url: ({ url }) => ({...url, host: "twitter.com" })
        },
        {
            // Convert Medium mobile links to desktop
            match: ({ url }) => url.host === "medium.com" && url.pathname.startsWith("/m/"),
            url: ({ url }) => ({...url, pathname: url.pathname.replace("/m/", "/") })
        }
    ],

    handlers: [{
            // Work related (Safari)
            browser: "/Applications/Safari.app",
            match: [
                // Google Workspace
                "*.google.com/*",
                "*docs.google.com/*",
                "*meet.google.com/*",
                "*calendar.google.com/*",
                "*drive.google.com/*",

                // Work tools
                "*and-digital.okta.com/*",
                "*and-digital.zoom.us/*",
                "*atlassian.com/*",
                "*dev.azure.com/*",
                "*luna.and-digital.com/*",
                "*miro.com/*",
                "*zoom.com/*",
                "*.atlassian.net/*",

                // Communication
                "*slack.com/*",
                "*teams.microsoft.com/*",
                "*outlook.office.com/*",
                "*outlook.office365.com/*", // Added Office 365 domain

                // Project management
                "*trello.com/*",
                "*asana.com/*",
                "*monday.com/*",
                "*linear.app/*", // Added Linear
                "*clickup.com/*", // Added ClickUp

                // Development (work)
                "*gitlab.company.com/*",
                "*jenkins.company.com/*",

                // Special cases
                ({ url }) => url.pathname.includes("meet") && url.searchParams.has("authuser") // Handle Google Meet with auth
            ]
        },
        {
            // Development (Safari)
            browser: "/Applications/Safari.app",
            match: [
                // Version control
                "*.github.com/*",
                "*.gitlab.com/*",
                "*.bitbucket.org/*",

                // Development resources
                "*.stackoverflow.com/*",
                "*.stackexchange.com/*",
                "*.npmjs.com/*",
                "*.docker.com/*",
                "*.digitalocean.com/*", // Added DigitalOcean
                "*.aws.amazon.com/*", // Added AWS

                // Documentation
                "*.readthedocs.io/*",
                "*.docs.rs/*",
                "*.rust-lang.org/*",
                "*.mozilla.org/en-US/docs/*", // Added MDN
                "*.kubernetes.io/*", // Added Kubernetes docs

                // Local development
                "localhost:*/*",
                "127.0.0.1:*/*",
                "*.test/*",
                "*.local/*",

                // Package managers
                "*.pypi.org/*",
                "*.rubygems.org/*",
                "*.maven.org/*"
            ]
        },
        {
            // Personal (Safari)
            browser: "/Applications/Safari.app",
            match: [
                // Social media
                "*reddit.com/*",
                "*twitter.com/*",
                "*x.com/*", // Added X (Twitter)
                "*instagram.com/*",
                "*facebook.com/*",
                "*linkedin.com/*", // Added LinkedIn

                // Entertainment
                "*youtube.com/*",
                "*netflix.com/*",
                "*spotify.com/*",
                "*twitch.tv/*", // Added Twitch

                // News and reading
                "*medium.com/*",
                "*news.ycombinator.com/*",
                "*reddit.com/r/programming/*",
                "*dev.to/*", // Added Dev.to
                "*hashnode.com/*" // Added Hashnode
            ]
        }
    ]
};