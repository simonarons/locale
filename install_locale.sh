#!/usr/bin/env bash
if ! [[ $(sudo -n uptime 2>&1 | grep -c "load") -eq 1 ]]; then
        echo "$(tput setaf 9)error:$(tput sgr0) you need to be able to sudo to install a new locale"
        exit 1
fi

if ! [[ -d /usr/share/i18n/locales ]]; then
        echo "$(tput setaf 9)error:$(tput sgr0) locale directory '/usr/share/i18n/locales' does not exist"
        exit 1
fi
# if ! [[ -f en_SE ]]; then
#         echo "$(tput setaf 9)error:$(tput sgr0) locale file 'en_se' does not exist in this directory"
#         exit 1
# fi

if ! [[ -f /etc/locale.gen ]]; then
        echo "$(tput setaf 9)error:$(tput sgr0) '/etc/locale.gen' does not exist'"
        exit 1
fi

locale_file="ZXNjYXBlX2NoYXIgLwpjb21tZW50X2NoYXIgJQoKJSBFbmdsaXNoIGxhbmd1YWdlIGxvY2FsZSBmb3IgU3dlZGVuCiUgU291cmNlOiBEYXRvcmbDtnJlbmluZ2VuIFN0YWNrZW4sIEt1bmdsaWdhIFRla25pc2thIGjDtmdza29sYW4KJSBBZGRyZXNzOiBEYXRvcmbDtnJlbmluZ2VuIFN0YWNrZW4sIGMvbyBOQURBLCBLVEgsIDEwMCA0NCBTdG9ja2hvbG0sIFN3ZWRlbgolIENvbnRhY3Q6IE1pa2FlbCBBdW5vCiUgRW1haWw6IGF1bm8rZW5fU0VAc3RhY2tlbi5rdGguc2UKCiUgTGFuZ3VhZ2U6IGVuCiUgVGVycml0b3J5OiBTRQolIFJldmlzaW9uOiAwLjMKJSBEYXRlOiAyMDIxLTEyLTI3CgolIENIQU5HRUxPRwolIC0tLQolIFJldmlzaW9uOiAwLjMKJSBEYXRlOiAyMDIxLTEyLTI3CiUgQ29tbWVudDogQ2hhbmdlZCAiZW5fU0U6MjAwMCIgdG8gImkxOG46MjAxMiIuCiUgLS0tCiUgUmV2aXNpb246IDAuMgolIERhdGU6IDIwMDktMDItMDIKJSBDb21tZW50OiBJbml0aWFsIHJlbGVhc2UKCiUgKlRPRE8vUXVlc3Rpb25zKgolCiUgQXMgdGhpcyBpcyBhIGxvY2FsZSBmb3IgYSBsYW5ndWFnZSB0aGF0IGlzIG5vdCB1c2VkIGluIGdlbmVyYWwgaW4gZG9tZXN0aWMKJSBjb21tdW5pY2F0aW9uIGluIHRoZSBnaXZlbiB0ZXJyaXRvcnkgKGJ1dCB3aGljaCBpcyB1c2VkIHdpZGVseSBieSBjb21wdXRlcgolIGVudGh1c2lhc3RzIGluIGNvbXB1dGVyIHJlbGF0ZWQgc2l0dWF0aW9ucyksIGEgY291cGxlIG9mIHF1ZXN0aW9ucyBhcmlzZSB3aGljaAolIG1pZ2h0IG90aGVyd2lzZSBzZWVtIG9idmlvdXMuCiUKJSBMQ19DT0xMQVRFOiBJcyBjb2xsYXRpb24gYSBwcm9wZXJ0eSBvZiB0aGUgbGFuZ3VhZ2Ugb3IgdGhlIHRlcnJpdG9yeT8gTmFtZXMgb2YKJSBsb2NhbCBwZW9wbGUgYW5kIGxvY2FsIHBsYWNlcyB3aWxsIGRlZmluaXRlbHkgYmUgY29tbXVuaWNhdGVkIGJldHdlZW4gdXNlcnMKJSB3aXRoaW4gYSB0ZXJyaXRvcnksIGJ1dCBob3cgc2hvdWxkIHRoZXNlIG5hbWVzIGJlIHNvcnRlZCB3aXRoIHJlc3BlY3QgdG8KJSBjaGFyYWN0ZXJzIHNwZWNpZmljIHRvIHRoYXQgdGVycml0b3J5LgolCiUgTENfTlVNRVJJQzogSXMgdGhlIGZvcm1hdCBvZiBudW1lcmljIGV4cHJlc3Npb25zIGEgcHJvcGVydHkgb2YgdGhlIGxhbmd1YWdlIG9yCiUgdGhlIHRlcnJpdG9yeT8KJQolIExDX05BTUU6IElzIHRoZSBmb3JtYXQgb2YgdGhlIG5hbWUgcmVwcmVzZW50YXRpb24gYSBwcm9wZXJ0eSBvZiB0aGUgbGFuZ3VhZ2UKJSBvciB0aGUgdGVycml0b3J5PyBJbiBTd2VkaXNoIGluIFN3ZWRlbiBvbmUgd291bGQgd3JpdGUgYSBuYW1lIGFzICJUaG9tYXMKJSBBbmRlcnNzb24iIHdoZXJlYXMgaW4gRW5nbGlzaCBpbiB0aGUgVVMgb25lIHdvdWxkIHdyaXRlICJNci4gVGhvbWFzIEFuZGVyc3NvbiIsCiUgd2hpY2ggd291bGQgYmUgY29ycmVjdCBmb3IgRW5nbGlzaCBpbiBTd2VkZW4/CgpMQ19JREVOVElGSUNBVElPTgp0aXRsZSAgICAgICJFbmdsaXNoIGxvY2FsZSBmb3IgU3dlZGVuIgpzb3VyY2UgICAgICJEYXRvcmY8VTAwRjY+cmVuaW5nZW4gU3RhY2tlbiwgS3VuZ2xpZ2EgVGVrbmlza2EgaDxVMDBGNj5nc2tvbGFuIgphZGRyZXNzICAgICJEYXRvcmY8VTAwRjY+cmVuaW5nZW4gU3RhY2tlbiwgYy9vIE5BREEsIEtUSCwgMTAwIDQ0IFN0b2NraG9sbSwgU3dlZGVuIgpjb250YWN0ICAgICJNaWthZWwgQXVubyIKZW1haWwgICAgICAiYXVubytlbl9TRUBzdGFja2VuLmt0aC5zZSIKdGVsICAgICAgICAiIgpmYXggICAgICAgICIiCmxhbmd1YWdlICAgImVuIgp0ZXJyaXRvcnkgICJTRSIKcmV2aXNpb24gICAiMC4zIgpkYXRlICAgICAgICIyMDIxLTEyLTI3IgolCmNhdGVnb3J5ICAiaTE4bjoyMDEyIjtMQ19JREVOVElGSUNBVElPTgpjYXRlZ29yeSAgImkxOG46MjAxMiI7TENfQ1RZUEUKY2F0ZWdvcnkgICJpMThuOjIwMTIiO0xDX0NPTExBVEUKY2F0ZWdvcnkgICJpMThuOjIwMTIiO0xDX1RJTUUKY2F0ZWdvcnkgICJpMThuOjIwMTIiO0xDX05VTUVSSUMKY2F0ZWdvcnkgICJpMThuOjIwMTIiO0xDX01PTkVUQVJZCmNhdGVnb3J5ICAiaTE4bjoyMDEyIjtMQ19NRVNTQUdFUwpjYXRlZ29yeSAgImkxOG46MjAxMiI7TENfUEFQRVIKY2F0ZWdvcnkgICJpMThuOjIwMTIiO0xDX05BTUUKY2F0ZWdvcnkgICJpMThuOjIwMTIiO0xDX0FERFJFU1MKY2F0ZWdvcnkgICJpMThuOjIwMTIiO0xDX1RFTEVQSE9ORQpFTkQgTENfSURFTlRJRklDQVRJT04KCkxDX0NUWVBFCmNvcHkgInN2X1NFIgpFTkQgTENfQ1RZUEUKCkxDX0NPTExBVEUKY29weSAic3ZfU0UiCkVORCBMQ19DT0xMQVRFCgpMQ19NT05FVEFSWQpjb3B5ICJzdl9TRSIKRU5EIExDX01PTkVUQVJZCgpMQ19OVU1FUklDCmNvcHkgInN2X1NFIgpFTkQgTENfTlVNRVJJQwoKTENfVElNRQphYmRheSAgICI8VTAwNTM+PFUwMDc1PjxVMDA2RT4iOy8KICAgICAgICAiPFUwMDREPjxVMDA2Rj48VTAwNkU+IjsvCiAgICAgICAgIjxVMDA1ND48VTAwNzU+PFUwMDY1PiI7LwogICAgICAgICI8VTAwNTc+PFUwMDY1PjxVMDA2ND4iOy8KICAgICAgICAiPFUwMDU0PjxVMDA2OD48VTAwNzU+IjsvCiAgICAgICAgIjxVMDA0Nj48VTAwNzI+PFUwMDY5PiI7LwogICAgICAgICI8VTAwNTM+PFUwMDYxPjxVMDA3ND4iCmRheSAgICAgIjxVMDA1Mz48VTAwNzU+PFUwMDZFPjxVMDA2ND48VTAwNjE+PFUwMDc5PiI7LwogICAgICAgICI8VTAwNEQ+PFUwMDZGPjxVMDA2RT48VTAwNjQ+PFUwMDYxPjxVMDA3OT4iOy8KICAgICAgICAiPFUwMDU0PjxVMDA3NT48VTAwNjU+PFUwMDczPjxVMDA2ND48VTAwNjE+PFUwMDc5PiI7LwogICAgICAgICI8VTAwNTc+PFUwMDY1PjxVMDA2ND48VTAwNkU+PFUwMDY1PjxVMDA3Mz48VTAwNjQ+PFUwMDYxPjxVMDA3OT4iOy8KICAgICAgICAiPFUwMDU0PjxVMDA2OD48VTAwNzU+PFUwMDcyPjxVMDA3Mz48VTAwNjQ+PFUwMDYxPjxVMDA3OT4iOy8KICAgICAgICAiPFUwMDQ2PjxVMDA3Mj48VTAwNjk+PFUwMDY0PjxVMDA2MT48VTAwNzk+IjsvCiAgICAgICAgIjxVMDA1Mz48VTAwNjE+PFUwMDc0PjxVMDA3NT48VTAwNzI+PFUwMDY0PjxVMDA2MT48VTAwNzk+IgphYm1vbiAgICI8VTAwNEE+PFUwMDYxPjxVMDA2RT4iOy8KICAgICAgICAiPFUwMDQ2PjxVMDA2NT48VTAwNjI+IjsvCiAgICAgICAgIjxVMDA0RD48VTAwNjE+PFUwMDcyPiI7LwogICAgICAgICI8VTAwNDE+PFUwMDcwPjxVMDA3Mj4iOy8KICAgICAgICAiPFUwMDREPjxVMDA2MT48VTAwNzk+IjsvCiAgICAgICAgIjxVMDA0QT48VTAwNzU+PFUwMDZFPiI7LwogICAgICAgICI8VTAwNEE+PFUwMDc1PjxVMDA2Qz4iOy8KICAgICAgICAiPFUwMDQxPjxVMDA3NT48VTAwNjc+IjsvCiAgICAgICAgIjxVMDA1Mz48VTAwNjU+PFUwMDcwPiI7LwogICAgICAgICI8VTAwNEY+PFUwMDYzPjxVMDA3ND4iOy8KICAgICAgICAiPFUwMDRFPjxVMDA2Rj48VTAwNzY+IjsvCiAgICAgICAgIjxVMDA0ND48VTAwNjU+PFUwMDYzPiIKbW9uICAgICAiPFUwMDRBPjxVMDA2MT48VTAwNkU+PFUwMDc1PjxVMDA2MT48VTAwNzI+PFUwMDc5PiI7LwogICAgICAgICI8VTAwNDY+PFUwMDY1PjxVMDA2Mj48VTAwNzI+PFUwMDc1PjxVMDA2MT48VTAwNzI+PFUwMDc5PiI7LwogICAgICAgICI8VTAwNEQ+PFUwMDYxPjxVMDA3Mj48VTAwNjM+PFUwMDY4PiI7LwogICAgICAgICI8VTAwNDE+PFUwMDcwPjxVMDA3Mj48VTAwNjk+PFUwMDZDPiI7LwogICAgICAgICI8VTAwNEQ+PFUwMDYxPjxVMDA3OT4iOy8KICAgICAgICAiPFUwMDRBPjxVMDA3NT48VTAwNkU+PFUwMDY1PiI7LwogICAgICAgICI8VTAwNEE+PFUwMDc1PjxVMDA2Qz48VTAwNzk+IjsvCiAgICAgICAgIjxVMDA0MT48VTAwNzU+PFUwMDY3PjxVMDA3NT48VTAwNzM+PFUwMDc0PiI7LwogICAgICAgICI8VTAwNTM+PFUwMDY1PjxVMDA3MD48VTAwNzQ+PFUwMDY1PjxVMDA2RD48VTAwNjI+PFUwMDY1PjxVMDA3Mj4iOy8KICAgICAgICAiPFUwMDRGPjxVMDA2Mz48VTAwNzQ+PFUwMDZGPjxVMDA2Mj48VTAwNjU+PFUwMDcyPiI7LwogICAgICAgICI8VTAwNEU+PFUwMDZGPjxVMDA3Nj48VTAwNjU+PFUwMDZEPjxVMDA2Mj48VTAwNjU+PFUwMDcyPiI7LwogICAgICAgICI8VTAwNDQ+PFUwMDY1PjxVMDA2Mz48VTAwNjU+PFUwMDZEPjxVMDA2Mj48VTAwNjU+PFUwMDcyPiIKCiUgc3ZfU0UKJSBBcHByb3ByaWF0ZSBkYXRlIGFuZCB0aW1lIHJlcHJlc2VudGF0aW9uICglYSAlZSAlYiAlWSAlSDolTTolUykKZF90X2ZtdCAgICAgIjxVMDAyNT48VTAwNjE+PFUwMDIwPjxVMDAyNT48VTAwNjU+PFUwMDIwPjxVMDAyNT48VTAwNjI+Lwo8VTAwMjA+PFUwMDI1PjxVMDA1OT48VTAwMjA+PFUwMDI1PjxVMDA0OD48VTAwM0E+PFUwMDI1PjxVMDA0RD48VTAwM0E+Lwo8VTAwMjU+PFUwMDUzPiIKCiUgQXBwcm9wcmlhdGUgZGF0ZSByZXByZXNlbnRhdGlvbiAoJVktJW0tJWQpCmRfZm10ICAgICAgICI8VTAwMjU+PFUwMDU5PjxVMDAyRD48VTAwMjU+PFUwMDZEPjxVMDAyRD48VTAwMjU+PFUwMDY0PiIKCiUgQXBwcm9wcmlhdGUgdGltZSByZXByZXNlbnRhdGlvbiAoJUg6JU06JVMpCnRfZm10ICAgICAgICI8VTAwMjU+PFUwMDQ4PjxVMDAzQT48VTAwMjU+PFUwMDREPjxVMDAzQT48VTAwMjU+PFUwMDUzPiIKCiUgU3RyaW5ncyBmb3IgQU0vUE0KYW1fcG0gICAgICAgIiI7IiIKCiUgQXBwcm9wcmlhdGUgQU0vUE0gdGltZSByZXByZXNlbnRhdGlvbgp0X2ZtdF9hbXBtICAiIgoKJSBBcHByb3ByaWF0ZSBkYXRlIHJlcHJlc2VudGF0aW9uIChkYXRlKDEpLCAiJWEgJWUgJWIgJVkgJUguJU0uJVMgJVoiKQpkYXRlX2ZtdCAgICAiPFUwMDI1PjxVMDA2MT48VTAwMjA+PFUwMDI1PjxVMDA2NT48VTAwMjA+PFUwMDI1PjxVMDA2Mj4vCjxVMDAyMD48VTAwMjU+PFUwMDU5PjxVMDAyMD48VTAwMjU+PFUwMDQ4PjxVMDAzQT48VTAwMjU+PFUwMDREPjxVMDAzQT4vCjxVMDAyNT48VTAwNTM+PFUwMDIwPjxVMDAyNT48VTAwNUE+IgoKZmlyc3Rfd2Vla2RheSAyCmZpcnN0X3dvcmtkYXkgMgpFTkQgTENfVElNRQoKTENfTUVTU0FHRVMKY29weSAiZW5fVVMiCkVORCBMQ19NRVNTQUdFUwoKTENfUEFQRVIKY29weSAic3ZfU0UiCkVORCBMQ19QQVBFUgoKTENfVEVMRVBIT05FCmNvcHkgInN2X1NFIgpFTkQgTENfVEVMRVBIT05FCgpMQ19NRUFTVVJFTUVOVApjb3B5ICJzdl9TRSIKRU5EIExDX01FQVNVUkVNRU5UCgpMQ19OQU1FCmNvcHkgInN2X1NFIgpFTkQgTENfTkFNRQoKTENfQUREUkVTUwpjb3B5ICJzdl9TRSIKRU5EIExDX0FERFJFU1MKCg=="

