
--Note: For this assessment, I have use Azure SQL Database

-- Write a query to get the sum of impressions by day.
SELECT date, SUM(impressions) AS total_impressions
FROM marketing_data
GROUP BY date;

-- Write a query to get the top three revenue-generating states in order of best to worst. 
-- How much revenue did the third best state generate?
SELECT TOP 3 state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC;
-- total_revenue generated by the third best state = 37577 (OH - Ohio)

-- Write a query that shows total cost, impressions, clicks, and revenue of each campaign.
-- Make sure to include the campaign name in the output.
SELECT ci.name, 
       SUM(md.cost) AS total_cost, 
       SUM(md.impressions) AS total_impressions,
       SUM(md.clicks) AS total_clicks,
       SUM(wr.revenue) AS total_revenue
FROM campaign_info ci
JOIN marketing_data md ON ci.id = md.campaign_id
JOIN website_revenue wr ON ci.id = wr.campaign_id
GROUP BY ci.name;

-- Write a query to get the number of conversions of Campaign5 by state. 
-- Which state generated the most conversions for this campaign?
SELECT wr.state, 
       SUM(md.conversions) AS total_conversions
FROM marketing_data md
JOIN website_revenue wr ON md.campaign_id = wr.campaign_id AND md.date = wr.date
WHERE md.campaign_id = '99058240'
GROUP BY wr.state
ORDER BY total_conversions DESC;
-- NY state generated the most conversions for this campaign

-- Bonus Question: Write a query that showcases the best day of the week 
-- (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
SELECT FORMAT(date, 'dddd') AS day_of_week, 
       SUM(impressions) AS total_impressions
FROM marketing_data
GROUP BY FORMAT(date, 'dddd')
ORDER BY total_impressions DESC;
-- answer: Friday, because total_impressions for friday = 13674
