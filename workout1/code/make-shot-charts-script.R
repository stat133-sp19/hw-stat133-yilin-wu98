##################################################
## title: shots-data-charts
## description: display each player's shots on the nba-court background with different colours indciating whether they shot or not
## inputs:dataframe processed from make-shots-data-script.R(iguodala,green,durant,thompson,curry, gsw_players)
## outputs:andre-iguodala-shot-chart.pdf, draymond-green-shot-chart.pdf, kevin-durant-shot-chart.pdf, klay-thompson-shot-chart.pdf, stephen-curry-shot-chart.pdf, gsw-shot-charts.pdf, gsw-shot-charts.pdf
##################################################
library(ggplot2)
library(grid)
library(jpeg)
klay_scatterplot <- ggplot(data=thompson)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))
klay_scatterplot
court_file <- "../images/nba-court.jpg"
court_image <- rasterGrob(
  readJPEG(court_file),
  width=unit(1,"npc"),
  height=unit(1,'npc'))
#pdf for klay thompson
pdf("../images/klay-thompson-shot-chart.pdf", width=6.5, height=5)
ggplot(data=thompson)+
  annotation_custom(court_image, -250,250,-50, 420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Klay Thompson(2016 season)')+
  theme_minimal()
dev.off()
#pdf for andre iguodala
pdf("../images/andre-iguodala-shot-chart.pdf", width=6.5, height=5)
ggplot(data=iguodala)+
  annotation_custom(court_image, -250,250,-50, 420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Andre Iguodala(2016 season)')+
  theme_minimal()
dev.off()
#pdf for Draymond Green
pdf("../images/draymond-green-shot-chart.pdf", width=6.5, height=5)
ggplot(data=green)+
  annotation_custom(court_image, -250,250,-50, 420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Draymond Green(2016 season)')+
  theme_minimal()
dev.off()
#pdf for kevin durant
pdf("../images/kevin-durant-shot-chart.pdf", width=6.5, height=5)
ggplot(data=durant)+
  annotation_custom(court_image, -250,250,-50, 420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Kevin Durant(2016 season)')+
  theme_minimal()
dev.off()
#pdf for stephen curry
pdf("../images/stephen-curry-shot-chart.pdf", width=6.5, height=5)
ggplot(data=curry)+
  annotation_custom(court_image, -250,250,-50, 420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart: Stephen Curry(2016 season)')+
  theme_minimal()
dev.off()
# pdf for gsw
pdf("../images/gsw-shot-charts.pdf",width=8,height=7)
ggplot(data=gsw_players)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  facet_wrap(~name)+
  ggtitle('Shot Charts:GSW(2016 season)')+
  theme_minimal()
dev.off()
#png for gsw shots
png("../images/gsw-shot-charts.png",width=8,height=7,units='in',res=200)
ggplot(data=gsw_players)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  facet_wrap(~name)+
  ggtitle('Shot Charts:GSW(2016 season)')+
  theme_minimal()
dev.off()