tempfile=$(mktemp)
base64 -d <<<"$locale_file" >"$tempfile"

if [[ $(md5sum /usr/share/i18n/locales/en_SE 2>/dev/null | cut -d ' ' -f1) == "0510ada7054791fd6860a12bae61364c" ]]; then
        if locale -a | grep -q 'en_SE\.utf8'; then
                if grep -q 'en_SE\.UTF-8\ UTF-8' /etc/locale.gen; then
                        echo "locale 'en_SE' already seems to be installed, exiting..."
                        exit 0
                fi
        fi
fi

if [[ -f /usr/share/i18n/locales/en_SE ]]; then
        if [[ $(md5sum /usr/share/i18n/locales/en_SE 2>/dev/null | cut -d ' ' -f1) == "0510ada7054791fd6860a12bae61364c" ]]; then
                if locale -a | grep -q 'en_SE\.utf8'; then
                        if grep -q 'en_SE\.UTF-8\ UTF-8' /etc/locale.gen; then
                                echo "locale 'en_SE' already seems to be installed, exiting..."
                                exit 0
                        fi
                fi
        else
                echo "a '/usr/share/i18n/locales/en_SE' already exists, but a different version, backing it up to '$HOME/en_SE.bak'"
                cp /usr/share/i18n/locales/en_SE "$HOME/en_SE.bak.$(date +%s)"
        fi
