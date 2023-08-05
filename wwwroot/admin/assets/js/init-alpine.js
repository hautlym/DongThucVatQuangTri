function data() {
    function getThemeFromLocalStorage() {
        // if user already changed the theme, use it
        if (window.localStorage.getItem('dark')) {
            return JSON.parse(window.localStorage.getItem('dark'))
        }

        // else return their preferences
        return (
            !!window.matchMedia &&
            window.matchMedia('(prefers-color-scheme: dark)').matches
        )
    }

    function setThemeToLocalStorage(value) {
        window.localStorage.setItem('dark', value)
    }

    return {
        dark: getThemeFromLocalStorage(),
        toggleTheme() {
            this.dark = !this.dark
            setThemeToLocalStorage(this.dark)
        },
        isSideMenuOpen: false,
        toggleSideMenu() {
            this.isSideMenuOpen = !this.isSideMenuOpen
        },
        closeSideMenu() {
            this.isSideMenuOpen = false
        },
        isNotificationsMenuOpen: false,
        toggleNotificationsMenu() {
            this.isNotificationsMenuOpen = !this.isNotificationsMenuOpen
        },
        closeNotificationsMenu() {
            this.isNotificationsMenuOpen = false
        },
        isProfileMenuOpen: false,
        toggleProfileMenu() {
            this.isProfileMenuOpen = !this.isProfileMenuOpen
        },
        closeProfileMenu() {
            this.isProfileMenuOpen = false
        },
        isPagesMenuOpenAnimal: false,
        isPagesMenuOpenPlant: false,
        isPagesMenuOpenNews: false,
        isPagesMenuOpenBanner: false,
        isPagesMenuOpenUser: false,
        togglePagesMenuAnimal() {
            this.isPagesMenuOpenAnimal = !this.isPagesMenuOpenAnimal
        },
        togglePagesMenuPlant() {
            this.isPagesMenuOpenPlant = !this.isPagesMenuOpenPlant
        },
        togglePagesMenuNews() {
            this.isPagesMenuOpenNews = !this.isPagesMenuOpenNews
        },
        togglePagesMenuBanner() {
            this.isPagesMenuOpenBanner = !this.isPagesMenuOpenBanner
        },
        togglePagesMenuUser() {
            this.isPagesMenuOpenUser = !this.isPagesMenuOpenUser
        },
        // Modal
        isModalOpen: false,
        trapCleanup: null,
        openModal() {
            this.isModalOpen = true
            this.trapCleanup = focusTrap(document.querySelector('#modal'))
        },
        closeModal() {
            this.isModalOpen = false
            this.trapCleanup()
        },
    }
}
