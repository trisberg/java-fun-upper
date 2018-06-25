FROM maven:3.5-jdk-8-alpine as build
ADD pom.xml ./pom.xml
ADD src ./src
RUN mvn package -DskipTests

FROM projectriff/java-function-invoker:0.0.7
ARG FUNCTION_JAR=/functions/function.jar
ARG FUNCTION_HANDLER=functions.Upper
COPY --from=build /target/*.jar $FUNCTION_JAR
ENV FUNCTION_URI file://${FUNCTION_JAR}?handler=${FUNCTION_HANDLER}
