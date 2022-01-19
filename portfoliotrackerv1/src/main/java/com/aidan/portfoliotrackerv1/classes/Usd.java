package com.aidan.portfoliotrackerv1.classes;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
"price",
"volume_24h",
"volume_change_24h",
"percent_change_1h",
"percent_change_24h",
"percent_change_7d",
"percent_change_30d",
"percent_change_60d",
"percent_change_90d",
"market_cap",
"market_cap_dominance",
"fully_diluted_market_cap",
"last_updated"
})
@Generated("jsonschema2pojo")
public class Usd {
	
//price
@JsonProperty("price")
private Double price;

//volume change
@JsonProperty("volume_24h")
private Double volume24h;
@JsonProperty("volume_change_24h")
private Double volumeChange24h;

//percent change
@JsonProperty("percent_change_1h")
private Double percentChange1h;
@JsonProperty("percent_change_24h")
private Double percentChange24h;
@JsonProperty("percent_change_7d")
private Double percentChange7d;
@JsonProperty("percent_change_30d")
private Double percentChange30d;
@JsonProperty("percent_change_60d")
private Double percentChange60d;
@JsonProperty("percent_change_90d")
private Double percentChange90d;

//market cap/dominance
@JsonProperty("market_cap")
private Double marketCap;
@JsonProperty("market_cap_dominance")
private Double marketCapDominance;
@JsonProperty("fully_diluted_market_cap")
private Double fullyDilutedMarketCap;

@JsonProperty("last_updated")
private String lastUpdated;
@JsonIgnore
private Map<String, Object> additionalProperties = new HashMap<String, Object>();

@JsonProperty("price")
public Double getPrice() {
return price;
}

@JsonProperty("price")
public void setPrice(Double price) {
this.price = price;
}

@JsonProperty("volume_24h")
public Double getVolume24h() {
return volume24h;
}

@JsonProperty("volume_24h")
public void setVolume24h(Double volume24h) {
this.volume24h = volume24h;
}

@JsonProperty("volume_change_24h")
public Double getVolumeChange24h() {
return volumeChange24h;
}

@JsonProperty("volume_change_24h")
public void setVolumeChange24h(Double volumeChange24h) {
this.volumeChange24h = volumeChange24h;
}

@JsonProperty("percent_change_1h")
public Double getPercentChange1h() {
return percentChange1h;
}

@JsonProperty("percent_change_1h")
public void setPercentChange1h(Double percentChange1h) {
this.percentChange1h = percentChange1h;
}

@JsonProperty("percent_change_24h")
public Double getPercentChange24h() {
return percentChange24h;
}

@JsonProperty("percent_change_24h")
public void setPercentChange24h(Double percentChange24h) {
this.percentChange24h = percentChange24h;
}

@JsonProperty("percent_change_7d")
public Double getPercentChange7d() {
return percentChange7d;
}

@JsonProperty("percent_change_7d")
public void setPercentChange7d(Double percentChange7d) {
this.percentChange7d = percentChange7d;
}

@JsonProperty("percent_change_30d")
public Double getPercentChange30d() {
return percentChange30d;
}

@JsonProperty("percent_change_30d")
public void setPercentChange30d(Double percentChange30d) {
this.percentChange30d = percentChange30d;
}

@JsonProperty("percent_change_60d")
public Double getPercentChange60d() {
return percentChange60d;
}

@JsonProperty("percent_change_60d")
public void setPercentChange60d(Double percentChange60d) {
this.percentChange60d = percentChange60d;
}

@JsonProperty("percent_change_90d")
public Double getPercentChange90d() {
return percentChange90d;
}

@JsonProperty("percent_change_90d")
public void setPercentChange90d(Double percentChange90d) {
this.percentChange90d = percentChange90d;
}

@JsonProperty("market_cap")
public Double getMarketCap() {
return marketCap;
}

@JsonProperty("market_cap")
public void setMarketCap(Double marketCap) {
this.marketCap = marketCap;
}

@JsonProperty("market_cap_dominance")
public Double getMarketCapDominance() {
return marketCapDominance;
}

@JsonProperty("market_cap_dominance")
public void setMarketCapDominance(Double marketCapDominance) {
this.marketCapDominance = marketCapDominance;
}

@JsonProperty("fully_diluted_market_cap")
public Double getFullyDilutedMarketCap() {
return fullyDilutedMarketCap;
}

@JsonProperty("fully_diluted_market_cap")
public void setFullyDilutedMarketCap(Double fullyDilutedMarketCap) {
this.fullyDilutedMarketCap = fullyDilutedMarketCap;
}

@JsonProperty("last_updated")
public String getLastUpdated() {
return lastUpdated;
}

@JsonProperty("last_updated")
public void setLastUpdated(String lastUpdated) {
this.lastUpdated = lastUpdated;
}

@JsonAnyGetter
public Map<String, Object> getAdditionalProperties() {
return this.additionalProperties;
}

@JsonAnySetter
public void setAdditionalProperty(String name, Object value) {
this.additionalProperties.put(name, value);
}

}