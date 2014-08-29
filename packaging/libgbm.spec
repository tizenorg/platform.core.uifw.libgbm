Summary:    Wayland Generic Buffer Management for TIZEN
Name:       libgbm
Version:    1.0.0s
Release:    1
Group:      System/X Hardware Support
License:    Unknown

Source0:    %{name}.tar.gz

Provides:   libgbm.so.1.0.0s
Provides:   libgbm.so.1
Provides:   libgbm.so

# Requirements
BuildRequires:  autoconf
BuildRequires:  libtool
BuildRequires:  systemd-devel
BuildRequires:  pkgconfig(libudev)
BuildRequires:  libdrm-devel

%description
Wayland Generic Buffer Management for TIZEN

%package devel
Summary:    Development header files for use with GBM
Group:      Development/Libraries
Requires:   %{name}

%description devel
Development header files for use with gbm

%prep
%setup -q -n %{name}

%build
export GBM_SO_VER=1.0.0s
make

%install
mkdir -p %{buildroot}%{_includedir}
mkdir -p %{buildroot}%{_libdir}/pkgconfig
ln -sf libgbm.so.1.0.0s %{buildroot}%{_libdir}/libgbm.so
ln -sf libgbm.so.1.0.0s %{buildroot}%{_libdir}/libgbm.so.1

export GBM_SO_VER=1.0.0s
%makeinstall

%files
%manifest libgbm.manifest
%defattr(-,root,root,-)
%{_libdir}/libgbm.so.1.0.0s
%{_libdir}/libgbm.so.1

%files devel
%defattr(-,root,root,-)
%{_includedir}/gbm.h
%{_includedir}/gbm/*
%{_libdir}/pkgconfig/libgbm.pc
%{_libdir}/libgbm.so
