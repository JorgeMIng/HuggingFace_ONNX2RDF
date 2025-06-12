
FROM onnx2rdf-image

# Install Java (OpenJDK 17)
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment Java
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN echo "✅ Java installed"

RUN pip install --upgrade pip

# git clone https://github.com/JorgeMIng/ONNX2RDF.git
# COPY . ONNX2RDF



COPY . /HuggParserLib

WORKDIR /HuggParserLib

RUN pip install .

RUN rm -rf /root/.cache

CMD ["/bin/bash"]
