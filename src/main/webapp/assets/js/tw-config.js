tailwind.config = {
  theme: { extend: {
    fontFamily: { sans: ['"Plus Jakarta Sans"', 'system-ui', 'sans-serif'] },
    colors: { g9: '#0b3d31', g7: '#12634d', g5: '#2e9e72', mint: '#e4f3ec', line: '#d9e8e0', ink: '#0f2a22', muted: '#5d726a' },
    keyframes: {
      fadeUp: { '0%': { opacity: 0, transform: 'translateY(18px)' }, '100%': { opacity: 1, transform: 'translateY(0)' } },
      ecg: { '0%': { strokeDashoffset: 600 }, '100%': { strokeDashoffset: 0 } },
      floaty: { '0%,100%': { transform: 'translateY(0)' }, '50%': { transform: 'translateY(-10px)' } },
      beat: { '0%,100%': { transform: 'scale(1)' }, '15%': { transform: 'scale(1.18)' }, '30%': { transform: 'scale(1)' }, '45%': { transform: 'scale(1.12)' } }
    },
    animation: {
      fadeUp: 'fadeUp .6s ease-out both',
      ecg: 'ecg 3.2s linear infinite',
      floaty: 'floaty 6s ease-in-out infinite',
      beat: 'beat 1.6s ease-in-out infinite'
    }
  } }
}