fi

echo -n "copying en_SE to /usr/share/i18n/locales: "
if sudo install -o root -g root -m 0644 "$tempfile" /usr/share/i18n/locales/en_SE; then
        echo "$(tput setaf 10)OK$(tput sgr0)"
else
        echo "$(tput setaf 9)error$(tput sgr0) copying en_SE, aborting..."
        exit 1
fi

echo -n "compiling locale en_SE: "
if sudo localedef -i en_SE -f UTF-8 en_SE.UTF-8; then
        echo "$(tput setaf 10)OK$(tput sgr0)"
else
        echo "$(tput setaf 9)error$(tput sgr0) compiling locale, aborting..."
        exit 1
fi

if [[ $(grep -c '^en_SE\.UTF-8\ UTF-8' /etc/locale.gen 2>/dev/null) -gt 0 ]]; then
        echo -n "removing current lines with 'en_SE.UTF-8' from /etc/locale.gen just for the sake of it: "
        cp /etc/locale.gen "$HOME/locale.gen.bak.$(date +%s)"
        if sudo sed -i '/^en_SE\.UTF-8\ UTF-8/d' /etc/locale.gen; then
                echo "$(tput setaf 10)OK$(tput sgr0)"
        else
                echo "$(tput setaf 9)error:$(tput sgr0) couldn't remove en_SE.UTF-8 from /etc/locale.gen, aborting..."
                exit 1
        fi
