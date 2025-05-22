FROM ghcr.io/actions/actions-runner:2.324.0

COPY  scripts/tools.sh ./tools.sh
RUN sudo chmod +x *.sh
ENV PATH="/root/.local/bin:$PATH"
RUN ./tools.sh
CMD ["/bin/bash"]
