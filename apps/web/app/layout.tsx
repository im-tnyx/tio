import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "TIO Dashboard",
  description: "TIO Health Ecosystem Web Portal",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body style={{ margin: 0, fontFamily: "sans-serif", backgroundColor: "#0b0b0f", color: "#f8f9fa" }}>
        {children}
      </body>
    </html>
  );
}
