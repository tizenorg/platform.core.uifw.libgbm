Summary:    Wayland GBM for TIZEN
Name:       libgbm
Version:    1.0.0s
Release:    1
Group:      System/Libraries
License:    MIT

Source0:    %{name}.tar.gz

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
Group:      System/Libraries
Requires:   %{name}

%description devel
Development header files for use with Wayland GBM

%prep
%setup -q -n %{name}

%build
make clean
make libdir=%{_libdir}

%install
mkdir -p %{buildroot}%{_includedir}
mkdir -p %{buildroot}%{_libdir}/pkgconfig

%makeinstall

%post -p /sbin/ldconfig

%postun -p /sbin/ldconfig

%files
%manifest packaging/libgbm.manifest
%defattr(-,root,root,-)
%{_libdir}/libgbm.so

%files devel
%defattr(-,root,root,-)
%{_includedir}/gbm.h
%{_includedir}/gbm/*
%{_libdir}/pkgconfig/gbm.pc
