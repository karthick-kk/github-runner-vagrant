FROM karthickk/vagtest

ENV RUNNER_NAME "runner"
ENV GITHUB_PAT ""
ENV GITHUB_RUNNER ""
ENV GITHUB_OWNER ""
ENV GITHUB_REPOSITORY ""
ENV RUNNER_WORKDIR "_work"
ENV RUNNER_LABELS "self-hosted"

USER root
RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        git \
        jq \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo usermod -aG sudo github 

USER github
WORKDIR /home/github

RUN runver=$(curl --silent https://api.github.com/repos/actions/runner/releases/latest | grep '"tag_name":' | cut -d'"' -f4|sed 's/^.//') && echo $runver && curl -Ls https://github.com/actions/runner/releases/download/v$runver/actions-runner-linux-x64-$runver.tar.gz | tar xz 
   

COPY --chown=github:github entrypoint.sh ./entrypoint.sh
RUN sudo chmod u+x ./entrypoint.sh

ENTRYPOINT ["/home/github/entrypoint.sh"]
