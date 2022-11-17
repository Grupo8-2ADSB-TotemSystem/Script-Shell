FROM openjdk:8-jre
COPY ./Totem_System-1.0-SNAPSHOT-jar-with-dependencies.jar /
#WORKDIR /Java_Totem_System/target/Totem_System-1.0-SNAPSHOT.jar
#RUN java -jar Totem_System-1.0-SNAPSHOT-jar-with-dependencies.jar
CMD ["java", "-jar", "Totem_System-1.0-SNAPSHOT.jar"]
