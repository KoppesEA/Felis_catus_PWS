library(ggplot2)
library(dplyr)

# Function to create bead on a string visualization
create_bead_plot <- function(df, value_column) {
  # Ensure the dataframe has row names
  df <- df %>% 
    tibble::rownames_to_column("label")
  
  # Create the plot
  ggplot(df, aes(x = label, y = 1)) +
    # Draw the string/line
    geom_segment(
      x = 0, xend = nrow(df) + 1, 
      y = 1, yend = 1, 
      color = "gray50", 
      linewidth = 1
    ) +
    # Create colored beads
    geom_point(
      aes(color = !!sym(value_column)), 
      size = 10, 
      shape = 16
    ) +
    # Color scale from blue (low) to red (high)
    scale_color_gradient(
      low = "blue", 
      high = "red", 
      limits = c(0, 1),
      name = "Fraction Value"
    ) +
    # Add value labels
    geom_text(
      aes(label = round(!!sym(value_column), 2)), 
      y = 1.1, 
      vjust = 0,
      size = 3
    ) +
    # Customize theme
    theme_minimal() +
    theme(
      axis.title = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank(),
      panel.grid = element_blank()
    ) +
    # Adjust plot limits
    coord_cartesian(
      ylim = c(0.8, 1.2),
      xlim = c(0.5, nrow(df) + 0.5)
    ) +
    # Add labels to x-axis
    scale_x_discrete(
      limits = df$label,
      position = "top"
    )
}

# Example usage
set.seed(123)
example_df <- data.frame(
  values = runif(10, 0, 0.5)
)

## My usage
p <- create_bead_plot(EKCR_results$summary_me, "FractionReadsWithCpG")
ggsave("bead_plot.png", p, width = 10, height = 3)




# Create and save the plot
p <- create_bead_plot(example_df, "values")
ggsave("bead_plot.png", p, width = 10, height = 3)
