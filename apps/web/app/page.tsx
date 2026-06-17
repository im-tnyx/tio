import React from "react";

export default function DashboardPage() {
  return (
    <div style={{
      minHeight: "100vh",
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      padding: "20px",
      boxSizing: "border-box"
    }}>
      <div style={{
        maxWidth: "600px",
        width: "100%",
        padding: "40px",
        borderRadius: "24px",
        background: "linear-gradient(145deg, #13141a, #1b1c24)",
        boxShadow: "0 20px 40px rgba(0,0,0,0.5)",
        border: "1px solid #282a36",
        textAlign: "center"
      }}>
        <h1 style={{
          fontSize: "36px",
          margin: "0 0 10px 0",
          background: "linear-gradient(90deg, #4ade80, #3b82f6)",
          WebkitBackgroundClip: "text",
          WebkitTextFillColor: "transparent",
          fontWeight: 700
        }}>
          TIO Health Dashboard
        </h1>
        <p style={{
          fontSize: "16px",
          color: "#9ca3af",
          margin: "0 0 30px 0",
          lineHeight: "1.6"
        }}>
          Adaptive Health Operating System Monorepo Web Portal.
        </p>

        <div style={{
          display: "grid",
          gridTemplateColumns: "1fr 1fr",
          gap: "16px",
          marginBottom: "30px"
        }}>
          <div style={{
            padding: "20px",
            borderRadius: "16px",
            background: "#1f2937",
            border: "1px solid #374151"
          }}>
            <div style={{ fontSize: "12px", color: "#9ca3af", textTransform: "uppercase", marginBottom: "4px" }}>
              Phase 1 Status
            </div>
            <div style={{ fontSize: "18px", color: "#4ade80", fontWeight: 600 }}>
              Log Sync Active
            </div>
          </div>
          <div style={{
            padding: "20px",
            borderRadius: "16px",
            background: "#1f2937",
            border: "1px solid #374151"
          }}>
            <div style={{ fontSize: "12px", color: "#9ca3af", textTransform: "uppercase", marginBottom: "4px" }}>
              Active Client
            </div>
            <div style={{ fontSize: "18px", color: "#3b82f6", fontWeight: 600 }}>
              Flutter Mobile
            </div>
          </div>
        </div>

        <div style={{
          padding: "20px",
          borderRadius: "16px",
          background: "rgba(74, 222, 128, 0.05)",
          border: "1px solid rgba(74, 222, 128, 0.2)",
          color: "#4ade80",
          fontSize: "14px",
          textAlign: "left",
          lineHeight: "1.5"
        }}>
          <strong>💡 Milestone Note:</strong> Phase 1 focuses exclusively on User Profiles & Nutrition Text Logging directly synced to the database. AI services & full Web dashboards will unlock in Phase 2.
        </div>
      </div>
    </div>
  );
}
