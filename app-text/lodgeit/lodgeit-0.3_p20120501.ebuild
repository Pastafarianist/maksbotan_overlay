# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lodgeit/lodgeit-0.3.ebuild,v 1.3 2011/04/05 05:08:05 ulm Exp $

EAPI="4"

MY_REV="b44dee0e6db8"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit python

DESCRIPTION="Command-line interface to paste.pocoo.org"
HOMEPAGE="http://paste.pocoo.org/"
SRC_URI="https://bitbucket.org/EnTeQuAk/lodgeit-main/raw/${MY_REV}/scripts/lodgeit.py
	-> ${P}.py
	vim? ( http://www.vim.org/scripts/download_script.php?src_id=8848
	-> ${P}.vim )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vim"

RESTRICT="test"

DEPEND=""
RDEPEND="
	vim? ( || ( app-editors/vim[python] app-editors/gvim[python] ) )"

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	installation(){
		newbin "${DISTDIR}/${P}.py" "${PN}-${PYTHON_ABI}"
		python_convert_shebangs ${PYTHON_ABI} "${ED}"/usr/bin/${PN}-${PYTHON_ABI}
	}
	python_execute_function installation
	python_generate_wrapper_scripts "${ED}"/usr/bin/${PN}

	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		newins "${DISTDIR}/${P}.vim" "${PN}.vim"
	fi
}
