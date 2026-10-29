// Eleventy settings. Eleventy reads the files in content/ and writes
// finished web pages into _site/, which is what gets published.

export default function (eleventyConfig) {
  // Place files are not turned into pages yet. That comes in a later step,
  // when there is a place-page layout and drafts can be hidden.
  eleventyConfig.ignores.add("content/places/**");

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
