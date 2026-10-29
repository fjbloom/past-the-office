// Eleventy settings. Eleventy reads the files in content/ and writes
// finished web pages into _site/, which is what gets published.

// "build" for the live site (npm run build), "serve" for the local preview (npm start).
const isLiveBuild = process.env.ELEVENTY_RUN_MODE === "build";

export default function (eleventyConfig) {
  // Files starting with _ in the places folder (the template) are not places.
  eleventyConfig.ignores.add("content/places/_*.md");

  // The style sample page is for checking the design locally only.
  if (isLiveBuild) {
    eleventyConfig.ignores.add("content/style-sample.njk");
  }

  // Drafts: a place appears on the live site only if its status is "published".
  // In the local preview every place is shown, so you can check drafts.
  // Returning false makes Eleventy skip the file completely.
  eleventyConfig.addPreprocessor("drafts", "md", (data) => {
    const isPlace = data.page.inputPath.includes("/places/");
    if (isLiveBuild && isPlace && data.status !== "published") {
      return false;
    }
  });

  // All places, in alphabetical order, for listing on the home page.
  eleventyConfig.addCollection("places", (collectionApi) =>
    collectionApi
      .getFilteredByGlob("content/places/*.md")
      .sort((a, b) => a.data.name.localeCompare(b.data.name, "en-GB"))
  );

  // Show a date from a place file as, for example, "1 November 2026".
  eleventyConfig.addFilter("readableDate", (date) =>
    new Date(date).toLocaleDateString("en-GB", {
      day: "numeric",
      month: "long",
      year: "numeric",
      timeZone: "UTC",
    })
  );

  // Copy everything in public/ (photos, fonts, styles) to the site as it is.
  eleventyConfig.addPassthroughCopy({ public: "/" });
}

export const config = {
  dir: {
    input: "content",      // where the pages and place files live
    includes: "_includes", // page layouts, inside content/_includes
    output: "_site",       // the built website
  },
};
