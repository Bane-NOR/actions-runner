FROM ghcr.io/actions/actions-runner:2.327.1

COPY  scripts/tools.sh ./tools.sh
RUN sudo chmod +x *.sh
ENV PATH="/home/runner/.local/bin:$PATH"
RUN ./tools.sh
CMD ["/bin/bash"]