fi

echo -n "adding 'en_SE.UTF-8 UTF-8' to /etc/locale.gen: "
if echo "en_SE.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen >/dev/null; then
        echo "$(tput setaf 10)OK$(tput sgr0)"
else
        echo "$(tput setaf 9)error$(tput sgr0) adding 'en_SE.UTF-8 UTF-8' to /etc/locale.gen, aborting..."
        exit 1
fi

echo "generating locales..."
if sudo locale-gen; then
        echo "locales generated $(tput setaf 10)OK$(tput sgr0)"
else
        echo "$(tput setaf 9)error$(tput sgr0) generating locales, aborting..."
        exit 1
fi

cp /etc/default/locale "$HOME/locale.bak.$(date +%s)"
if grep -q '#.*en_SE\.UTF-8' /etc/default/locale; then
        echo -n "removing unused 'en_SE' lines from '/etc/default/locale': "
        if sudo sed -i -E '/^#.+en_SE\.UTF-8/d; /^$/d' /etc/default/locale; then
                echo "$(tput setaf 10)OK$(tput sgr0)"
        else
                echo "$(tput setaf 9)NOK$(tput sgr0) - error removing lines from '/etc/default/locales', aborting..."
                exit 1
        fi
fi

echo -n "adding example to '/etc/default/locale': "
if echo -e "\n# Examples for en_SE.UTF-8:\n#LC_ALL=en_SE.UTF-8\n#LC_TIME=en_SE.UTF-8" | sudo tee -a /etc/default/locale >/dev/null; then
        echo "$(tput setaf 10)OK$(tput sgr0)"
else
        echo "$(tput setaf 9)NOK$(tput sgr0) - error adding examples to '/etc/default/locales', aborting..."
        exit 1
fi

echo -n "checking if locale was installed: "
if locale -a | grep -q 'en_SE\.utf8'; then
        echo "$(tput setaf 10)OK$(tput sgr0)"
        echo
        echo "check '/etc/default/locale' for examples"
        echo
        exit 0
else
        echo "$(tput setaf 9)NOK$(tput sgr0) - 'locale -a' didn't show 'en_SE.utf-8', please check manually"
fi
