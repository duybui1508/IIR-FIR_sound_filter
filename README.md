# Audio Noise Filtering with FIR and IIR Filters in MATLAB

A MATLAB practice project that adds controlled noise to an audio signal, applies an IIR notch filter and an FIR low-pass filter, then compares the results in both the time and frequency domains.

## Project Goals

- Read and normalize an audio signal
- Add 50 Hz sinusoidal noise and white noise
- Remove narrowband 50 Hz interference using an IIR notch filter
- Reduce high-frequency noise using an FIR low-pass filter
- Compare the original, noisy, and filtered signals
- Evaluate filtering performance using SNR

## Processing Pipeline

1. Load `input_audio.wav`
2. Convert stereo audio to mono when necessary
3. Normalize the signal
4. Add simulated 50 Hz noise and white noise
5. Apply an IIR notch filter at 50 Hz
6. Apply an FIR low-pass filter with a 3.5 kHz cutoff frequency
7. Apply the filters separately and in combination
8. Plot waveforms, FFT spectra, and filter frequency responses
9. Export the processed audio files

## Files

- `audio_filter_project.m` — main MATLAB script
- `input_audio.wav` — input audio file
- `audio_noisy.wav` — generated noisy signal
- `audio_iir.wav` — output after IIR notch filtering
- `audio_fir.wav` — output after FIR low-pass filtering
- `audio_both.wav` — output after combined IIR and FIR filtering

The generated output files are created after running the MATLAB script.

## Requirements

- MATLAB
- Signal Processing Toolbox

The script uses functions including:

- `audioread`
- `iirnotch`
- `fir1`
- `filter`
- `fft`
- `freqz`
- `audiowrite`

## How to Run

1. Download or clone this repository.
2. Open MATLAB.
3. Set the repository folder as the current working directory.
4. Make sure `input_audio.wav` is in the same folder as `audio_filter_project.m`.
5. Run:

```matlab
audio_filter_project
```

## Output

The script displays:

- SNR of the noisy signal
- SNR after IIR filtering
- SNR after FIR filtering
- SNR after combined filtering

It also generates:

- Time-domain signal plots
- Frequency-domain spectra using FFT
- Frequency responses of the IIR and FIR filters
- Processed `.wav` files for listening comparison

## Key Parameters

```matlab
f_noise = 50;      % Interference frequency in Hz
fir_order = 100;   % FIR filter order
fc = 3500;         % FIR cutoff frequency in Hz
```

These parameters can be adjusted for different input signals and noise conditions.

## Learning Outcomes

This project was used to practice:

- Basic digital signal processing in MATLAB
- FIR and IIR filter design
- Time-domain and frequency-domain analysis
- FFT-based signal inspection
- SNR-based comparison
- Audio file processing

## Limitations

- The 50 Hz interference is simulated rather than recorded from a real power-line-noise source.
- Filter parameters are selected for this practice example and may need adjustment for other audio files.
- SNR values are used for basic comparison and are affected by the filtering and normalization steps.

## Author

**Bui Duc Duy**  
GitHub: https://github.com/duybui1508
